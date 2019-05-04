module MultiProjectConfigurationMiddleware 
  class Auth
    def initialize(app)
      @app = app
    end

    def call(env)
      ::Tramway::Auth::ApplicationController.include MultiProjectCallbacks::Auth::Application

      @app.call(env)
    end
  end
end

module MultiProjectCallbacks
  module Auth
    module Application
      extend ActiveSupport::Concern

      included do
        before_action :load_application

        def load_application
          engine_loaded = Constraints::DomainConstraint.new(request.domain).engine_loaded
          engine_module = "::Tramway::#{engine_loaded.camelize}".constantize
          @application = "#{engine_module}::#{engine_module.application.to_s.camelize}".constantize.first
          @application_engine = engine_loaded
        end
      end
    end
  end
end
