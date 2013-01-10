require 'capistrano_colors'
load 'config/recipes/foreman'

set :application, "xjwedding"
set :repository,  "git@github.com:loginx/rails-wedding.git"

set :scm, :git

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, 'production'
set :user, 'xavier'

# RVM config
set :rvm_ruby_string, "1.9.3@#{application}"
set :rvm_install_type, :stable


# Foreman config
set :foreman_procfile, "Procfile.production"
set :foreman_concurrency, "web=1,mailer=1"


# Servers
role :web, "xjdecember.com"                          # Your HTTP server, Apache/etc
role :app, "xjdecember.com"                          # This may be the same as your `Web` server
role :db,  "xjdecember.com", :primary => true        # This is where Rails migrations will run


# Web recipes
namespace :web do
  desc "Streams the appropriate server log"
  task :log, :roles => [:app, :web] do
    logfile = "#{shared_path}/log/#{rails_env}.log"
    trap("INT") { puts "\nInterupted"; exit 0; }
    stream("tail -f #{logfile}")
  end
end

# Infrastructure recipes
namespace :servers do
  task :setup_logrotate, :roles => [:app, :web] do
    template = File.read(File.join(File.dirname(__FILE__), 'recipes', 'templates', 'logrotate.conf.erb'))
    buffer   = ERB.new(template).result(binding)
    put buffer, "#{shared_path}/logrotate.conf"
  end
end

namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

# Callbacks
before 'deploy', 'rvm:install_rvm'
before 'deploy', 'rvm:install_ruby'
after 'setup', 'logrotate:create_conf'
after 'setup', 'deploy:seed'
after "deploy:restart", "deploy:cleanup"
after "deploy:restart", "foreman:export", "foreman:restart"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# Dependencies
require './config/boot'
require 'rvm/capistrano'
require 'bundler/capistrano'

# Uncomment this once the official foreman-capistrano integration is fixed.
# require 'foreman/capistrano'

# Uncomment this if you have a paid airbrake account
# require 'airbrake/capistrano'
