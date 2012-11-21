require 'sinatra'
require 'yaml'

helpers do
  def get_config(filename, section)
    path = File.join(File.dirname(__FILE__), '..', 'config')
    file = File.new(File.join(path, filename) , "r")
    yaml = YAML.load_file file.path
    yaml[section]
  end
end
