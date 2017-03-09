class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description
  attributes :commentable_id, :commentable_type
  attributes :parent_id, :like_times

  attribute :created_at do
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  attribute :updated_at do
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  belongs_to :user do
    u = object.user
    { id: object.user.id, name: u.display_name, avatar: u.avatar.url }
  end

  belongs_to :parent_comment, serializer: CommentSerializer


end
