class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, :through => :article_tags
  has_many :comments , :as => :commentable

  TYPE_NEWS = 'News'
  TYPE_SOLUTION = 'Solution'

  scope :news, -> { where(:type => TYPE_NEWS) }
  scope :solution, -> { where(:type => TYPE_SOLUTION) }

end
