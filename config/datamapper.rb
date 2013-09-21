require 'dm-core'
require 'dm-redis-adapter'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, {:adapter  => "redis"})
