class SessionsController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] ="Welcome to Seminar Search"
      redirect_to seminars_path , success: 'Welcome to Seminar Search'

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = "Goodbye"
    redirect_to seminars_path

  end
  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email, :password,:password_confirmation)
  end

end
