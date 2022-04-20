# frozen_string_literal: true

module ApplicationHelper
  def bulma_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'is-success' if type == 'notice'
      type = 'is-danger' if type == 'alert'

      text = "<script>bulmaToast.toast({
      message: '#{message}',
      type: '#{type}',
      dismissible: true,
      animate: { in: 'fadeIn', out: 'fadeOut' }})</script>"

      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end
end
