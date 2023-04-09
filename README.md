# MyRDB

MyRDBは、Rubyで実装されたシンプルなリレーショナルデータベースです。現在は`SELECT`, `INSERT`, `CREATE TABLE`の基本的なSQL文をサポートしています。

## セットアップ

1. プロジェクトをクローンまたはダウンロードします。

git clone https://github.com/yourusername/my_rdb.git

2. 必要なgemがある場合は、プロジェクトディレクトリで`bundle install`を実行してインストールします。

```sh
cd my_rdb
bundle install
```

## 使い方

以下のコードは、MyRDBを使ってデータベースを作成し、テーブルを作成してデータを操作する例です。

```ruby
require_relative 'lib/database'
require_relative 'lib/table'

db = Database.new

# テーブル作成
db.execute("CREATE TABLE users (id, name, age)")

# データ挿入
db.execute("INSERT INTO users VALUES (1, 'Alice', 30)")
db.execute("INSERT INTO users VALUES (2, 'Bob', 25)")

# データ検索
puts db.execute("SELECT * FROM users WHERE name = 'Alice'") # => [[1, "Alice", 30]]
```

詳細な使い方やAPIについては、lib/database.rbとlib/table.rbのソースコードを参照してください。

## 貢献

バグ報告や機能追加のリクエストは、GitHubのissueにて受け付けています。

## ライセンス

MyRDBはMITライセンスのもとで公開されています。
