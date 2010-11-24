require File.join(File. dirname(__FILE__), "/spec_helper")

class DefaultUrlOptionsForMailersController < ApplicationController
  around_filter :set_default_url_options_for_mailers

#  def rescue_action(e) ; raise e; end
  def index
    DefaultUrlOptionsForMailersMailer.deliver_mail_with_url
    head :ok
  end
end

class DefaultUrlOptionsForMailersMailer < ActionMailer::Base
  def mail_with_url
  end
end

shared_examples_for "a good URL options citizen" do
  it "should preserve any pre-existing default_url_options which were explicitly set" do
    ActionMailer::Base.default_url_options[:protocol] = "https://"
    ActionMailer::Base.default_url_options[:host] = "mycustomhost"
    ActionMailer::Base.default_url_options[:port] = 1234
    execute_request(true, "NOTmycustomhost", "9999")
    latest_mail_should_include_link("https://mycustomhost:1234/")
  end

  it "should not overwrite any options when default_url_options are partially defined" do
    ActionMailer::Base.default_url_options[:protocol] = "https://"
    ActionMailer::Base.default_url_options[:host] = "mycustomhost"
    execute_request(true, "NOTmycustomhost", "9999")
    latest_mail_should_include_link("https://mycustomhost/")
  end

  it "should keep port blank if originally blank" do
    ActionMailer::Base.default_url_options.key?(:port).should be_false
    execute_request(false, "host", "800")
    ActionMailer::Base.default_url_options.key?(:port).should be_false
  end
end

describe "default_url_options_for_mailer" do
  include ActionController::TestProcess

  before(:each) do
    ActionMailer::Base.default_url_options = {}
  end

  context "when not used (outside of a request/controller)" do
    it "should default to mailing from existing default_url_options" do
      ActionMailer::Base.default_url_options[:protocol] = "https://"
      ActionMailer::Base.default_url_options[:host] = "mycustomhost"
      ActionMailer::Base.default_url_options[:port] = 1234
      DefaultUrlOptionsForMailersMailer.deliver_mail_with_url
      latest_mail_should_include_link("https://mycustomhost:1234/")
    end
  end

  context "when explicitly disabled" do
    before(:each) do
#      configure_default_url_options_for_mailers_with(nil)
      PivotalCore::Initializer::DefaultUrlOptionsForMailers.run { |config| config.action_controller.default_url_options_for_mailers = options }
      @controller = DefaultUrlOptionsForMailersController.new      
    end

    it "should default to mailing from existing default_url_options" do
      ActionMailer::Base.default_url_options[:protocol] = "https://"
      ActionMailer::Base.default_url_options[:host] = "mycustomhost"
      ActionMailer::Base.default_url_options[:port] = 1234
      execute_request(false, "host", "800")
      latest_mail_should_include_link("https://mycustomhost:1234/")
    end
  end

  context "when set to an explicit hash" do
    before(:each) do
      configure_default_url_options_for_mailers_with({ :host => "example.com", :protocol => "http", :port => 4217 })
    end

    it_should_behave_like "a good URL options citizen"

    it "should pass the specified host/port/protocols to all associated mailers" do
      mail_sent_from_domain_should_include_link(false, "host", "3333", "http://example.com:4217/")
    end

    it "should drop default port" do
      ActionController::Base.default_url_options_for_mailers[:port] = 80
      mail_sent_from_domain_should_include_link(false, "host", "80", "http://example.com/")
    end
  end

  context "when set to infer URL options" do
    before(:each) do
      configure_default_url_options_for_mailers_with(:infer_url_options)
    end

    it_should_behave_like "a good URL options citizen"

    it "should pass host/port/protocols from the request to all associated mailers" do
      mail_sent_from_domain_should_include_link(false, "host", "3333", "http://host:3333/")
    end

    it "should drop default port" do
      mail_sent_from_domain_should_include_link(false, "host", "80", "http://host/")
    end

    it "should handle SSL" do
      mail_sent_from_domain_should_include_link(true, "host", "3333", "https://host:3333/")
    end

    it "should handle SSL with default port" do
      mail_sent_from_domain_should_include_link(true, "host", "443", "https://host/")
    end
  end

  context "when set to some garbage" do
    before(:each) do
      configure_default_url_options_for_mailers_with("bad data here")
    end

    after(:each) do
      # Clean up so as not to affect later tests.  This is a class-level config option, after all.
      configure_default_url_options_for_mailers_with(nil)
    end

    it "should raise an exception (resulting in a non-successful response)" do
      lambda { execute_request(true, "ahost", "2342") }.should raise_error
      @response.should be_error
    end
  end

  private

  def configure_default_url_options_for_mailers_with(options)
    @controller = DefaultUrlOptionsForMailersController.new
#    @controller.class.send(:include, (PivotalCore::RailsCoreExtensions::DefaultUrlOptionsForMailers::ActionController))
    PivotalCore::Initializer::DefaultUrlOptionsForMailers.run { |config| config.action_controller.default_url_options_for_mailers = options }
  end

  def mail_sent_from_domain_should_include_link(is_ssl, host, port, expected_link)
    execute_request(is_ssl, host, port)
    latest_mail_should_include_link(expected_link)
  end

  def execute_request(is_ssl, host, port)
    @request = make_request_with(is_ssl, host, port)
    @response = ActionController::TestResponse.new

    get :index
    @response.should be_success
  end

  def latest_mail_should_include_link(expected_link)
    mail = ActionMailer::Base.deliveries.last
    mail.body.should include(expected_link)
  end

  def make_request_with(is_ssl, host, port)
    request = ActionController::TestRequest.new
    request.host = host
    request.env["SERVER_PORT"] = port
    request.env["HTTPS"] = is_ssl ? "on" : "off"
    request
  end
end