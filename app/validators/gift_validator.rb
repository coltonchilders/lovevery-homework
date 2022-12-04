class GiftValidator < ActiveModel::Validator
  def validate(record)
    if options[:fields].any? { |field| !record.send(field).present? }
      record.errors.add :base, "Could not find child details given."
    end
  end
end