require 'rails_helper'

RSpec.describe PurchasesHandler::OrderBuilder, type: :service do

  describe ".call" do

    let(:user) { create(:user) }

    it "builds order" do
      order = PurchasesHandler::OrderBuilder.call(user, {})
      expect(order).to have_attributes(:user_id => 1, :first_name => "John", :last_name => "Doe", :address_1 => nil, :address_2 => nil, :city => nil, :state => nil, :country => nil, :zip => nil)
    end
  end
end
