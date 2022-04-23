module KudosHelper
  def static_button_if_zero(avaible_kudos)
    avaible_kudos.positive? ? 'button is-primary' : 'button is-static'
  end
end
