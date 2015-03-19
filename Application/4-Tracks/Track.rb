class Track

  attr_accessor :artist, :name, :album, :genre

  def initialize(*args)
    arg = args.pop

    if arg.instance_of? Hash
      @artist = arg.fetch :artist
      @name = arg.fetch :name
      @album = arg.fetch :album
      @genre = arg.fetch :genre
    else
      @artist, @name, $album, $genre = args
    end

    puts self.inspect
  end
end

# I wanna be able to initialize a track like this:
track = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"

# To make it more clear, I also wanna instantiate it like this:
track = Track.new artist:"KAYTRANADA feat. Shay Lia",
  name: "Leave me alone",
  album: "So Bad",
  genre: "Dance"

# # If I miss a field, I want a gentle reminder that I need to pass it. Hint,
# # look up [Hash#fetch][].
track = Track.new artist:"KAYTRANADA feat. Shay Lia",
  name: "Leave me alone",
  album: "So Bad",
  genre: "Dance"

puts track.respond_to? :artist #=> true
puts track.respond_to? :name   #=> true
puts track.respond_to? :album  #=> true
puts track.respond_to? :genre  #=> true
puts track.respond_to? :artist= #=> true
puts track.respond_to? :name=   #=> true
puts track.respond_to? :album=  #=> true
puts track.respond_to? :genre=  #=> true
