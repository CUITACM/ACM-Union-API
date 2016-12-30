class Comment < ApplicationRecord
  include Likeable

  belongs_to :commentable, polymorphic: true

  belongs_to :parent_comment, class_name: Comment, foreign_key: :parent_id
  has_many :replies, class_name: Comment, foreign_key: :parent_id
end
