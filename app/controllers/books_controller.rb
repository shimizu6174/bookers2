class BooksController < ApplicationController

	helper_method :get_user

	def get_user(book)
		@user = User.find_by(id: book.user_id)
		return @user
	end

	def index
		@book = Book.new
		@user = User.find(current_user.id)
		@books = Book.all
	end

	def show
		@book = Book.new
		@book_detail = Book.find(params[:id])
		@user = User.find_by(id: @book_detail.user_id)
	end

	def new
		@book = Book.new
	end

	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
		book.save
		redirect_to book_path(book)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		if book.update(book_params)
			flash[:notice] = "Book was successfully updated."
			redirect_to book_path(book)
		else
			redirect_to edit_book_path, flash: { error: book.errors.full_messages }
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
