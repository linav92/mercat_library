class ReturnedController < ApplicationController
    skip_before_action :verify_authenticity_token
    def libro_devuelto
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
        if @book == nil || @book.status == 1
            return render json:{
                status: "El libro se encuentra devuelto"
            }
        end

        #devolver el libro
        id = params[:id]
        @book = UserBook.find_by(id: id)
        @book.status = 1
        @book.user_id = params[:user_id]
        @book.book_id = params[:book_id]
        @book.returned_at = Time.now
        @book.save
        return render json: @book, include: ['book','user']
    end
end
