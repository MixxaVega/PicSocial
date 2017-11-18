class PicsController < ApplicationController
	respond_to :js, :html

	before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@pics = Pic.all.order("created_at DESC")
	end

	def show
		current_user_is_voter_unvoter
	end

	#- necesita view
	def new 
		@pic = current_user.pics.build
	end

	def create
		@pic = current_user.pics.build(pic_params)

		if @pic.save
			redirect_to @pic, notice: "Publicado!"
		else
			render 'new'
		end
	end

	#-necesita view
	def edit
	end

	def update
		if @pic.update(pic_params)
			redirect_to @pic, notice: "Felicidades! Tu pic fue actualizada"
		else
			render 'edit'
		end
	end

	def destroy
		@pic.destroy
		redirect_to root_path
	end

	def upvote
		if is_up_voter
			@pic.not_vote_by current_user
		else
			@pic.upvote_by current_user
		end
		current_user_is_voter_unvoter
	end

	def downvote
		if is_down_voter
			@pic.not_vote_by current_user
		else
			@pic.downvote_by current_user
		end
		current_user_is_voter_unvoter
	end

	def unvote
		@pic.not_vote_by current_user
		current_user_is_voter_unvoter
	end

	private

	def pic_params
		params.require(:pic).permit(:title, :description, :image)
	end

	def find_pic
		@pic = Pic.find(params[:id])
	end

	def current_user_is_voter_unvoter
		@user_is_down_voter = is_down_voter
		@user_is_up_voter = is_up_voter
	end

	def is_down_voter
		users_down_voters_ids = @pic.get_downvotes.map{|vote| vote.voter_id }
		users_down_voters_ids.include? current_user.id
	end

	def is_up_voter
		users_up_voters_ids = @pic.get_upvotes.map{|vote| vote.voter_id }
		users_up_voters_ids.include? current_user.id
	end
end
