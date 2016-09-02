class Article < ApplicationRecord
  belongs_to :user
  has_many :article_tags
  has_many :tags, :through => :article_tags
  has_many :comments , :as => :commentable

  TYPE_NEWS = 'News'
  TYPE_SOLUTION = 'Solution'

  scope :news, -> { where(:type => TYPE_NEWS) }
  scope :solution, -> { where(:type => TYPE_SOLUTION) }

  STATUS_DRAFT = 0    # 草稿
  STATUS_PUBLISH = 1  # 发布
  STATUS_RECYCLE = 2  # 回收站

end
