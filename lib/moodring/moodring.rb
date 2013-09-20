#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'slop'
require 'httparty'


MOODRING_URL = ENV['MOODRING_URL'] || 'localhost:4567'

opts = Slop.parse({:help => true}) do
  banner 'Usage: moodring.rb [options]'

  on :l, :list, 'List all known moods'
  on :uri, 'Print API URL' do
    puts MOODRING_URL
  end
end

if opts[:list]
  response = HTTParty.get('http://' + MOODRING_URL + '/' + 'list')
  puts response
end
