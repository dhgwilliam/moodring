require 'dm-core'
require 'dm-validations'
require 'dm-redis-adapter'
require 'dm-migrations'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, {:adapter  => "redis"})
DataMapper.auto_upgrade!
