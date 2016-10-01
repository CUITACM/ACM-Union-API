class Resource < ApplicationRecord
  # concern & mixin
  mount_uploader :file, ResourceUploader

  USAGE_ARTICLE = "article"
  USAGE_HONOR = "honor"
  USAGE_COVER = "cover"
  USAGE_OTHER = "other"

end
