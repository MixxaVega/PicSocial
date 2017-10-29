class UsersController < ApplicationController

	def index
		@user = params[:user]
		@picss = Pic.all.order("created_at DESC")
		@userss = User.all
		@userss.each do |user|
			if user.email == @user 
				@id= user.id
			end
		end
	end
end
