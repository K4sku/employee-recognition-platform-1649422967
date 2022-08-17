module DataMigrations
  CommitForbidden = Class.new(StandardError)

  class UpdateRewardCategoriesWhereNull
    def self.call(commit_changes: false)
      ActiveRecord::Base.transaction do
        @placeholder_category = Category.find_or_create_by(title: 'Placeholder')
        Reward.where.missing(:categories).each do |reward|
          reward.categories << @placeholder_category
        end

        raise CommitForbidden unless commit_changes
      end
    end
  end
end
