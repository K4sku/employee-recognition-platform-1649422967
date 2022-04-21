# frozen_string_literal: true

module ApplicationHelper
  def bulma_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      duration = type == 'notice' ? '3000' : '600000'
      type = 'is-success' if type == 'notice'
      type = 'is-danger' if type == 'alert'

      text = "<script>bulmaToast.toast({
      message: '#{message}',
      type: '#{type}',
      dismissible: true,
      duration: #{duration},
      animate: { in: 'fadeIn', out: 'fadeOut' }})</script>"

      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end
end
