class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
    if @book_comment.save
    flash[:notice]= 'コメントを投稿しました'
    else
      @new_book = Book.new
      @book_comment = BookComment.new
      render 'books/show'
    end
    
    
  end
  
  
  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
    @book_comment.destroy
    render :book_comments, alert: 'コメントを削除しました'
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
