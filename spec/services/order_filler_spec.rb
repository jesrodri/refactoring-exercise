require 'rails_helper'

RSpec.describe PurchasesHandler::OrderFiller, type: :service do

  describe "#call" do

    context "when it is successful" do
      let(:sale) { create(:sale) }
      let(:item) { create(:cart_item, sale: sale, quantity: 3) }
      let(:order) { create(:order, user: item.cart.user) }

      it "fills order with cart items" do
        expect { PurchasesHandler::OrderFiller.call(item.cart, order) }.to change(OrderLineItem, :count).by(item.quantity)
      end

      it "saves order" do
        expect { PurchasesHandler::OrderFiller.call(item.cart, order) }.to change(Order, :count).by(1)
      end
    end

  end
  
end
