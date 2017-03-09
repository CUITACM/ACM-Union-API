class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :like_times
  attribute :article_type

  attribute :summary do
    object.content.present? ? object.content[0, 16] : ''
  end

  attribute :created_at do
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  attribute :updated_at do
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  belongs_to :user do
    { id: object.user.id, name: object.user.display_name }
  end

  has_many :tags do
    object.tags.map { |tag| tag.name }
  end

end
