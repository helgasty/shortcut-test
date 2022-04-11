class Building < ApplicationRecord
  PROTECTED_ATTRIBUTES = %w(manager_name)

  def self.protected_attributes
    PROTECTED_ATTRIBUTES
  end
end
