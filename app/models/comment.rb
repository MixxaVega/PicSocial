class Comment < ApplicationRecord
  belongs_to :pic
  belongs_to :user

  validates :body,  length: { maximum: 250, message: "Comentario demasiado largo"}
end
