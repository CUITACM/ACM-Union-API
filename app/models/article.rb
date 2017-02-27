class Article < ApplicationRecord
  # concern
  include Commentable
  include Likeable

  # relations
  belongs_to :user
  has_many :article_tags
  has_many :tags, through: :article_tags

  # Article type def
  TYPE_NEWS = 'News'
  TYPE_SOLUTION = 'Solution'

  # Article status def
  STATUS_RECYCLE  = 0   # 回收站
  STATUS_DRAFT    = 1   # 草稿
  STATUS_PUBLISH  = 2   # 发布
  STATUS_PINNED   = 3   # 置顶

  # scope
  scope :news, -> { where(:article_type => TYPE_NEWS) }
  scope :solution, -> { where(:article_type => TYPE_SOLUTION) }

  def self.search_columns
    [:title, :content]
  end

  def publish?
    self.status >= 2
  end

  def update_with_tags(tags, args)
    if tags.present?
      new_tags = tags.map do |v|
        tag = Tag.find_by(name: v) || Tag.create(name: v)
        tag
      end
      puts new_tags
      self.tags = new_tags
    end
    self.update_attributes(args)
  end

end
