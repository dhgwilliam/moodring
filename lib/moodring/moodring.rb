#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'slop'
require 'httparty'


MOODRING_URL = ENV['MOODRING_URL'] || 'localhost:4567'
MOODRING_API = ENV['MOODRING_API'] || 'v1'

class MoodringAPI
  def self.get(endpoint)
    HTTParty.get('http://' + MOODRING_URL + "/api/#{MOODRING_API}/" + endpoint)
  end

  def self.post(endpoint, options = {})
    HTTParty.post('http://' + MOODRING_URL + "/api/#{MOODRING_API}/" + endpoint, options)
  end
end

opts = Slop.parse({:help => true}) do
  banner 'Usage: moodring.rb [options]'

  on :uri, 'Print API URL' do
    puts MOODRING_URL
  end

  command 'list' do
    run do
      puts MoodringAPI.get('list').body
    end
  end

  command 'test' do
    on :new, 'Initiate test'
    on :user=, 'Supply user id'

    run do |test_opts|
      response = MoodringAPI.post("test/#{test_opts[:user]}/new")
      puts response.code
      puts response.body.to_s
    end
  end
end
