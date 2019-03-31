require_relative "../lib/concerns/findable.rb"

class Genre

extend Concerns::Findable

@@all = []

attr_accessor :name, :song, :artist

def initialize(name)
  @name = name
  @songs = []
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

def self.create(name)
  genre = self.new(name)
  genre.save
  genre
end

def songs
  @songs
end

def artists
  self.songs.collect{|song| song.artist }.uniq
end

def add_song(song)
  self.songs << song unless self.songs.include?(song)
  song.genre = self if song.genre == nil
end

end
