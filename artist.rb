class Artist
  def initialize(name)
    #@artist_ID = id
    @name = name
    @tracks = []
  end
    #attr_accessor :id
    attr_accessor :name
    attr_accessor :tracks
end

class Track
  def initialize(name,artist)
    @name = name
    @artist = artist
  end
  attr_accessor :name
  attr_accessor :artist
end
