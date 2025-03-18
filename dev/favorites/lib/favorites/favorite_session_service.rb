# frozen_string_literal: true

module Favorites
  class FavoriteSessionService
    attr_reader :cluster

    def initialize
      @cluster = Configuration.job_clusters.select(&:slurm?).first
    end

    def read_favorite_sessions
      file_path = favorites_path

      # DEFAULT VALUE
      sessions = []
      return sessions unless file_path.exist?

      begin
        sessions = YAML.safe_load(file_path.read).symbolize_keys[:favorite_sessions] || []
      rescue => e
        Rails.logger.error("Can't read or parse favorite sessions: #{file_path} because of error #{e}")
      end

      sessions
    end

    def add_favorite(session_id)
      sessions = read_favorite_sessions
      sessions.push(session_id)
      file_path = favorites_path
      file_path.write({ 'favorite_sessions' => sessions }.to_yaml)
    end

    private

    def favorites_path
      BatchConnect::Session.dataroot.join('favorites.yml')
    end

  end
end
