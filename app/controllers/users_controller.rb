class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      flash[:error] = "Vous n'avez pas le droit d'accéder au profil d'autres utilisateurs!!"
      redirect_to user_path(current_user)
    end
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
    @cities = City.all
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Votre profil vient d'être édité avec succès!"
      redirect_to user_path(@user.id)
    else
      flash[:error] = "Votre profil n'a pas pu être édité..."
      render :edit
    end
  end

  def destroy
  end

  def user_params
    params[:user].permit(:first_name, :last_name, :phone_number, :city_id)
  end
end
