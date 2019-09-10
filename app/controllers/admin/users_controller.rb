module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all.sort_by { |user| user.is_admin ? 0 : 1 }
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(email: params[:user][:email],
                       password: params[:user][:password])
      if @user.save
        Cart.create(user: @user)
        flash[:success]='User created'
        redirect_to admin_root_path
      else
        redirect_to new_admin_user_path
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_root_path
      else
        render 'edit'
      end
    end

    def destroy
      @user = User.find(params[:id])

      if @user.admin != true
        @user.destroy
        flash[:success] = 'User successfully deleted'
      else
        flash[:error] = "You can't destroy a admin user"
      end
      redirect_to admin_users_path
    end


    private

    def user_params
      params[:user].permit(:first_name, :last_name, :phone_number, :is_admin)
    end
  end
end