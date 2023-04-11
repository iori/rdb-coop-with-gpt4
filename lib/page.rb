class Page
  PAGE_SIZE = 4096
  ROW_SIZE = 256 # 固定長

  # `@data = "\x00" * size` は、`Page` クラス内でページのデータを表す文字列を初期化しています。
  # ここで、`"\x00"` は null バイト（値が 0 のバイト）を表し、`size` はページサイズを表します。
  #
  # `"\x00" * size` は、null バイトを `size` 個繋げた文字列を作成しています。
  # これにより、ページのデータを保持するための文字列が初期化され、そのサイズが指定されたサイズになります。
  #
  # 例えば、`size` が 1024 の場合、`@data` は 1024 個の null バイトからなる文字列になります。
  # これによって、ページ内の各位置にデータを書き込んだり、読み込んだりすることができるようになります。
  #
  # irb(main):008:0> hoge = "\x00" * 1024
  # => "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\...
  #
  # irb(main):011:0> hoge[0,1]
  # => "\u0000"
  # irb(main):012:0> hoge[0,2]
  # => "\u0000\u0000"
  def initialize(data = nil)
    @data = data || ("\x00" * PAGE_SIZE)
  end

  def read(offset, length)
    padded_data = @data[offset, ROW_SIZE]
    padded_data.sub(/\x00+\z/, '')
  end

  # 固定長
  def write(offset, data, row_size)
    padded_data = data.ljust(ROW_SIZE, "\x00")
    my_offset = offset * ROW_SIZE
    @data[my_offset, my_offset + ROW_SIZE] = padded_data
  end

  def to_binary
    @data
  end

  def remaining_space
    PAGE_SIZE - @data.gsub(/\x00+\z/, '').length
  end

  def self.from_binary(binary_data)
    new(binary_data)
  end
end
