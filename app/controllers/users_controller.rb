class UsersController < ApplicationController
    before_action :authorized, except: [:create, :user_params]

    #creates a new user based on passing validations
    def create
        user = User.create(user_params(:first_name, :last_name, :email, :ideas, :event_id))
        if user.valid?
            render json: user
        else
            render json: {errors: "Name has already been used for this event"}
        end
    end

    private

    #strong params
    def user_params(*args)
        params.require(:users).permit(*args)
    end
end