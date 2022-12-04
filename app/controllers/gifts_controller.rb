class GiftsController < ApplicationController
    def new
      @gift = Gift.new(product: Product.find(params[:product_id]))
    end
  
    def create
      additional_gift_params = { user_facing_id: SecureRandom.uuid[0..7] }
      child = Child.find_by(child_params)
      previous_order = Gift.find_by(child_id: child.id) if child.present?

      if previous_order.present?
        additional_gift_params.merge!(child: child, address: previous_order.address, zipcode: previous_order.zipcode)
      end
    
      @gift = Gift.create(gift_params.merge(additional_gift_params))
      if @gift.valid?
        Purchaser.new.purchase(@gift, credit_card_params)
        redirect_to gift_path(@gift)
      else
        render :new
      end
    end
  
    def show
      @gift = Gift.find_by(id: params[:id]) || Gift.find_by(user_facing_id: params[:id])
    end
  
  private
  
    def gift_params
      params.require(:gift).permit(:shipping_name, :product_id, :message).merge(paid: false, is_gift: true)
    end
  
    def child_params
      birthdate = params.require(:gift)[:child_birthdate]
      if birthdate.present?
        birthdate = Date.parse(birthdate)
      end
      {
        full_name: params.require(:gift)[:child_full_name],
        parent_name: params.require(:gift)[:parent_name],
        birthdate: birthdate,
      }
    end
  
    def credit_card_params
      params.require(:gift).permit(:credit_card_number, :expiration_month, :expiration_year)
    end
  end
  