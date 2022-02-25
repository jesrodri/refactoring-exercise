require 'rails_helper'

RSpec.describe PurchasesHandler::UserCreator, type: :service do

  describe ".call" do

    context "when cart has a user" do
      let(:cart) { create(:cart) }
      it "returns cart user" do
        expect(PurchasesHandler::UserCreator.call(cart, {})).to eq(cart.user)
      end
    end

    context "when cart does not have a user" do
      let(:cart_without_user) { create(:cart, user: nil) }
      let(:purchase_params) { {
        user: {email: 'user2@spec.io',
          first_name: "Johnny",
          last_name: "Bravo" } }
      }

      it "creates guest user" do
        expect { PurchasesHandler::UserCreator.call(cart_without_user, purchase_params) }.to change(User, :count).by(1)
      end
    end
  end
end
