class Table
  attr_accessor :name, :columns, :rows

  def initialize(name, columns)
    @name = name
    @columns = columns
    @rows = []
  end

  def insert(row)
    @rows << row
  end

  def select(conditions = {})
    @rows.select do |row|
      conditions.all? { |key, value| row[columns.index(key)] == value }
    end
  end
end
