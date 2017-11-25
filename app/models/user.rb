class User < ApplicationRecord
	has_many :pics, dependent: :destroy

	has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow", dependent: :destroy
	has_many :followers, through: :follower_relationships, source: :follower
	
	has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
	has_many :following, through: :following_relationships, source: :following
	

	has_many :comments, dependent: :destroy
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

	has_attached_file :avatar, style: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	scope :like, proc{ |q| where("username LIKE ?", "%#{q}%") }

	validates :username, presence: { message: "No puede estar vacío."}, length: {minimum: 4, maximum: 35, message: "Inválido"}
	validates :username, :uniqueness => { :case_sensitive => false }
	validates_format_of :username, :with => /\A[a-zA-ZáéíóúÁÉÍÓÚÑñ0-9]*\z/

	attr_accessor :url

	#follow another user
	def follow(user_id)
		following_relationships.create(following_id: user_id)
	end

	#unfollow a user
	def unfollow(user_id)
		user = following_relationships.find_by(following_id: user_id)
		puts "unfollow user: #{user.class.name}"
		user.destroy
	end

	#is following a user?
	def following?(other)
		following.include?(other)
	end
end