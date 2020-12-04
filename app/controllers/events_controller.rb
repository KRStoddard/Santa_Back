class EventsController < ApplicationController
    before_action :find_event, only: [:show, :update, :destroy]
    before_action :authorized, only: [:create, :update, :destroy]
    
    #creates a new event with unique random code
    #if admin asked to be a participant in event it 
    #automatically creates a new user instance with their info
def create
    event = Event.create(event_params(:admin_id, :start, :end, :max_price, :notes))
    while !event.code
        code = SecureRandom.hex(4)
        codes = Event.all.map{|event| event.code}
        if !codes.include? (code)
            event.update({code: code})
        end
    end
    if params[:events][:add].present?
        admin = Admin.find(event.admin_id)
        user = User.create({first_name: admin.first_name, last_name: admin.last_name, email: admin.email, event_id: event.id})
        user.update(event_params(:ideas))
    end
    render json: event
end

#sends back info on event if it exists
def show
    if @event
        render json: @event
    else
        render json: {error: 'no such event code'}
    end
end

#matches all users of event and sends them an email with their match info
def update
    @event.match
    @event.users.each{|user| MatchMailer.match_email(user).deliver_now}
end

#deletes event and its users
def destroy
    @event.users.each{|user| user.destroy}
    @event.destroy
end


private

#strong params
def event_params(*args)
    params.require(:events).permit(*args)
end

#before action to find event
def find_event
    @event = Event.find_by({code: params[:id]})
end

end