class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit]


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

  def index
    @users = User.all
    @user = User.find_by(params[:id])
    @current_user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @books = @user.books.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
  unless @user == current_user
     redirect_to user_path(current_user)
  end

  end

end