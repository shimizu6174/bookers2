class BooksController < ApplicationController
	def index
		@book = Book.new
		book = Book.new(book_params)
		@user = User.find(params[:id])
	end

	def show
	end

	def new
		@book = Book.new
	end

	def create
		book = Book.new(book_params)
		if book.save
			flash[:notice] = "Book was successfully created."
			redirect_to book_path(book)
		else
			redirect_to books_path, flash: { error: book.errors.full_messages }
		end
	end

	def edit
	end
end
