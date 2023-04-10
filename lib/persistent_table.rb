class PersistentTable
  attr_reader :name, :columns, :file_path

  def initialize(name, columns, file_path)
    @name = name
    @columns = columns
    @file_path = file_path
    @rows = []

    if File.exist?(@file_path)
      load_data_from_file
    else
      save_data_to_file
    end
  end

  def insert(row)
    @rows << row
    save_data_to_file
  end

  def select(conditions = {})
    @rows.select do |row|
      conditions.all? { |column, value| row[@columns.index(column)] == value }
    end
  end

  private

  def load_data_from_file
    File.open(@file_path, 'rb') do |file|
      file.each_line do |line|
        @rows << line.chomp.split(',').map { |value| value.gsub(/'(.+)'/, '\1') }
      end
    end
  end

  def save_data_to_file
    File.open(@file_path, 'wb') do |file|
      @rows.each do |row|
        file.puts row.map { |value| "'#{value}'" }.join(',')
      end
    end
  end
end
