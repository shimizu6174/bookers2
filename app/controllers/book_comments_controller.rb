class BookCommentsController < ApplicationController

	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_back(fallback_location: books_path)
	end

	def destroy
		comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])

		if comment.user == current_user
			comment.destroy
		end

		redirect_back(fallback_location: books_path)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:body, :book_id)
	end
end
