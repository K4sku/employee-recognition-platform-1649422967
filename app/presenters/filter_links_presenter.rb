class FilterLinksPresenter
  def initialize(view, filter_key:, default_selected_link: '')
    @view = view
    @filter_key = filter_key
    @default_selected_link = default_selected_link
  end

  def styled_link_to_filter_query(request, filter_argument)
    link_selected = link_selected?(request.params, filter_argument)
    @view.content_tag :li, class: active_class(link_selected) do
      if link_selected
        @view.link_to filter_argument, controller: request.parameters[:controller], action: 'index'
      else
        @view.link_to filter_argument, controller: request.parameters[:controller], action: 'index', @filter_key => filter_argument
      end
    end
  end

  def link_selected?(request_params, filter_argument)
    request_params.fetch(@filter_key, '') == filter_argument ||
      (filter_argument == @default_selected_link && !request_params.key?(@filter_key))
  end

  def active_class(link_selected)
    'is-active' if link_selected
  end
end
