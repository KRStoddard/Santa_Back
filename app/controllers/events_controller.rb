class EventsController < ApplicationController
    
def create
    code = SecureRandom.hex(4)
    event = Event.create(event_params(:admin_id, :start, :end, :max_price, :notes))
    event.update({code: code})
    if params[:events][:add].present?
        admin = Admin.find(event.admin_id)
        User.create({first_name: admin.first_name, last_name: admin.last_name, email: admin.email, event_id: event.id})
    end
    render json: event
end

def show
    event = Event.find_by({code: params[:id]})
    if event
        render json: event
    else
        render json: {error: 'no such event code'}
    end
end

def update
    puts "hits update"
    event = Event.find_by({code: params[:id]})
    puts event
    event.match
    event.users.each{|user| MatchMailer.match_email(user).deliver_now}
end


private

def event_params(*args)
    params.require(:events).permit(*args)
end

end