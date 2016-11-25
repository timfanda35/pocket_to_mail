require 'bundler/setup'
Bundler.require

require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test' << '.'
  t.test_files = Dir.glob('test/**/*test.rb')
  t.ruby_opts << "-r test_helper"
end

task :default => [:test]

# Main App
require_relative 'main.rb'

desc "run pocket to mail service"
task :run do
  Dotenv.load

  ap Main.new.run
end