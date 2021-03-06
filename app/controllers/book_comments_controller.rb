class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      redirect_to book_path(@book)
    else
      flash[:nocomment] = 'comment blank error'
      redirect_to book_path(@book)
    end
  end

  def destroy
    @delcomment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @delcomment.destroy
    redirect_to book_path(params[:book_id])
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id)
  end

end
