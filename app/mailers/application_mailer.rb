class ApplicationMailer < ActionMailer::Base
  default from: 'noresponder@bizzx.com'

  layout 'mailer'

  def welcome_email(book)
    @book = book
    mail(to: book.user.email, subject: "¡Bienvenido a Library!").tap do |message|
      message.mailgun_options = {
        "tag" => ["abtest-option-a", "beta-user"],
        "tracking-opens" => true,
        "tracking-clicks" => "htmlonly"
      }
    end
  end
end
