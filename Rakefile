require 'bundler/setup'
Bundler.require

require_relative 'main.rb'

desc "run pocket to mail service"
task :run do
  Dotenv.load

  ap Main.new.run
end