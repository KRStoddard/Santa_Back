class AdminController < ApplicationController


    def create
        admin = Admin.create(admin_params(:first_name, :last_name, :email, :password))
        if admin.valid?
            token = encode_token({admin_id: admin.id})
            render json: {admin: admin, token: token}
        else
            render json: {errors: admin.errors.full_messages}
        end
    end

    def login
        admin = Admin.find_by(email: params[:email])
        puts admin
        if admin && admin.authenticate(params[:password])
            token = encode_token({admin_id: admin.id})
            render json: {admin: admin, token: token} 
        else
            render json: {errors: "Invalid email/password combination"}
        end
    end

    def auto_login
        render json: logged_in_user

    private

    def admin_params(*args)
        params.require(:admin).permit(*args)
    end

end