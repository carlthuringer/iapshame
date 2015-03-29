# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'iapshame'
set :repo_url, 'git@github.com:carlthuringer/iapshame.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
 set :deploy_to, '/var/iapshame'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute :restart, 'resque-worker', 'ID=1'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      with APP_ENV: 'production' do
         within release_path do
           execute 'bin/middleman', 'build'
         end
      end
    end
  end
end
