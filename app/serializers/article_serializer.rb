class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :like_times
  attribute :article_type, key: :type

  attribute :created_at do
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  has_one :user do
    {
        id: object.user.id,
        name: object.user.name
    }
  end

end
