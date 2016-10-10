class Resource < ApplicationRecord
  # concern & mixin
  serialize :description, JSON
  mount_uploader :file, ResourceUploader

  # Resource usage def
  USAGE_ARTICLE = "article"
  USAGE_HONOR = "honor"
  USAGE_COVER = "cover"
  USAGE_OTHER = "other"

  # callback
  before_create do
    self.description = {} if description.blank?
  end

end
