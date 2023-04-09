require './lib/main.rb'

db = Database.new

db.execute("CREATE TABLE users (id, name, age)")

db.execute("INSERT INTO users VALUES (1, 'Alice', 30)")
db.execute("INSERT INTO users VALUES (2, 'Bob', 25)")

puts db.execute("SELECT * FROM users WHERE name = 'Alice'")
