class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.email.downcase!

    if @user.save
      redirect_to root_path, notice: "Account created successfully!"
    else
      redirect_to new_user_path, alert: "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
