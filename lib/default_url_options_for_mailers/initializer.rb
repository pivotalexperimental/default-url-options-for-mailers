module PivotalCore
  class Configuration
    def action_controller
      @action_controller ||= Rails::OrderedOptions.new
    end

    def active_record
      @active_record ||= Rails::OrderedOptions.new
    end
  end

  class Initializer
    class DefaultUrlOptionsForMailers
      def self.run
        configuration = Configuration.new
        yield(configuration) if block_given?

        new(configuration).process
      end

      def initialize(configuration)
        @configuration = configuration
      end

      def process
        process_action_controller_configuration(@configuration)
      end

      private

      def process_action_controller_configuration(configuration)
        if configuration.action_controller.default_url_options_for_mailers
          ActionController::Base.class_eval do
            include PivotalCore::RailsCoreExtensions::DefaultUrlOptionsForMailers::ActionController
          end
          ActionController::Base.instance_eval do
            cattr_accessor :default_url_options_for_mailers
            self.default_url_options_for_mailers = configuration.action_controller.default_url_options_for_mailers
          end
        end
      end
    end
  end
end
