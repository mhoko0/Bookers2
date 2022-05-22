class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit]

  def new
    @book = Book.new
    link_to book_path(@book)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @current_user = current_user
    @user = User.find_by(params[:id])
  end

  def show
    @new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def destroy
    book = Book.find(params[:id])
      if book.user.id == current_user.id
        book.destroy
        redirect_to "/books"
      end
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
  unless @book.user == current_user
     redirect_to books_path
  end

  end


end
