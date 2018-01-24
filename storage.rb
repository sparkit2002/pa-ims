require 'json'
require './artist.rb'

  class Storage

    def initialize()
      @filename = "./json_storage.json"
      json = File.read(@filename)
      @loader = JSON.parse(json)
    end

    attr_accessor :loader

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

    def save(artists,tracks_order,tracks_played)

        store_artists = store_art(artists)
        store_order = store_track(tracks_order)
        store_played = store_track(tracks_played)

        json_store = [store_artists,store_order,store_played]

        File.open(@filename,'w') do |save|
          save.write(json_store.to_json)
        end
      end

  end
