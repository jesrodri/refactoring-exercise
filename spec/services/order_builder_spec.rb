require 'rails_helper'

RSpec.describe PurchasesHandler::OrderBuilder, type: :service do

  describe "#call" do

    context "when order is created" do
      let(:user) { create(:user) }

      it "builds order" do
        expect(PurchasesHandler::OrderBuilder.call(user, {})).to be_valid  
      end
    end

  end
  
end
