require 'pry'

class MusicLibraryController

def initialize(path = './db/mp3s')
  @new = MusicImporter.new(path)
  @songs = @new.import
end

def call
  loop do
  puts "Welcome to your music library!"
  puts "To list all of your songs, enter 'list songs'."
  puts "To list all of the artists in your library, enter 'list artists'."
  puts "To list all of the genres in your library, enter 'list genres'."
  puts "To list all of the songs by a particular artist, enter 'list artist'."
  puts "To list all of the songs of a particular genre, enter 'list genre'."
  puts "To play a song, enter 'play song'."
  puts "To quit, type 'exit'."
  puts "What would you like to do?"
  input = gets.chomp
  break if input == "exit"
end
end

def list_songs
  Song.all.sort{|a, b| a.name <=> b.name}.each_with_index{|x, index| puts "#{index+1}. #{x.artist.name} - #{x.name} - #{x.genre.name}" }
  # @new.files.sort{|a, b| a.split(" - ")[1] <=> b.split(" - ")[1]}.each_with_index{|x, index| puts "#{index+1}. #{x.split(".")[0]}"}
end

def list_artists
  Song.all.collect{|x| x.artist.name}.uniq.sort.each_with_index{|x, index| puts "#{index+1}. #{x}" }
  # @new.files.collect{|x| x.split(" - ")[0]}.uniq.sort.each_with_index{|x, index| puts "#{index+1}. #{x}" }
end

def list_genres
  @new.files.collect{|x| x.split(" - ")[2]}.uniq.sort.each_with_index{|x, index| puts "#{index+1}. #{x.split(".")[0]}" }
end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  input = gets.chomp
  if Artist.find_by_name(input)
  Artist.find_by_name(input).songs.sort{|a, b| a.name <=> b.name}.each_with_index{|x, index| puts "#{index+1}. #{x.name} - #{x.genre.name}"} unless nil
end
end

def list_songs_by_genre
  puts "Please enter the name of a genre:"
  input = gets.chomp
  if Genre.find_by_name(input)
  Genre.find_by_name(input).songs.sort{|a, b| a.name <=> b.name}.each_with_index{|x, index| puts "#{index+1}. #{x.artist.name} - #{x.name}"}
end
end

def play_song
  puts "Which song number would you like to play?"
  input = gets.chomp

end

end
