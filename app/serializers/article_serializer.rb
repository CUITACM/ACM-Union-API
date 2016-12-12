class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :like_times
  attribute :article_type

  attribute :created_at do
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  has_one :user do
    { id: object.user.id, name: object.user.display_name }
  end

  has_many :tags do
    object.tags.map { |tag| tag.name }
  end

end
