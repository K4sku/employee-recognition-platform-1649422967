require 'csv'

class ImportRewardsService
  attr_reader :errors

  def initialize(source)
    @source = source
    @errors = []
  end

  def call
    validate_headers
    import_from_source

    transaction_with_error_handling do
      @imported_rewards.save!
    end
  end

  private

  def import_from_source
    @imported_rewards = []
    CSV.foreach(@source, headers: true) do |row|
      @imported_rewards.push(Reward.new(
                               title: row['title'],
                               description: row['description'],
                               price: row['price'],
                               categories: Category.where(title: row['categories'].split)
                             ))
    end
  end

  def transaction_with_error_handling(&block)
    ActiveRecord::Base.transaction(requires_new: true, &block)
  rescue ActiveRecord::ActiveRecordError => e
    failure(e.message)
  end

  def failure(message)
    errors.push(message)
    false
  end
end
