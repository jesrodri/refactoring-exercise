module PurchasesHandler
  class CartFinder < ApplicationService
    def initialize(purchase_params)
      @purchase_params = purchase_params
    end

    def call
      cart_finder
    end

    private

    def cart_finder
      cart_id = @purchase_params[:cart_id]
      cart = Cart.find_by(id: cart_id)
    end
  end
end
