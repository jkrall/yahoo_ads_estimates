require 'rake'
require 'rake/rdoctask'
require 'rubygems'
require 'spec'
require 'spec/rake/spectask'

desc 'Generate documentation for the yahoo_ads_estimates plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'YahooAdsEstimates'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Run all specs in spec directory with RCov"
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = lambda do
    IO.readlines(File.dirname(__FILE__) + "/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
  end
end

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov => :rcov) do |t|
  t.threshold = 96.9 # Make sure you have rcov 0.7 or higher!
end

Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

remove_task "default"
task :default do
  Rake::Task["verify_rcov"].invoke
end



begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "yahoo_ads_estimates"
    gemspec.summary = "Rails plugin for querying Yahoo Ads for estimated CPC, impressions, and clicks"
    gemspec.email = "josh@transfs.com"
    gemspec.homepage = "http://github.com/jkrall/yahoo_ads_estimates"
    gemspec.authors = ["Joshua Krall"]
    gemspec.add_dependency('json')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
