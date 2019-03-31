require_relative "../lib/concerns/findable.rb"

class Artist

extend Concerns::Findable

@@all = []

attr_accessor :name, :song, :genre

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
  artist = self.new(name)
  artist.save
  artist
end

def songs
  @songs
end

def add_song(song)
  self.songs << song unless self.songs.include?(song)
  song.artist = self if song.artist == nil
end

def genres
  self.songs.collect{|song| song.genre}.uniq
end


end
