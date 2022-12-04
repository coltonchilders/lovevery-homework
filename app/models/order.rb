class Order < ApplicationRecord
  belongs_to :product
  belongs_to :child

  validates :shipping_name, presence: true
  validates :child_id, :address, :zipcode, presence: true, unless: :is_gift?

  def to_param
    user_facing_id
  end

  def is_gift?
    is_gift.present? && is_gift
  end
end
