class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    book.save
    redirect_to @book = Book.find(params[:id])
  end

  def index
    @user = current_user
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
