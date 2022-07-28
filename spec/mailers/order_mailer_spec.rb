require 'rails_helper'

describe OrderMailer, type: :mailer do
  describe 'notify about order delivery' do
    let(:order) { build(:order) }
    let(:mail) { described_class.with(order: order).order_delivered_email }

    it 'renders headers' do
      expect(mail.subject).to eq('Your order has been delivered!')
      expect(mail.to).to eq([order.employee.email])
      expect(mail.from).to eq(['erp-info@cklos.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(order.reward.title)
      expect(mail.body.encoded).to match(order.reward.description)
      expect(mail.body.encoded).to match(order.reward.price.to_s)
      expect(mail.body.encoded).to match(order.created_at.strftime('%F'))
    end
  end
end
