class RelationshipsController < ApplicationController
  def follow_user
  	@user = User.find_by(username: params[:username])
  	if current_user.follow @user.id
  		respond_to do |format|
  			format.html { redirect_to users_index_path(:user => @user.username) }
  			format.js
  		end
  	end
  end

  def unfollow_user
  	@user = User.find_by(username: params[:username])
  	if current_user.unfollow @user.id
  		respond_to do |format|
  			format.html { redirect_to users_index_path(:user => @user.username) }
  			format.js
  		end
  	end
  end
end
