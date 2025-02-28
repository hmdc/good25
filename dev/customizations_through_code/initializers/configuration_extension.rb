# frozen_string_literal: true
# ConfigurationSingleton extension
Rails.application.config.after_initialize do
  Rails.logger.info 'Executing Configuration Globus/Developer extension ...'
  class ConfigurationSingleton

    def app_development_enabled?
      true
    end

    def developer_docs_url
      default_value = ENV['OOD_DASHBOARD_DEV_DOCS_URL'] || "https://go.osu.edu/ood-app-dev"
      user_config = UserConfiguration.new(request_hostname: 'localhost')
      user_config.send(:fetch, 'developer_docs_url', default_value)
    end

    def globus_endpoints
      user_config = UserConfiguration.new(request_hostname: 'localhost')
      user_config.send(:fetch, 'globus_endpoints')
    end
  end

  Rails.logger.info 'Executing Configuration Globus/Developer completed'
end
