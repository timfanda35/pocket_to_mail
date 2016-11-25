require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

require 'simplecov'
SimpleCov.start

require_relative "../lib/pocket_to_mail.rb"