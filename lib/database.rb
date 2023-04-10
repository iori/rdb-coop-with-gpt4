class Database
  attr_accessor :tables

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
    @tables[name] = Table.new(name, columns)
  end

  def insert(name, row)
    @tables[name].insert(row)
  end

  def select(name, conditions = {})
    @tables[name].select(conditions)
  end
end
