require 'sqlite3'

$db = SQLite3::Database.new "microblog.db"

# Create a database
$db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS posts (
    title VARCHAR(255) not null,
    content TEXT not null,
    id INTEGER primary key autoincrement
  );
SQL

$db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS tags (
    name VARCHAR(255) UNIQUE not null,
    id INTEGER primary key autoincrement
  );
SQL

$db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS post_tags (
    post_id INTEGER references posts(id) on delete cascade,
    tag_id INTEGER references posts(id) on delete cascade
  );
SQL