require_relative '../../db/data_migrations/update_reward_categories_where_null'

namespace :data_migrations do
  desc 'Set reward category to \'Placeholder\' where there is no category (pass [true] to perform action on database.'
  task :update_reward_categories_where_null, [:commit_changes] => [:environment] do |_t, args|
    DataMigrations::UpdateRewardCategoriesWhereNull.call(commit_changes: args.commit_changes)
  end
end
