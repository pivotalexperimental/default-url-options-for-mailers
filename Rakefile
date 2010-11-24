task :default => :spec

desc "Run all specs in spec directory"
task :spec do |t|
  system "spec/runner spec"
end

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "default-url-options-for-mailers"
    gem.summary = "Default or infer the :protocol, :host, and :port values for ActionMailer"
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