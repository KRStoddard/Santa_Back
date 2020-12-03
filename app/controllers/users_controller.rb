class UsersController < ApplicationController

    def create
        user = User.create(user_params(:first_name, :last_name, :email, :event_id))

        if user.valid?
            render json: user
        else
            render json: {error: "Invalid"}
        end
    end

    private

    def user_params(*args)
        params.require(:users).permit(*args)
    end
end