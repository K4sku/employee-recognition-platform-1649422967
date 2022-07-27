module OrdersHelper
  def active_if_filter_selected(query)
    if request.params[:status] == query ||
       (query == 'all' && request.params[:status].nil?)
      'is-active'
    end
  end
end
