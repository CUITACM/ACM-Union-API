class Comment < ApplicationRecord
  include Likeable

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  belongs_to :parent_comment, class_name: Comment, foreign_key: :parent_id
  has_many :replies, class_name: Comment, foreign_key: :parent_id

  scope :by_article, ->(article_id) {
    where(commentable_type: 'Article', commentable_id: article_id)
  }

end
