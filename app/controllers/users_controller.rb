class UsersController < ApplicationController
  def index
    @users = User.all || []
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully "
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages.first
      render :new
    end
  end

  def new
    @user = User.new
  end

  def notify_email
    UserNotifierJob.set(wait: 10.seconds).perform_later(params[:id])
    flash.now[:success] = "Notification sent successfully"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
