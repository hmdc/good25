# frozen_string_literal: true
# MotdConcern extension
Rails.application.config.after_initialize do
  Rails.logger.info 'Executing MotdConcern extension ...'
  module MotdConcern
    def set_motd
      motd_path = @user_configuration.send(:fetch, 'motd_path', ENV['MOTD_PATH'])
      @motd = MotdFileWrapper.new(MotdFile.new(motd_path).formatter, @user_configuration.send(:fetch, 'motd_title'))
    end

    class MotdFileWrapper < SimpleDelegator
      def initialize(obj, custom_title)
        super(obj)
        @custom_title = custom_title
      end
      def title
        @custom_title ? @custom_title : super
      end
    end
  end

  Rails.logger.info 'Executing MotdConcern extension completed'
end