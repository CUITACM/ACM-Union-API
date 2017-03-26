class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :user_id, :user_name, :user_avatar
  attributes :commentable_id, :commentable_type
  attributes :like_times

  attribute :created_at do
    object.created_at.strftime('%Y-%m-%d %H:%M')
  end

  attribute :updated_at do
    object.updated_at.strftime('%Y-%m-%d %H:%M')
  end

  belongs_to :parent_comment, serializer: CommentSerializer


end
