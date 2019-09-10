class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      flash[:error] = "You can't go to other user's profile!!"
      redirect_to user_path(current_user)
    end
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
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
    params[:user].permit(:first_name, :last_name, :phone_number)
  end
end
