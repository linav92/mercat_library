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
  
    def edit
    end
  
    def create
      @book = Book.new
      @book.title= params[:title]
      @book.author= params[:author]
      @book.save
      p @book
      return render json: @book
    end
  
    def upgrade
    end
  
    def destroy
    end
end
