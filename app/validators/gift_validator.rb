class GiftValidator < ActiveModel::Validator
  def validate(record)
    unless child.present? && address.present? && zipcode.present?
      record.errors.add :base, "Could not find child details given."
    end
  end
end