class MatchMailer < ApplicationMailer

    def match_email(user)
        @user = user
        @match = User.find(@user.match)
        mail(to: @user.email, subject: "Your Secret Santa Match!")
    end
end
