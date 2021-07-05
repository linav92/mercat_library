class LendingController < ApplicationController
    skip_before_action :verify_authenticity_token
    def libro_prestado
        #buscar si existe el libro
        id = params[:book_id]
        @books = Book.find_by(id: id)
        if @books == nil
            return render json:{
                status: "El libro no existe"
            }
        end
        #ver el estado
       
        @book = UserBook.find_by(book_id: id)
        if @book != nil && @book.status == 0
            return render json:{
                status: "El libro se encuentra prestado"
            }
        end

        #pedir prestado el libro
        @book = UserBook.new
        @book.status = 0
        @book.user_id = params[:user_id]
        @book.book_id = params[:book_id]
        @book.lending_at = Time.now.strftime("%F %H:%M")
        @book.expire = Time.now + 10.days
        @book.save
        mailer = ApplicationMailer.welcome_email(@book )
        mailer_response = mailer.deliver_now
        mailgun_message_id = mailer_response.message_id
        return render json: @book

    end
end
