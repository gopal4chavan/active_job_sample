class UsersController < ApplicationController
  
  before_action :set_users, only: [:index, :notify_email]
  after_action :clear_xhr_flash, only: [:create, :notify_email]
  before_action :set_user, only: [:destroy]

  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully "
      redirect_to root_path
    else
      respond_to do |format|
        format.js do 
          flash.now[:error] = @user.errors.full_messages.first
          render 'shared/alert_message'
        end
      end
    end
  end

  def new
    @user = User.new
  end

  def destroy
    respond_to do |format|
      format.js do
        if @user.destroy
          flash.now[:notice] = "User successfully Deleted"
        else
          flash.now[:error] = "Seems like we can't remove this user"
        end
        set_users
      end
    end
  end

  def notify_email
    UserNotifierJob.set(wait: 10.seconds).perform_later(params[:id])
    respond_to do |format|
      format.js do
        flash.now[:notice] = "You will recive a email Notification in some time"
        render 'shared/alert_message'
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_users
    @users = User.all || []
  end

  def set_user
    @user = User.find(params['id'])
  end

  def clear_xhr_flash
    if request.xhr?
      flash.discard
    end
  end

end
