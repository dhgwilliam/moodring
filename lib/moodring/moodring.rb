#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'slop'
require 'httparty'
require 'yajl'


MOODRING_URL = ENV['MOODRING_URL'] || 'localhost:4567'
MOODRING_API = ENV['MOODRING_API'] || 'v1'

class MoodringAPI
  def self.get(endpoint)
    HTTParty.get('http://' + MOODRING_URL + "/api/#{MOODRING_API}/" + endpoint)
  end

  def self.post(endpoint, opts = {})
    options = { :body => Yajl::Encoder.encode(opts) }
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
      puts response.body
    end
  end

  command 'trait' do
    on :new, 'Create new trait'
    on :name=, 'Specify trait name'
    on :valence=, 'Specify trait valence'
    on :arousal=, 'Specify trait arousal'

    run do |trait, args|
      if trait[:new]
        response = MoodringAPI.post("trait/new", {
          :name => trait[:name],
          :valence => trait[:valence],
          :arousal => trait[:arousal]
        })
      else
        name = trait[:name] || args.first
        response = MoodringAPI.get("trait/by/name/#{name}")
      end
      puts response.code unless response.code == 200
      puts response.body
    end
  end

  command 'set' do
    on :new, 'Initiate a new Set (test)'

    run do |set|
      if set[:new]
        response = MoodringAPI.post("set/new")
      end
      puts response.code unless response.code == 200
      puts response.body
    end
  end
end
