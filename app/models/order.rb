class Order < ApplicationRecord
  belongs_to :product
  belongs_to :child

  validates :shipping_name, :child_full_name, :child_birthdate, presence: true
  validates :address, :zipcode, presence: true, unless: :is_gift?
  validates_with GiftValidator, if: :is_gift?

  def to_param
    user_facing_id
  end

  def is_gift?
    is_gift.present? && is_gift
  end
end
