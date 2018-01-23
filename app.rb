require "./artist.rb"
require 'byebug'
require 'json'

class App

  def initialize
    @filename = "./json_storage.json"
    json = loader()
    @artists = load_artists(json[0])
    @tracks_order = load_tracks(json[1])
    @tracks_played = load_tracks(json[2])
  end

  def loader
    json = File.read(@filename)
    load_values = JSON.parse(json)
    return load_values
  end

  def load_artists(json)
    artists_load = {}

    json.each do |key,value|
      artists_load[key] = Artist.new(value['name'])
      tracks = load_tracks(value['tracks'])
      artists_load[key].tracks = tracks
    end
    return artists_load
  end

  def load_tracks(list)
    tracks_load = []
    list.each do |track|
      tracks_load << Track.new(track['name'],track['artist'])
    end
    return tracks_load
  end

  def help
    puts "I will fill in help message later!"
  end

  def quit
    store_artists = store_art(@artists)
    store_order = store_track(@tracks_order)
    store_played = store_track(@tracks_played)

    json_store = [store_artists,store_order,store_played]

    File.open(@filename,'w') do |save|
      save.write(json_store.to_json)
    end


  end

  def store_art(artists)
    store = {}
    artists.each do |key,value|
      store_tracks = store_track(value.tracks)
      store[key] = {'name' => value.name,'tracks' => store_tracks}
    end

    return store

  end

  def store_track(tracks)
    store = []
    tracks.each do |track|
      store << {'name' => track.name, 'artist' => track.artist}
    end
    return store
  end


  def info
    puts "Last songs played:"
    count = 1
    @tracks_played.reverse_each do |track|
      puts "#{count}. #{track.name}"
      count += 1
    end
    puts "Number of artists: #{@artists.length}"
    print "Number of tracks:"
    count = 0
    count_arr = @artists.values.map {|a| a.tracks.count }
    puts " #{count_arr.sum}"
  end

  def info_track(number)
    #displays track info for a selected track
    number -= 1
    if @tracks_order[number] == nil
      puts "No track under track number #{number+1}."
    else
      puts "Track #{number + 1} on list is #{@tracks_order[number].name} by #{@tracks_order[number].artist}"
    end
  end

  def info_artist(id)
    #same as ^, but instead of number by id
    if @artists[id] == nil
      puts "No artist under ID #{id}."
    else
      puts "The artist listed under ID #{id} is #{@artists[id].name}."
    end
  end

  def add_artist(name,id)
    @artists[id] = Artist.new(name)
    puts "Added artist #{name} under ID #{id}."
  end

  def add_track(id,track)
    #adds a track to the artist
    if @artists[id] != nil
      song = Track.new(track,@artists[id].name)
      @artists[id].tracks << song
      @tracks_order << song
      puts "Added track #{track} by artist #{@artists[id].name}."
    else
      puts "No artist saved under ID #{id}"
    end
  end

  def play_track(number)
    number -= 1
    time = Time.new
    if @tracks_order[number] == nil
      puts "No track under track number #{number+1}"
    else
      puts "Played #{@tracks_order[number].name} by artist #{@tracks_order[number].artist} at #{time.hour}:#{time.min}:#{time.sec}"
      @tracks_played << @tracks_order[number]
    end
  end

  def count_tracks(id)
    #counts the tracks of an artist (by ID)
    if @artists[id] == nil
      puts "No artist under ID #{id}."
    else
      puts "Artist #{@artists[id].name} has #{@artists[id].tracks.length} tracks stored."
    end
  end

  def list_tracks(id)
    #lists the tracks by an aritst (ID)

    if @artists[id] == nil
      puts "No artist under ID #{id}."
    else
      puts "Tracks stored for artist #{@artists[id].name}:"
      count = 1
      @artists[id].tracks.each do |song|
        puts "#{count}. #{song}."
        count += 1
      end
    end
  end
end
