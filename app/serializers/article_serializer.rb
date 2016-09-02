class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :like_times
  attribute :article_type, key: :type

  has_one :user do
    {
        id: object.user.id,
        name: object.user.name
    }
  end

end
