## Overview
`default-url-options-for-mailers` allows us to set or infer `ActionController::Base.default_url_options` within the context of a `ActionMailer` deliver event.

This functionality is inspired by [How I Learned to Stop Hating and Love Action Mailer](http://pivotallabs.com/users/nick/blog/articles/281-how-i-learned-to-stop-hating-and-love-action-mailer "nick - How I Learned to Stop Hating and Love Action Mailer").  Quoting from that post heavily, `ActionMailer` makes it difficult to generate URL's. It's common enough when sending an email that it includes a link. But `ActionMailer`, by default, gives you no access to `url_for` or named routes.  One solution to this is to manually set `ActionController::Base.default_url_options`, but this is a global change and would affect all Controller actions.  Also, it is often preferable to have these values be inferred from the local environment.  `default-url-options-for-mailers` allows for setting or inferring these values within the context of a mail-sending action.

## Installation
Install `default-url-options-for-mailers` as a gem.

## Usage
Here is a sample initializer.

     # your_rails_app/config/initializers/pivotal_initializers.rb
     PivotalCore::Initializer::DefaultUrlOptionsForMailers.run do |config|
       # *** Use this line to automatically derive protocol/host/port using incoming rails request:
       # PivotalCore::Initializer::DefaultUrlOptionsForMailers.run
       # config.action_controller.default_url_options_for_mailers = :infer_url_options

       # *** Use this line to explicitly set protocol/host/port:
       # config.action_controller.default_url_options_for_mailers = { :protocol => "http", :host => "example.com", :port => 3333 }

       # *** Comment out both lines to disable any default URL option functionality for mailers.

       # *** NOTE: ActionMailer::Base.default_url_options always takes precedence over this facility and if *any* options are
       # *** set there, default_url_options_for_mailers does nothing.
     end

## Requirements
To initialize properly, this gem requires Rails 2.3.8 or above.

## Running Tests and Build Dependencies
Below is a sample Gemfile used to create and test this gem.

     # Gemfile
     source "http://rubygems.org"
     
     gem "rails", "2.3.8"
     gem "rspec-rails", "1.3.3"
     gem "sqlite3-ruby", "1.3.2"
     gem "jeweler", "1.5.1"

## MIT License

Copyright (c) 2010 Pivotal Labs (www.pivotallabs.com)
Contact email: info@pivotallabs.com

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.