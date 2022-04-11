class AttrHistory < ApplicationRecord

  def self.new_value?(model, identifier, attr, value)
    attribute_history = AttrHistory.where(model: model, identifier: identifier, attr: attr, value: value).first_or_initialize

    # check if new or already value
    result = attribute_history.new_record?
    attribute_history.save!

    result
  end
end