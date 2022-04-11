namespace :datas do
  require 'csv'

  desc "import datas from csv file"
  task :import, [:entity, :file] do |t, args|
    # get data from csv file
    datas = get_data_from_csv(args[:file])

    # convert string to constant
    entity_name = args[:entity].titleize
    entity = entity_name.constantize

    # prepare data for import
    imported_datas = prepare_datas(datas, entity)

    # insert / update all datas
    entity.upsert_all(imported_datas, unique_by: :reference)

    p "Imported #{imported_datas.count} #{entity_name} from #{args[:file]}"
  rescue => e
    p e.message
  end

  def get_data_from_csv(file_name)
    file_path = File.join(Rails.root, 'public', 'import', file_name)

    datas = []
    CSV.foreach(file_path, headers: true) do |row|
      datas << row.to_hash
    end

    datas
  end

  def prepare_datas(datas, entity)
    prepared_datas = []
    protected_attributes = entity.protected_attributes

    datas.each do |data|
      # attribute "reference" use like entity identifier
      entity_identifier = data['reference'].to_i
      entity_attributes = {}

      # each attribute of entity
      data.each do |attribute, value|

        # check if attribute is protected
        # if protected, check if value already inserted
        # if not, insert value else update value with entity.attribute
        if protected_attributes.include?(attribute)
          if AttrHistory.new_value?(entity.name, entity_identifier, attribute, value)
            entity_attributes[attribute] = value
          else
            # load entity by identifier and get is attribute
            entity_attributes[attribute] = entity.find_by(reference: entity_identifier).send(attribute)
          end
        else
          entity_attributes[attribute] = value
        end
      end

      prepared_datas << entity_attributes
    end

    prepared_datas
  end
end
