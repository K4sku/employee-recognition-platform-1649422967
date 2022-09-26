require 'csv'

class ImportRewardsService
  attr_reader :errors, :record_count

  def initialize(source, headers)
    @source = source
    @headers = !headers.nil?
    @errors = []
    @record_count = []
    @imported_rewards_attributes = []
    @imported_rewards = []
  end

  def call
    parse_rewards_attributes
    validate_titles_uniqueness
    return false if @errors.any?

    build_reward_objects
    transaction_with_error_handling do
      @imported_rewards.each(&:save!)
    end
  end

  private

  def parse_rewards_attributes
    header_converter = ->(header) { header.strip.downcase.singularize }
    row_converter = ->(field) { (field || '').strip }
    begin
      CSV.foreach(@source, converters: row_converter, headers: @headers, header_converters: header_converter,
                           skip_blanks: true,
                           empty_value: '') do |row|
        @imported_rewards_attributes.push({
          title: (row[@headers ? 'title' : 0]),
          description: (row[@headers ? 'description' : 1]),
          price: (row[@headers ? 'price' : 2]),
          categories: (row[@headers ? 'category' : 3])
        })
      end
    rescue CSV::MalformedCSVError => e
      failure(e.message)
      false
    end
  end

  def validate_titles_uniqueness
    titles = []
    @imported_rewards_attributes.each do |entry|
      if titles.include?(entry[:title])
        @errors.push(
          "Duplicated entry with title '#{entry[:title]}'. Rewards names must be unique."
        )
      end
      titles.push(entry[:title])
    end
  end

  def build_reward_objects
    @imported_rewards_attributes.each do |entry|
      reward = Reward.find_or_initialize_by(title: entry[:title])
      reward.description = entry[:description]
      reward.price = entry[:price]
      categories = []
      entry[:categories].split.each do |category|
        categories << Category.find_by(title: category)
      end
      if categories.any?(&:nil?)
        reward.categories.clear
      else
        reward.categories = categories
      end
      @imported_rewards << reward
    end
    @record_count = @imported_rewards.size
  end

  def transaction_with_error_handling(&block)
    ActiveRecord::Base.transaction(requires_new: true, &block)
  rescue ActiveRecord::ActiveRecordError => e
    message = "#{'Error'.pluralize(e.record.errors.size)} for '#{e.record.title}': " \
              "#{e.record.errors.full_messages.join('; ')}"
    failure(message)
  end

  def failure(message)
    errors.push(message)
    false
  end
end
