# Set these for the deployment
app_name  = "sparta"
rails_env = "production"

app_path = "/var/www/#{app_name}"
working_directory "#{app_path}/current"
stderr_path "#{app_path}/shared/log/unicorn_stderr.log"
stdout_path "#{app_path}/shared/log/unicorn_stdout.log"
pid_file "#{app_path}/shared/pids/unicorn.pid"

# Raise the worker processes to be cpu cores + 1 if needed
worker_processes 2
listen "/tmp/unicorn-#{app_name}_#{rails_env}.sock", backlog: 64
timeout 60
preload_app true

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

before_fork do |server,worker|
  ActiveRecord::Base.connection.disconnect! if defined? ActiveRecord::Base

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server,worker|
  ActiveRecord::Base.establish_connection if defined? ActiveRecord::Base
end
