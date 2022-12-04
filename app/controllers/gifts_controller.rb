class GiftsController < ApplicationController
    def new
      @order = Order.new(product: Product.find(params[:product_id]))
    end
  
    def create
      additional_order_params = { user_facing_id: SecureRandom.uuid[0..7] }
      child = Child.find_by(child_params)
      if child.present?
        previous_order = Order.find_by(child_id: child.id)
        additional_order_params.merge!(child: child, address: previous_order.address, zipcode: previous_order.zipcode)
      end
      
      @order = Order.create(order_params.merge(additional_order_params))
      if @order.valid?
        Purchaser.new.purchase(@order, credit_card_params)
        redirect_to order_path(@order)
      else
        render :new
      end
    end
  
    def show
      @order = Order.find_by(id: params[:id]) || Order.find_by(user_facing_id: params[:id])
    end
  
  private
  
    def order_params
      params.require(:order).permit(:shipping_name, :product_id, :message).merge(paid: false, is_gift: true)
    end
  
    def child_params
      {
        full_name: params.require(:order)[:child_full_name],
        parent_name: params.require(:order)[:parent_name],
        birthdate: Date.parse(params.require(:order)[:child_birthdate]),
      }
    end
  
    def credit_card_params
      params.require(:order).permit( :credit_card_number, :expiration_month, :expiration_year)
    end
  end
  