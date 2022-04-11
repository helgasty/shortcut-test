require 'rails_helper'

RSpec.describe Building, type: :model do
  context 'create building' do
    it 'create building' do
      person = build :person, reference: '1'
      person.save
      expect(person.id).not_to eq(nil)
    end

    it 'create two building with same reference' do
      building1 = build :building, reference: '1'
      building1.save

      building2 = build :building, reference: '1'
      expect { building2.save }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
