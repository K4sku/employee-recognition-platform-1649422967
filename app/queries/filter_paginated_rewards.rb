class FilterPaginatedRewards
  module Scopes
    def by_category(category)
      return self if category.blank?

      where("categories.title = '#{category}'")
        .references(:categories)
    end
  end

  def self.call(filters)
    Reward
      .with_attached_image
      .includes(:categories)
      .extending(Scopes)
      .by_category(filters[:category])
      .page(filters[:page])
  end
end
