class CsvImporter
  def self.import(type)
    return nil unless self.permitted_type.include?(type)

    importer = "#{type.camelize}CsvImporter".constantize
    importer.import
  end

  def self.permitted_type
    ['ufj', 'visa']
  end
end
