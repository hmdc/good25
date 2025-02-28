# frozen_string_literal: true

module SlurmMetrics
  # Class that holds all the session metrics data
  class SessionMetrics
    attr_accessor :state, :metrics

    def self.create_metrics(state, metrics)
      data = {
        state: state,
        metrics: metrics ? metrics.to_hash : {}
      }
      SlurmMetrics::SessionMetrics.new(data)
    end

    def initialize(data = {})
      data = data.deep_symbolize_keys
      @state = data[:state].blank? ? 'N/A' : data[:state]
      @metrics = SlurmMetrics::MetricsSummary.new(data.fetch(:metrics, {}))
    end

    def empty?
      metrics.empty?
    end

    def to_hash
      {
        state: state,
        metrics: metrics.to_hash
      }
    end
  end
end
