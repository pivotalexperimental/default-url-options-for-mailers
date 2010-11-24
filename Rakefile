task :default => :spec

desc "Run all specs in spec directory"
task :spec do |t|
  system "spec/runner spec"
end

task :install_test_gems do |t|
  system "gem install rails -v2.3.8 --no-rdoc --no-ri"
  system "gem install rspec-rails -v1.3.3 --no-rdoc --no-ri"
  system "gem install sqlite3-ruby -v1.3.2 --no-rdoc --no-ri"
  system "gem install jeweler -v1.5.1 --no-rdoc --no-ri"
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
  puts "To run specs, run `rake install_test_gems`"
end