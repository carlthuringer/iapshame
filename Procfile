web: middleman
redis: redis-server config/redis-development.conf
worker: rake environment resque:work QUEUE=* VERBOSE=1
log: tail -F log/*.log
