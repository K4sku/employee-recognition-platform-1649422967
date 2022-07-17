module OrdersHelper
  def active_if_filter_selected(query)
    'is-active' if request.params[:query] == query
  end
end
