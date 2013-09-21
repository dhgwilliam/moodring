#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'slop'
require 'httparty'


MOODRING_URL = ENV['MOODRING_URL'] || 'localhost:4567'

class MoodringAPI
  def self.get(endpoint, v = 'v1')
    HTTParty.get('http://' + MOODRING_URL + "/api/#{v}/" + endpoint)
  end
end

opts = Slop.parse({:help => true}) do
  banner 'Usage: moodring.rb [options]'

  on :uri, 'Print API URL' do
    puts MOODRING_URL
  end

  command 'list' do
    run do
      puts MoodringAPI.get('list')
    end
  end
end
