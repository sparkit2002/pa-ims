require "./app.rb"

class Controller
  #so this should be able to parse a string, and determine the correct input
  def initialize
    @app = App.new
  end

  def find_command(input)
    input = input.strip
    if input.include? 'add artist'
      add_artist(input)
    elsif input.include? 'add track'
      add_track(input)
    elsif input.include? 'info track'
      info_track(input)
    elsif input.include? 'info artist'
      info_artist(input)
    elsif input.include? 'count tracks'
      count_tracks(input)
    elsif input.include? 'list tracks'
      list_tracks(input)
    elsif input.include? 'play track'
      play_track(input)
    elsif input == 'info'
      @app.info
    elsif input == 'help'
      @app.help
    elsif input == 'exit'
      @app.quit
    else
       error("Command Not Found")
    end
  end

  def add_artist(input)
    name = input[11,input.size]
    if name == nil
      error("Artist name required.")
    else
      splitter = name.split(' ')
      if splitter.length<2
        add_artist_single(name,splitter)
      else
        add_artist_normal(name,splitter)
      end
    end
  end

  def add_artist_single(name,splitter)
    id = splitter[0].chars.first.downcase.strip
    id += splitter[0].chars.last.downcase.strip
    @app.add_artist(name,id)
  end

  def add_artist_normal(name,splitter)
    id = splitter[0].chars.first.downcase.strip
    id += splitter[1].chars.first.downcase.strip
    @app.add_artist(name,id)
  end

  def add_track(input)
    #gotta add error cases...
    command = input[10,input.size]
    #byebug
    if track_checker(command)
      splitter = command.split('by')
      if splitter[1] == nil
        error("Must input an artist ID")
      else
        id = splitter[1].downcase.strip
        name = splitter[0].strip
        @app.add_track(id,name)
      end
    else
      error("Must input a track name and artist ID septerated by \"by\"")
    end
  end

  def track_checker(command)
    if command == nil
      return false
    elsif command.include? 'by'
      return true
    else
      return false
    end
  end

  def info_artist(input)
    splitter = input.split(' ')
    id = splitter[splitter.size-1].strip.downcase
    if id == 'artist'
      error("Must input an artist ID")
    else
      @app.info_artist(id)
    end
  end

  def info_track(input)
    splitter = input.split(' ')
    number = splitter[splitter.length-1].strip.to_i

    if number < 1
      error("Must input a track number greater than 0")
    else
      @app.info_track(number)
    end
  end

  def count_tracks(input)
    splitter = input.split(' ')
    id = splitter[splitter.size-1].strip.downcase
    if id == 'tracks'
      error("Must input an artist ID")
    else
      @app.count_tracks(id)
    end
  end

  def list_tracks(input)
    splitter = input.split(' ')
    id = splitter[splitter.size-1].strip.downcase
    if id == 'tracks'
      error("Must input an artist ID")
    else
      @app.list_tracks(id)
    end
  end

  def play_track(input)
    splitter = input.split(' ')
    number = splitter[splitter.length-1].to_i

    if number < 1
      error("Must input a track number greater than 0")
    else
      @app.play_track(number)
    end

  end

  def error(message)
    puts message
  end

end
