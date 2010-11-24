require 'rubygems'
require 'rake'
require "spec"
require "spec/autorun"
#require 'spec/rails'

#require 'rspec'
#require 'rspec/core'
#require 'rspec/core/rake_task'

task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
task :default do |t|
  system "spec/runner spec"
#  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
#  t.pattern = 'spec/**/*_spec.rb'
end

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "default-url-options-for-mailers"
    gem.summary = ""
    gem.description = ""
    gem.email = "pivotal-opensource@googlegroups.com"
    gem.homepage = "http://github.com/pivotal/default-url-options-for-mailers"
    gem.authors = ["Joe Moore","Pivotal Labs"]
    gem.files = Dir["{lib}/**/*"]
    gem.add_dependency "rails", '~> 2.3.8'
  end
rescue
  puts "Jeweler or one of its dependencies is not installed."
end