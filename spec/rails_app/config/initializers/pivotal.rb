require File.expand_path(File.join(__FILE__, '../../../../../lib/default_url_options_for_mailers'))

PivotalCore::Initializer::DefaultUrlOptionsForMailers.run do |config|
  # *** Default URL Options For Mailers ***
  # Use this line to automatically derive protocol/host/port using incoming rails request:
  #  PivotalCore::Initializer::DefaultUrlOptionsForMailers.run
  #  config.action_controller.default_url_options_for_mailers = :infer_url_options

  # Use this line to explicitly set protocol/host/port:
  # config.action_controller.default_url_options_for_mailers = { :protocol => "http", :host => "example.com", :port => 3333 }

  # Comment out both lines to disable any default URL option functionality for mailers.

  # NOTE: ActionMailer::Base.default_url_options always takes precedence over this facility and if *any* options are
  # set there, default_url_options_for_mailers does nothing.
end
