class Tag
  
  class << self
    def build_from_db row
      Tag.new(row[1], row[0])
    end

    def find_for_post(id)
      $db.execute("SELECT id, name FROM tags LEFT JOIN post_tags ON tags.id=post_tags.tag_id WHERE post_id=?", [id]).map do |row|
        Tag.build_from_db row
      end
    end

    def find_all
      $db.execute("SELECT id, name FROM tags").map do |row|
        Tag.build_from_db row
      end
    end

    def insert_if_not_exists(tag_name, post_id)
      tag = $db.execute("SELECT 1 FROM tags WHERE name=?", [tag_name])
      $db.execute("INSERT INTO tags(name) VALUES (?)", [tag_name]) unless tag.present?
      tag_id = tag.id if tag.present?
      unless tag.present?
        tag_id = $db.execute('SELECT last_insert_rowid()');
      end
      $db.execute('INSERT INTO post_tags(post_id, tag_id) VALUES(?, ?)', [post_id, tag_id]);
    end
  end

  attr_accessor :name, :id

  def initialize(name, id = nil)
    @name, @id = name, id
  end
end
