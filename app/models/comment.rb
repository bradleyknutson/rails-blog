class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :comments, foreign_key: "parent_comment_id"
end
