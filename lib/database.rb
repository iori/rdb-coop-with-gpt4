class Database
  attr_accessor :tables

  def initialize
    @tables = {}
  end

  def create_table(name, columns)
    @tables[name] = Table.new(name, columns)
  end

  def insert(name, row)
    @tables[name].insert(row)
  end

  def select(name, conditions = {})
    @tables[name].select(conditions)
  end
end
