class EventsController < ApplicationController
    before_action :find_event, only: [:show, :update, :destroy]
    before_action :authorized, only: [:create, :update, :destroy]
    
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
    event = Event.find_by({code: params[:id]})
    event.match
    event.users.each{|user| MatchMailer.match_email(user).deliver_now}
end

def destroy
    event = Event.find_by({code: params[:id]})
    event.users.each{|user| user.destroy}
    event.destroy
end


private

def event_params(*args)
    params.require(:events).permit(*args)
end

def find_event
    event = Event.find_by({code: params[:id]})
end

end