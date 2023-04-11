require 'fileutils'
require_relative 'page'

class PersistentTable
  ROW_SIZE = 256 # 固定長

  def initialize(name, columns, data_path)
    @name = name
    @columns = columns
    @data_path = data_path
    @rows = []

    @next_row_id = 0

    if File.exist?(@data_path)
      load_data
      #load_data2
    else
      @pages = [Page.new]
      save_data
    end
  end

  def insert(row)
    serialized_row = Marshal.dump(row)
    serialized_row_length = serialized_row.bytesize

    current_page = @pages.last

    # Check if there's enough space in the current page, create a new one if needed
    if current_page.remaining_space < serialized_row_length
      current_page = Page.new
      @pages << current_page
    end

    current_page.write(@next_row_id, serialized_row, ROW_SIZE)
    @next_row_id += 1
    save_data
  end

  def select(conditions = {})
    matching_rows = []

    @pages.each do |page|
      (0...@next_row_id).each do |row_id|
        serialized_row = page.read(row_id * ROW_SIZE, ROW_SIZE)
        row = Marshal.load(serialized_row)

        if matches_conditions?(row, conditions)
          matching_rows << row
        end
      end
    end

    matching_rows
  end

  private
=begin
  def load_data
    File.open(@data_path, 'rb') do |file|
      p file
      data = Marshal.load(file)
      @columns = data[:columns]
      @rows = data[:rows]
    end
  end
=end

  def load_data2
    binary_data = File.binread(@data_path)
    @pages = binary_data.scan(/.{1,#{@page_size}}/).map { |page_data| Page.from_binary(page_data) }
  end

  def save_data
    binary_data = @pages.map(&:to_binary).join
    File.binwrite(@data_path, binary_data)
  end

  def matches_conditions?(row, conditions)
    conditions.all? do |column, value|
      column_index = @columns.index(column)
      row[column_index] == value
    end
  end
end
