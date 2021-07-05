class TestController < ApplicationController
    def mail   
        mailer = ApplicationMailer.welcome_email("linav92@gmail.com")
        mailer_response = mailer.deliver_now
        mailgun_message_id = mailer_response.message_id
        return render json:mailer_response
    end
end
