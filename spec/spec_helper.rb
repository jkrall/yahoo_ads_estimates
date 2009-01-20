require "rubygems"
require "spec"
# gem install redgreen for colored test output
begin require "redgreen" unless ENV['TM_CURRENT_LINE']; rescue LoadError; end

Spec::Runner.configure do |config|
end

require File.expand_path(File.dirname(__FILE__) + "/../lib/yahoo_ads_estimates")

RAILS_ROOT = File.expand_path(File.dirname(__FILE__))