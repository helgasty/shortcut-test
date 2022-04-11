require 'rails_helper'

RSpec.describe Person, type: :model do
  context 'create person' do
    it 'create person' do
      person = build :person, reference: '1'
      person.save
      expect(person.id).not_to eq(nil)
    end

    it 'create two person with same reference' do
      person1 = build :person, reference: '1'
      person1.save

      person2 = build :person, reference: '1'
      expect { person2.save }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
