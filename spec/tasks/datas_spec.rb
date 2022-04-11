require 'rails_helper'
require 'csv'

Rails.application.load_tasks

describe "datas:import " do
  after(:each) do
    Rake::Task["datas:import"].reenable
  end

  context "import building" do
    let(:arg1) {"building"}
    let(:arg2) {"buildings.csv"}

    it "check import run correctly" do
      total_buildings = Building.all.count
      Rake::Task["datas:import"].invoke(arg1, arg2)

      expect(total_buildings).to be < Building.all.count
    end

    it "check attribute history insert correctly" do
      Rake::Task["datas:import"].invoke(arg1, arg2)

      expect(Building.last.manager_name).to eq(AttrHistory.last.value)
    end

    it "import, then update manually, and reimport again" do
      Rake::Task["datas:import"].invoke(arg1, arg2)

      building = Building.last
      previous_manager_name = building.manager_name
      building.update(manager_name: "new_manager_name")

      Rake::Task["datas:import"].invoke(arg1, arg2)

      expect(building.manager_name).not_to eq(previous_manager_name)
    end

    it "import, then update manually, and import new value" do
      Rake::Task["datas:import"].invoke(arg1, arg2)

      building = Building.last
      building.update(manager_name: "new_manager_name")

      new_manager_name = FFaker::Name.name

      CSV.open(File.join(Rails.root, 'public', 'import', 'new_file.csv'), "a+") do |csv|
        csv << ["reference","address","zip_code","city","country","manager_name"]
        csv << [building.reference,
                FFaker::AddressFR.full_address,
                FFaker::AddressFR.zip_code,
                FFaker::AddressFR.country,
                new_manager_name ]
      end

      Rake::Task["datas:import"].invoke(arg1, 'new_file.csv')

      expect(building.manager_name).not_to eq(new_manager_name)
    end
  end

  context "import person" do
    let(:arg1) {"person"}
    let(:arg2) {"people.csv"}

    it "check import run correctly" do
      total_persons = Person.all.count
      Rake::Task["datas:import"].invoke(arg1, arg2)

      expect(total_persons).to be < Person.all.count
    end
  end
end