class Article < ApplicationRecord
  # concern
  include Commentable
  include Searchable
  SEARCH_COLUMNS << :title << :content

  # relations
  belongs_to :user
  has_many :article_tags
  has_many :tags, :through => :article_tags

  # Article type def
  TYPE_NEWS = 'News'
  TYPE_SOLUTION = 'Solution'

  # Article status def
  STATUS_RECYCLE = 0  # 回收站
  STATUS_DRAFT = 1    # 草稿
  STATUS_PUBLISH = 2  # 发布
  STATUS_PINNED = 3   # 置顶

  # scope
  scope :news, -> { where(:article_type => TYPE_NEWS) }
  scope :solution, -> { where(:article_type => TYPE_SOLUTION) }

end
