redis: redis-server config/redis.conf
web: rails server
worker: rake environment resque:work QUEUE=* VERBOSE=1
log: tail -F log/*.log
