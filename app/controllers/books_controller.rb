class BooksController < ApplicationController

	helper_method :get_user
	before_action :authenticate_user!
	before_action :confirm_user, only: [:edit,:update]

	def get_user(book)
		@user = User.find_by(id: book.user_id)
		return @user
	end

	def confirm_user
		book = Book.find(params[:id])
		user = get_user(book)

		unless user == current_user
			redirect_to books_path
		end
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

		if current_user == @user
			@path = edit_book_path
		else
			@path = books_path
		end
	end

	def new
		@book = Book.new
	end

	def create

		@book = Book.new(book_params)
		@books = Book.all
		@user = User.find(current_user.id)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "Book was successfully created"
			redirect_to book_path(current_user)
		else
			render("books/index")
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "Book was successfully updated."
			redirect_to book_path(@book)
		else
			render("books/edit")
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
