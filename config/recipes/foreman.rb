namespace :foreman do
  # start/stop/export/logs, taken from https://gist.github.com/1047160
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do

    run "cd #{current_path} && rvmsudo bundle exec foreman export upstart /etc/init " +
        "-f ./Procfile.production -a #{application} -u #{user} -l #{shared_path}/log "
    end

  %w(start stop).each do |cmd|
    desc "#{cmd.capitalize} the application services"
    task cmd.to_sym, :roles => :app do
      sudo "#{cmd} #{application}"
    end
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "sudo start #{application} || sudo restart #{application}"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end

end
