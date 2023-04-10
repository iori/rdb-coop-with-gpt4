require 'fileutils'

class PersistentTable
  def initialize(name, columns, file_path)
    @name = name
    @columns = columns
    @file_path = file_path
    @rows = []

    if File.exist?(@file_path)
      load_data
    else
      save_data
    end
  end

  def insert(row)
    @rows << row
    save_data
  end

  def select(conditions = {})
    @rows.select do |row|
      conditions.all? { |column, value| row[@columns.index(column)] == value }
    end
  end

  private

  def save_data
    File.open(@file_path, 'wb') do |file|
      Marshal.dump({ columns: @columns, rows: @rows }, file)
    end
  end

  def load_data
    File.open(@file_path, 'rb') do |file|
      data = Marshal.load(file)
      @columns = data[:columns]
      @rows = data[:rows]
    end
  end
end
