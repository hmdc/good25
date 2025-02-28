# frozen_string_literal: true

module SlurmMetrics
  # Service to manages retrieving and storing the user job metrics.
  class SessionMetricsService
    attr_reader :cluster

    def initialize
      @cluster = Configuration.job_clusters.select(&:slurm?).first
    end

    def read_job_metrics(session)
      file_path = job_metrics_path(session.id)
      return refresh_job_metrics(session) unless file_path.exist?

      # DEFAULT VALUE
      yml = {}
      begin
        yml = YAML.safe_load(file_path.read).deep_symbolize_keys || {}
      rescue => e
        Rails.logger.error("Can't read or parse job metrics: #{file_path} because of error #{e}")
      end

      SlurmMetrics::SessionMetrics.new(yml)
    end

    private

    def refresh_job_metrics(session)
      job_data = execute_slurm_command { cluster.job_adapter.metrics(job_ids: [session.job_id]) }
      processor = SlurmMetrics::MetricsProcessor.new
      job_state = job_data.find { |d| d[:user].present? }&.dig(:state)
      job_metrics = processor.calculate_metrics(Time.now, Time.now, job_data, ignore_cancelled: false)
      session_metrics = SlurmMetrics::SessionMetrics.create_metrics(job_state, job_metrics)

      job_metrics_file = job_metrics_path(session.id)
      job_metrics_file.write(session_metrics.to_hash.deep_stringify_keys.to_yaml)
      session_metrics
    end

    def job_metrics_path(session_id)
      BatchConnect::Session.dataroot.join('metrics').tap { |p| p.mkpath unless p.exist? }.join(session_id)
    end

    def execute_slurm_command
      yield
    rescue => e
      Rails.logger.error("Error executing Metrics command. Most likely timeout. Error: #{e}")
      []
    end

  end
end
