require 'rails_helper'

RSpec.describe PurchasesHandler::OrderBuilder, type: :request do
  include Requests

  describe "#call" do
    subject(:request!) { post '/purchases', params: params }

    context "when order is created", skip: true do
      let(:gateway) { :paypal }
      let(:params) { { gateway: gateway, cart_id: cart_id } }
      let(:user) { create(:user) }
      let(:cart) { create(:cart, user: user) }
      let(:cart_id) { cart.id }

      before { request! }

      it "returns ok status" do
        expect(response).to have_http_status(:ok)  
      end
    end

  end
  
end
