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

  def execute(sql)
    case sql.strip
    when /^CREATE TABLE/
      parse_create_table(sql)
    when /^INSERT INTO/
      parse_insert(sql)
    when /^SELECT/
      parse_select(sql)
    else
      raise "Unsupported SQL statement: #{sql}"
    end
  end

  private

  def parse_create_table(sql)
    table_name = sql[/^CREATE TABLE (\w+)/, 1]
    columns = sql[/\((.+)\)/, 1].split(',').map(&:strip)
    create_table(table_name, columns)
  end

  def parse_insert(sql)
    table_name = sql[/^INSERT INTO (\w+)/, 1]
    values = sql[/VALUES \((.+)\)/, 1].split(',').map do |value|
      value.strip.gsub(/'(.+)'/, '\1') # Remove single quotes
    end
    insert(table_name, values)
  end

  def parse_select(sql)
    table_name = sql[/^SELECT .+ FROM (\w+)/, 1]
    conditions_str = sql[/WHERE (.+)$/, 1]
    conditions = conditions_str&.split('AND')&.map do |condition|
      column, value = condition.strip.split('=').map(&:strip)
      [column, value.gsub(/'(.+)'/, '\1')] # Remove single quotes
    end&.to_h || {}
    select(table_name, conditions)
  end
end
