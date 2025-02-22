# frozen_string_literal: true
# ConfigurationSingleton extension
Rails.application.config.after_initialize do
  Rails.logger.info 'Executing Configuration extension ...'
  class ConfigurationSingleton

    def config
      read_config
    end

    def can_access_core_app?(name)
      true
    end
  end

  Rails.logger.info 'Executing Configuration extension completed'
end
