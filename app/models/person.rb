class Person < ApplicationRecord
  PROTECTED_ATTRIBUTES = %w(home_phone_number mobile_phone_number email address)

  def self.protected_attributes
    PROTECTED_ATTRIBUTES
  end
end
