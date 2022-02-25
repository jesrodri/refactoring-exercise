require 'rails_helper'

RSpec.describe PurchasesHandler::OrderBuilder, type: :service do

  describe ".call" do

    let(:user) { create(:user) }

    it "builds order" do
      order = PurchasesHandler::OrderBuilder.call(user, {})
      expect(order).to be_valid  
    end
  end
end
