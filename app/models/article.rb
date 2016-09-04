class Article < ApplicationRecord
  belongs_to :user
  has_many :article_tags
  has_many :tags, :through => :article_tags
  has_many :comments , :as => :commentable

  TYPE_NEWS = 'News'
  TYPE_SOLUTION = 'Solution'

  scope :news, -> { where(:article_type => TYPE_NEWS) }
  scope :solution, -> { where(:article_type => TYPE_SOLUTION) }

  STATUS_RECYCLE = 0  # 回收站
  STATUS_DRAFT = 1    # 草稿
  STATUS_PUBLISH = 2  # 发布
  STATUS_PINNED = 3   # 置顶


end
