class UsersController < ApplicationController
    before_action :authorized, except: [:create, :user_params]

    def create
        user = User.create(user_params(:first_name, :last_name, :email, :ideas, :event_id))
        if user.valid?
            render json: user
        else
            render json: {errors: "Name has already been used for this event"}
        end
    end

    private

    def user_params(*args)
        params.require(:users).permit(*args)
    end
end