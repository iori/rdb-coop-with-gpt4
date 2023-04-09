# MyRDB

MyRDB is a simple relational database implemented in Ruby. It currently supports basic SQL statements such as `SELECT`, `INSERT`, and `CREATE TABLE`.

## Setup

1. Clone or download the project.

git clone https://github.com/yourusername/my_rdb.git

2. If necessary, install required gems by running `bundle install` in the project directory.

## Usage

The following code demonstrates how to use MyRDB to create a database, create a table, and manipulate data.

```ruby
require_relative 'lib/database'
require_relative 'lib/table'

db = Database.new

# Create table
db.execute("CREATE TABLE users (id, name, age)")

# Insert data
db.execute("INSERT INTO users VALUES (1, 'Alice', 30)")
db.execute("INSERT INTO users VALUES (2, 'Bob', 25)")

# Query data
puts db.execute("SELECT * FROM users WHERE name = 'Alice'") # => [[1, "Alice", 30]]
```

For more detailed usage and API information, refer to the source code in lib/database.rb and lib/table.rb.

## Contributing

Bug reports and feature requests are welcome through the GitHub issues.

## License

MyRDB is released under the MIT License.

Use this sample as a reference to create an English version of the `README.md` for your project. Replace the repository URL, project name, and other relevant information as needed.
