require_relative 'persistent_table'
require_relative 'parser'

class Database
  def initialize
    @tables = {}
    @parser = Parser.new
  end

  def execute(sql)
    case sql.strip
    when /^CREATE TABLE/
      create_table(*@parser.parse_create_table(sql))
    when /^INSERT INTO/
      insert(*@parser.parse_insert(sql))
    when /^SELECT/
      select(*@parser.parse_select(sql))
    else
      raise "Unsupported SQL statement: #{sql}"
    end
  end

  private

  def create_table(name, columns)
    file_path = "data/#{name}.bin"
    @tables[name] = PersistentTable.new(name, columns, file_path)
  end

  def insert(name, row)
    @tables[name].insert(row)
  end

  def select(name, conditions = {})
    @tables[name].select(conditions)
  end
end
