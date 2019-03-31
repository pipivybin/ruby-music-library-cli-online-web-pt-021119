require_relative "../lib/concerns/findable.rb"


class Song

extend Concerns::Findable


attr_accessor :name, :genre

@@all = []

def initialize(name, artist = nil, genre = nil)
  @name = name
  self.artist = artist unless artist == nil
  self.genre = genre unless genre == nil
end

def save
  self.class.all << self
end

def self.destroy_all
  self.all.clear
end

def self.all
  @@all
end

def artist=(artist)
  @artist = artist
  artist.add_song(self)
end

def artist
  @artist
end

def genre
  @genre
end

def genre=(genre)
  @genre = genre
  genre.songs << self unless genre.songs.include?(self)
end

def self.new_from_filename(filename)
  songname = filename.split(" - ")[1]
  songartistname = filename.split(" - ")[0]
  songgenre = filename.split(" - ")[2].split(".")[0]
  song = self.find_or_create_by_name(songname)
  artist = Artist.find_or_create_by_name(songartistname)
  genre = Genre.find_or_create_by_name(songgenre)
  song.artist = artist
  song.genre = genre
  genre.add_song(song)
  song
end

def self.create(name)
  song = self.new(name)
  song.save
  song
end

def self.create_from_filename(filename)
  self.new_from_filename(filename)
end

end
