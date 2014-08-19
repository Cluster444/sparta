require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/nginx'
require 'mina/rvm'    # for rvm support. (http://rvm.io)

set :application, 'sparta'
set :domain, 'sparta-app.com'
set :port, 10679
set :user, 'deployer'
set :deploy_to, '/var/www/sparta'
set :repository, 'git@github.com:Cluster444/sparta'
set :branch, 'master'
set :forward_agent, true
set :nginx_config, "#{deploy_to}/current/config/nginx/production.conf"

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log']

task :environment do
  invoke :'rvm:use[ruby-2.1.2@sparta]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/assets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/assets"]

  queue! %[mkdir -p "#{deploy_to}/shared/pids"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'nginx:link'
    invoke :'nginx:reload'

    to :launch do
      invoke :'unicorn:restart'
    end
  end
end

namespace :unicorn do
  set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
  set :start_unicorn, %[
    cd #{deploy_to}/current
    bundle exec unicorn -c #{deploy_to}/current/config/unicorn/production.rb -E production -D
  ]

  desc "Start Unicorn"
  task :start => :environment do
    queue 'echo "------> Start Unicorn"'
    queue! start_unicorn
  end

  desc "Stop Unicorn"
  task :stop do
    queue 'echo "------> Stop Unicorn"'
    queue! %[
      test -s "#{unicorn_pid}" && kill -QUIT `cat "#{unicorn_pid}"` && echo "Stop OK" && exit 0
      echo >&2 "Not Running"
    ]
  end

  desc "Restart Unicorn"
  task :restart do
    invoke :'unicorn:stop'
    invoke :'unicorn:start'
  end
end
