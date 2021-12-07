class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def new
    @book = Book.new
    
  end
  
  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
    
    
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
    
  end

  def create
    @book = Book.new(book_params)
    
    @book.user_id = current_user.id
    
    if @book.save
      flash[:noting] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
     if @book.user != current_user
      redirect_to books_path
     end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
      
    end
  end
  

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book"
    
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
