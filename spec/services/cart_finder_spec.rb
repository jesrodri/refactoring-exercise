require 'rails_helper'

RSpec.describe PurchasesHandler::CartFinder, type: :request do
  include Requests

  describe "#call" do
    subject(:request!) { post '/purchases', params: params }

    context "when cart exists" do
      let(:gateway) { :paypal }
      let(:user) { create(:user) }
      let(:params) { { gateway: gateway, cart_id: cart_id } }
      let!(:cart_id) { create(:cart, user: user).id }

      before { request! }

      it "returns ok status" do
        expect(response).to have_http_status(:ok)  
      end
    end
  end
  
end
