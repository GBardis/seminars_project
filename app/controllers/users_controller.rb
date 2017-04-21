class UsersController < ApplicationController
    
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
    def show
    @user = User.find(params[:id])
  end

    def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] ="Welcome to Seminar Search"
      redirect_to seminars_path , success: 'Welcome to Seminar Search'
    else
      render 'new'
    end
  end


  
  private

    def user_params
      params.require(:user).permit(:first_name,:last_name, :email,:attendee, :password,:password_confirmation)
    end
end
