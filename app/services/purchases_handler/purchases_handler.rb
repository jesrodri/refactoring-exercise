module PurchasesHandler
  class PurchasesHandler < ApplicationService

    def initialize(purchase_params)
      @purchase_params = purchase_params
    end

    def call
      purchase_handler
    end

    private

    def purchase_handler
      if @purchase_params[:gateway] == 'paypal'
        cart = CartFinder.call(@purchase_params)

        unless cart
          return { json: { errors: [{ message: 'Cart not found!' }] }, status: :unprocessable_entity }
        end

        user = UserCreator.call(cart, @purchase_params)

        if user.valid?
          order = OrderCreator.call(user, address_params)

          OrderFiller.call(cart, order)
          
          order.save

          if order.valid?
            return { json: { status: :success, order: { id: order.id } }, status: :ok }
          else
            return { json: { errors: order.errors.map(&:full_message).map { |message| { message: message } } }, status: :unprocessable_entity }
          end
        else
          return { json: { errors: user.errors.map(&:full_message).map { |message| { message: message } } }, status: :unprocessable_entity }
        end
      elsif @purchase_params[:gateway] == 'stripe'
        cart = CartFinder.call(@purchase_params)

        unless cart
          return { json: { errors: [{ message: 'Cart not found!' }] }, status: :unprocessable_entity }
        end

        user = UserCreator.call(cart, @purchase_params)

        if user.valid?
          order = OrderCreator.call(user, address_params)

          OrderFiller.call(cart, order)
          
          order.save

          if order.valid?
            return { json: { status: :success, order: { id: order.id } }, status: :ok }
          else
            return { json: { errors: order.errors.map(&:full_message).map { |message| { message: message } } }, status: :unprocessable_entity }
          end
        else
          return { json: { errors: user.errors.map(&:full_message).map { |message| { message: message } } }, status: :unprocessable_entity }
        end
      else
        return { json: { errors: [{ message: 'Gateway not supported!' }] }, status: :unprocessable_entity }
      end
    end

    def address_params
      @purchase_params[:address] || {}
    end

  end
end
