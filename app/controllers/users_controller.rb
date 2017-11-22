class UsersController < ApplicationController
	respond_to :js, :html
	skip_before_action :verify_authenticity_token, only: [:search]
	def index
		@user = params[:user]
		@picss = Pic.all.order("created_at DESC")
		@userss = User.all
		@userss.each do |user|
			if user.username == @user 
				@id= user.id
			end
		end
		@user = User.find(@id)
	end

	def search
		@users = !params.has_key?(:q) || params[:q].blank? ? [] : User.like(params[:q])
	end
end
