module PivotalCore
  module RailsCoreExtensions
    module DefaultUrlOptionsForMailers
      module ActionController
        def self.included(ac)
          ac.module_eval do
            include InstanceMethods
            around_filter :set_default_url_options_for_mailers
          end
        end

        module InstanceMethods
          def set_default_url_options_for_mailers
            save_current_url_options
            begin
              new_url_options = calculate_new_url_options
              ::ActionMailer::Base.class_eval { self.default_url_options = new_url_options if default_url_options.empty? }

              yield
            ensure
              restore_previous_url_options
            end
          end

          private

          def calculate_new_url_options
            if ::ActionController::Base.default_url_options_for_mailers.is_a?(Hash)
              returning(::ActionController::Base.default_url_options_for_mailers) do |url_options|
                url_options.delete(:port) if standard_port?(self.request, url_options[:port])
              end
            elsif ::ActionController::Base.default_url_options_for_mailers == :infer_url_options
              inferred_url_options_for(self.request)
            else
              raise "Invalid option for default_url_options_for_mailers: #{::ActionController::Base.default_url_options_for_mailers}"
            end
          end

          def inferred_url_options_for(request)
            returning({ :protocol => request.protocol, :host => request.host }) do |url_options|
              url_options[:port] = request.port unless standard_port?(request, request.port)
            end
          end

          def standard_port?(request, port)
            port == request.standard_port
          end

          def save_current_url_options
            ::ActionMailer::Base.class_eval do
              @old_default_url_options = default_url_options.clone
            end
          end

          def restore_previous_url_options
            ::ActionMailer::Base.class_eval do
              [:host, :port, :protocol].each do |key|
                if @old_default_url_options.key?(key)
                  default_url_options[key] = @old_default_url_options[key]
                else
                  default_url_options.delete(key)
                end
              end
            end
          end
        end
      end
    end
  end
end
