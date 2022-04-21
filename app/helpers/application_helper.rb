# frozen_string_literal: true

module ApplicationHelper
  def bulma_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      duration = type == 'notice' ? '3000' : '600000'
      type = 'is-success' if type == 'notice'
      type = 'is-danger' if type == 'alert'

      text = "bulmaToast.toast({
      message: '#{message}',
      type: '#{type}',
      dismissible: true,
      duration: #{duration},
      animate: { in: 'fadeIn', out: 'fadeOut' }})"

      flash_messages << text if message
    end.join("\n")
  end
end
