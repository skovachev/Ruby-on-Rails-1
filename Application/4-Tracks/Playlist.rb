class Playlist

  attr_reader :tracks

  def self.from_yaml(path)
    # Your code goes here.
  end

  def initialize(*tracks)
    @tracks = tracks.first if tracks.first.is_a? Array
    @tracks = tracks unless tracks.first.is_a? Array

    puts self.inspect
  end

  def each
    if block_given?
      @tracks.each { |t| yield t }
    else
      @tracks.to_enum(:each)
    end
  end

  def find(&block)
    self.class.new(@tracks.select(&block))
    # Filter the playlist by a block. Should return a new Playlist.
  end

  def find_by(*filters)
    # Filter is any object that responds to the method #call. #call accepts one
    # argument, the track it should match or not match.
    #
    # Should return a new Playlist.
    self.class.new @tracks.select do |track|
      filters.map { |filter| filter.call(track) }.include? true
    end
  end

  def find_by_name(name)
    self.class.new(@tracks.select { |track| track.name == name })
  end

  def find_by_artist(artist)
    self.class.new(@tracks.select { |track| track.artist == artist })
  end

  def find_by_album(album)
    self.class.new(@tracks.select { |track| track.album == album })
  end

  def find_by_genre(genre)
    self.class.new(@tracks.select { |track| track.genre == genre })
  end

  def shuffle
    self.class.new(@tracks.shuffle)
  end

  def random
    @tracks.sample
  end

  def to_s
    # It should return a nice tabular representation of all the tracks.
    # Checkout the String class for something that can help you with that.
  end

  def &(playlist)
    @tracks + playlist.tracks
  end

  def |(playlist)
    # Your code goes here. This _should_ return new playlist.
  end

  def -(playlist)
    @tracks - playlist.tracks
  end
end

track1 = 't1'
track2 = 't2'
track3 = 't3'

# I wanna be able to initialize a playlist like this:
playlist = Playlist.new(track1, track2, track3)

# To make things more interesting, I wanna be able to initialize it like this
# too:
playlist = Playlist.new([track1, track2, track3])

# # I wanna choose only the jazzy house tracks.
# jazz_playlist & house_playlist

# # I wanna exclude any house tracks from my playlist.
# jazz_playlist - house_playlist

# # I wanna combine my soul and funk tracks.
# soul_playlist | funk_playlist

# # I wanna be able to filter the tracks by a block.
# playlist.find { |track| ["Led Zeppellin", "The Doors"].include? track.artist }

# # I wanna be able to filter the playlist by a filter object.
# class AwesomeRockFilter
#   AWESOME_ARTISTS = %w(Led\ Zeppellin The\ Doors Black\ Sabbath)

#   def call(track)
#     AWESOME_ARTISTS.include? track.artist
#   end
# end

# playlist.find_by AwesomeRockFilter.new

# # Because of the interface, I wanna be able to filter it out with a proc too.
# awesome_rock_filter = proc do |track|
#   awesome_artists = %w(Led\ Zeppellin The\ Doors Black\ Sabbath)
#   awesome_artists.include? track.artist
# end

# playlist.find_by awesome_rock_filter
