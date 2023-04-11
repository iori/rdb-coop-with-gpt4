class Parser
  def parse_create_table(sql)
    table_name = sql[/^CREATE TABLE (\w+)/, 1]
    columns = sql[/\((.+)\)/, 1].split(',').map(&:strip)
    [table_name, columns]
  end

  def parse_insert(sql)
    table_name = sql[/^INSERT INTO (\w+)/, 1]
    values = sql[/VALUES \((.+)\)/, 1].split(',').map do |value|
      value.strip.gsub(/'(.+)'/, '\1') # Remove single quotes
    end

    [table_name, values]
  end

  def parse_select(sql)
    table_name = sql[/^SELECT .+ FROM (\w+)/, 1]
    conditions_str = sql[/WHERE (.+)$/, 1]
    conditions = conditions_str&.split('AND')&.map do |condition|
      column, value = condition.strip.split('=').map(&:strip)
      [column, value.gsub(/'(.+)'/, '\1')] # Remove single quotes
    end&.to_h || {}

    [table_name, conditions]
  end
end
