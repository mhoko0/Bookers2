class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path
    else
      render signup
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to users_path
    else
      render edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end

end