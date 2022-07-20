module OrdersHelper
  def active_if_filter_selected(query)
    if request.params[:query] == query ||
       (query == 'all' && request.params[:query].nil?)
      'is-active'
    end
  end
end
