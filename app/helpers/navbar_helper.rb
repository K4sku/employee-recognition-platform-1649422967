module NavbarHelper
  def style_avaible_kudos(avaible_kudos)
    case avaible_kudos
    when 0
      content_tag :span, "Available kudos: #{avaible_kudos}", class: 'tag is-large is-danger is-light',
                                                              id: 'available_kudos_counter'
    when 1..2
      content_tag :span, "Available kudos: #{avaible_kudos}", class: 'tag is-large is-warning is-light',
                                                              id: 'available_kudos_counter'
    when 3..10
      content_tag :span, "Available kudos: #{avaible_kudos}", class: 'tag is-large is-success is-light',
                                                              id: 'available_kudos_counter'
    end
  end

  def display_curent_users_email_on_test_or_development(user)
    return unless ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'development'

    content_tag :span, class: 'navbar-item', id: "current_#{user.class.name.downcase}_email" do
      "#{user.class.name}: #{user.email}"
    end
  end

  def undelivered_orders_count
    @undelivered_orders_count ||= Order.not_delivered.count
  end
end
