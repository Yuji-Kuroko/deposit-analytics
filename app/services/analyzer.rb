class Analyzer
  def initialize(rows)
    @rows = rows
  end

  def month(date)
    @rows.select{ |row|
      (date.beginning_of_month..date.end_of_month).include?(row[:date])
    }.group_by { |row|
      row[:name]
    }.map { |k, rows|
      {
        name: k,
        price: rows.map{|row| row[:price].to_i}.inject(:+)
      }
    }.sort_by{ |row|
      row[:price]
    }.reverse.yield_self { |rows|
      rows.push({
          name: '合計',
          price: rows.map{|row| row[:price]}.inject(:+),
        }
      )
    }
  end
end
