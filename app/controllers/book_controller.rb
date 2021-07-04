class BookController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
      @books = Book.all
      return render json: @books
    end
  
    def show
    end
   
    def new
      @book = Book.new
      @book.save
    end
  
    def create
      @book = Book.new
      @book.title= params[:title]
      @book.author= params[:author]
      @book.save
      return render json: @book
    end
  
    def edit
        id = params[:id].to_i
        @book = Book.find_by(id: id)
        @book.title= params[:title]
        @book.author= params[:author]
        @book.save
        return render json: @book
    end
  
    def destroy
      id = params[:id].to_i
      @book = Book.find_by(id: id)
      @book.title= params[:title]
      @book.author= params[:author]
      @book.destroy
      return render json:{
        status: "Libro eliminado"
    }
    end
end
