class FilterLinksPresenter
  def initialize(view, filter_key)
    @view = view
    @filter_key = filter_key
  end

  def styled_link_to_filter_query(request, filter_argument)
    @view.content_tag :li, class: conditional_active(request.params, filter_argument) do
      @view.link_to filter_argument, "#{request.path}?#{@filter_key}=#{filter_argument}"
    end
  end

  def conditional_active(request_params, filter_argument)
    'is-active' if request_params.fetch(@filter_key, '') == filter_argument
  end
end
