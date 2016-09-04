module Searchable
  extend ActiveSupport::Concern

  included do
    SEARCH_COLUMNS = []
  end

  module ClassMethods
    def with_search(params)
      params[:search] && !params[:search].blank? ?
          self.where(SEARCH_COLUMNS.collect { |key|
            "#{key} LIKE '%#{params[:search]}%'"
          }.join(' OR ')) :
          self
    end
  end

end