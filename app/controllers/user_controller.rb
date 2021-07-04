class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json: User.all
  end

  def show
  end

  def new
    @user = User.new
    @user.save
  end

  def create
    @user = User.new
    @user.name= params[:name]
    @user.last_name= params[:last_name]
    @user.email= params[:email]
    @user.address= params[:address]
    @user.phone= params[:phone]
    @user.save
    return render json: @user

  end

  def edit
    id = params[:id].to_i
    @user = User.find_by(id: id)
    @user.name= params[:name]
    @user.last_name= params[:last_name]
    @user.email= params[:email]
    @user.address= params[:address]
    @user.phone= params[:phone]
    @user.save
    return render json: @user
  end

  def destroy
    id = params[:id].to_i
    @user = User.find_by(id: id)
    @user.name= params[:name]
    @user.last_name= params[:last_name]
    @user.email= params[:email]
    @user.address= params[:address]
    @user.phone= params[:phone]
    @user.destroy
    return render json:{
      status: "Usuario eliminado"
    }
  end
end
