# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{default-url-options-for-mailers}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joe Moore", "Pivotal Labs"]
  s.date = %q{2010-11-24}
  s.description = %q{}
  s.email = %q{pivotal-opensource@googlegroups.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "lib/default_url_options_for_mailers.rb",
    "lib/default_url_options_for_mailers/default_url_options_for_mailers.rb",
    "lib/default_url_options_for_mailers/initializer.rb"
  ]
  s.homepage = %q{http://github.com/pivotal/default-url-options-for-mailers}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Default or infer the :protocol, :host, and :port values for ActionMailer}
  s.test_files = [
    "spec/default_url_options_for_mailers_spec.rb",
    "spec/rails_app/app/controllers/application_controller.rb",
    "spec/rails_app/app/helpers/application_helper.rb",
    "spec/rails_app/config/boot.rb",
    "spec/rails_app/config/environment.rb",
    "spec/rails_app/config/environments/development.rb",
    "spec/rails_app/config/environments/production.rb",
    "spec/rails_app/config/environments/test.rb",
    "spec/rails_app/config/initializers/action_controller.rb",
    "spec/rails_app/config/initializers/backtrace_silencers.rb",
    "spec/rails_app/config/initializers/cookie_verification_secret.rb",
    "spec/rails_app/config/initializers/inflections.rb",
    "spec/rails_app/config/initializers/mime_types.rb",
    "spec/rails_app/config/initializers/new_rails_defaults.rb",
    "spec/rails_app/config/initializers/pivotal.rb",
    "spec/rails_app/config/initializers/session_store.rb",
    "spec/rails_app/config/routes.rb",
    "spec/rails_app/db/seeds.rb",
    "spec/rails_app/test/performance/browsing_test.rb",
    "spec/rails_app/test/test_helper.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 2.3.8"])
    else
      s.add_dependency(%q<rails>, ["~> 2.3.8"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 2.3.8"])
  end
end

