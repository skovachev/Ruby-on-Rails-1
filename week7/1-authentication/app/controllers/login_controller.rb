class LoginController < ApplicationController

  skip_before_filter :require_login

  def sign_up
    @user = User.new
  end

  def sign_in

  end

  def sign_up_do
    @user = User.new(user_params)
    puts user_params
    if @user.save
      flash[:notice_ok] = 'Account created successfully.'
      redirect_to action: 'sign_in'
    else
      render 'sign_up'
    end
  end

  def logout
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_url, :notice_ok => "Logged out!"
  end

  def sign_in_do
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
      redirect_to root_url, :notice_ok => "Logged in!"
    else
      flash[:notice_err] = "Invalid email or password"
      render "sign_in"
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end

end
