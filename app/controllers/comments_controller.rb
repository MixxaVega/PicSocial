class CommentsController < ApplicationController

	def create
		@pic = Pic.find(params[:pic_id])
		@comment = @pic.comments.create(body: params[:comment][:body], user_id: current_user.id)
		redirect_to pic_path(@pic)
	end
end
