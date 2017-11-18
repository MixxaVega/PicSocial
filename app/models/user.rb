class User < ApplicationRecord
	has_many :pics
	has_many :comments
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

	has_attached_file :avatar, style: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	validates :username, presence: { message: "No puede estar vacío."}, length: {minimum: 4, maximum: 35, message: "Inválido"}
	validates :username, uniqueness: true
	validates_format_of :username, :with => /\A[a-zA-Z]+[áÁéÉíÍóÓúÚñÑ]+([a-zA-Z]|\d)*\Z/
end
