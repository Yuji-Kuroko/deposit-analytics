class VisaCsvImporter
  def self.csv_dir
    "#{App.root}/csv/visa"
  end

  def self.import
    rows = Dir.glob("#{self.csv_dir}/*.csv").map {|path|
      CSV.parse(NKF.nkf('-w', File.read(path)))
    }.flatten(1).reject{|row|
      self.reject_row?(row)
    }.map {|row|
      self.parse_row(row)
    }
  end

  def self.reject_row?(row)
    row[0].nil? || row[5].nil?
  end

  def self.parse_row(row)
    {
      date: Date.parse(row[0]),
      name: row[1],
      price: row[5],
    }
  end
end
