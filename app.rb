require "./artist.rb"
require "./storage.rb"
require 'byebug'
require 'json'

class App

  def initialize
    @filename = "./json_storage.json"

    @json = Storage.new

    @artists = @json.load_artists(@json.loader[0])
    @tracks_order = @json.load_tracks(@json.loader[1])
    @tracks_played = @json.load_tracks(@json.loader[2])
  end

  attr_accessor :artists

  def help

    message = """
    List of commands:
    Help:  displays information about how to use this app.  \"help\"
    Exit:  saves the current state of the system and exits.  \"exit\"
    Info:  displays the current state of the system: number of artists, tracks, and the last songs played.  \"info\"
    Info Artist:  displays information about a given artist by ID.  \"info artist <ARTIST ID>
    Info Track:  displays information about a given track by number.  \"info track <TRACK NUMBER>\"
    Add Artist:  loads an artist into the system.  The artist can be accesssed by their assigned ID.  \"add artist <NAME>\"
    Add Artist with ID:  loads an artist into the system with a custom ID. \" add artist <NAME> ID <CUSTOME ID>
    Add Track:  loads a track into the system saved under the given artist. \"add track <TRACK NAME> by <ARTIST ID>\"
    Play Track:  records that a track was played and when.  Tracks are numbered in the order they are added.  \"play track <NUMBER OF TRACK>\"
    Count Tracks:  displays how many tracks are saved under a given artist.  \"count tracks by <ARTIST ID>\"
    List Tracks:  lists all the tracks saved under a given artist.  \"list tracks by <ARTIST ID>\"
    Erase:  clears all saved data in the system, returning the system to a freash state.  \"erase\""""

    puts message
  end

  def quit
    @json.save(@artists,@tracks_order,@tracks_played)
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
        puts "#{count}. #{song.name}."
        count += 1
      end
    end
  end

  def erase
    @artists.clear
    @tracks_order.clear
    @tracks_played.clear
  end
end
