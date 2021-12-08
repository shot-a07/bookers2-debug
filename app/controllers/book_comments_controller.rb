class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    if comment.save
    render :book_comments, notice: 'コメントを投稿しました'
    else
      @new_book = Book.new
      @book_comment = BookComment.new
      render 'books/show'
    end
    
    
  end
  
  
  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
    render :book_comments alert: 'コメントを削除しました'
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
