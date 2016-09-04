class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ant_sort(params)
    if params[:sort_field]
      sort_order = params[:sort_order] == 'ascend' ? 'asc' : 'desc'
      self.order("#{params[:sort_field]} #{sort_order}")
    else
      self
    end
  end

end
