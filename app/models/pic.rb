class Pic < ApplicationRecord
	has_many :comments, dependent: :destroy
	acts_as_votable
	belongs_to :user

	has_attached_file :image, style: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	def not_vote_by user
		votes = Vote.where(votable_id: id, voter_id: user.id)
		votes.delete_all
	end
end
