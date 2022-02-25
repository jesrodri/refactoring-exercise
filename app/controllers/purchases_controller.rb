class PurchasesController < ApplicationController
  VALID_GATEWAYS = ['paypal', 'stripe']
  
  def create
    gateway = purchase_params[:gateway]
    if VALID_GATEWAYS.include? gateway
      purchase_handler
    else
      return  render json: { errors: [{ message: 'Gateway not supported!' }] }, status: :unprocessable_entity
    end
  end
  
  private
  
  def purchase_handler
    cart = Cart.find_by(id: purchase_params[:cart_id])

    return render json: { errors: [{ message: 'Cart not found!' }] }, status: :unprocessable_entity unless cart

    user = PurchasesHandler::UserCreator.call(cart, purchase_params)

    return render json: { errors: user.errors.map(&:full_message).map { |message| { message: message } } }, status: :unprocessable_entity unless user.valid?
    
    order = PurchasesHandler::OrderBuilder.call(user, address_params)
    PurchasesHandler::OrderFiller.call(cart, order)

    return render json: { errors: order.errors.map(&:full_message).map { |message| { message: message } } }, status: :unprocessable_entity unless order.valid?

    return render json: { status: :success, order: { id: order.id } }, status: :ok
  end

  def purchase_params
    params.permit(
      :gateway,
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
    )
  end
  
  def address_params
    purchase_params[:address] || {}
  end
end
