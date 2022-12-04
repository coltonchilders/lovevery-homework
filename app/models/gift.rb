class Gift < Order
  validates_with GiftValidator, fields: [:child_id]
end