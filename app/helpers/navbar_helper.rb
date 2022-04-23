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
end
