class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.with_sort(params)
    if params[:sort_field]
      sort_order = params[:sort_order] == 'ascend' ? 'asc' : 'desc'
      self.order("#{params[:sort_field]} #{sort_order}")
    else
      self.order("")
    end
  end

  def self.with_search(params)
    if params[:search] && !params[:search].blank?
      self.where(SEARCH_COLUMNS.collect { |key|
        "#{key} LIKE '%#{params[:search]}%'"
      }.join(' OR '))
    else
      self.where("")
    end
  end

  def self.with_filters(params)
    filters_params = params[:filters]
    if !filters_params.blank?
      wheres = {}
      filters_params.each { |key, value| wheres.store(key, value) }
      self.where(wheres)
    else
      self.where("")
    end
  end

end
