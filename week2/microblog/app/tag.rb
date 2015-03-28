class Tag
  
  class << self
    def find_for_post(id)
      $db.execute("select id, name from tags LEFT JOIN post_tags ON tags.id=post_tags.tag_id WHERE post_id=?", [id]).map do |row|
        Tag.new(row[1], row[0])
      end
    end

    def find_all
      $db.execute("select id, name from tags").map do |row|
        Tag.new(row[1], row[0])
      end
    end

    def insert_if_not_exists(tag_name, post_id)
      tag = $db.execute("select 1 from tags WHERE name=?", [tag_name])
      $db.execute("insert into tags(name) values ( ? )", [tag_name]) unless tag.present?
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
