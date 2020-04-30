class UsersController < ApplicationController
  
  before_action :set_users, only: [:index, :notify_email]

  def index
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
    render :index
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_users
    @users = User.all || []
  end

end
