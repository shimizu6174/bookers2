class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :confirm_user, only: [:edit,:update]

	def confirm_user
		user = User.find(params[:id])

		unless user == current_user
			redirect_to user_path(current_user)
		end
	end

	def index
		@user = User.find(current_user.id)
		@book = Book.new
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
		@user_book = Book.where(user_id: @user.id)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "Book was successfully updated."
			redirect_to user_path(@user.id)
		else
			render("users/edit")
		end
	end
	private 
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
