# SessionsHelper Extensions to add job metrics to session card in OODv3.x
Rails.application.config.after_initialize do
  Rails.logger.info 'Executing Sessions Helper extension ...'
  module BatchConnect::SessionsHelper
    # UPDATE session_view TO ADD JOB METRICS PARTIAL
    # THIS OVERRIDE IS ONLY REQUIRED FOR OODv3.x
    def session_view(session)
      capture do
        concat(
          content_tag(:div) do
            concat content_tag(:div, cancel_or_delete(session), class: 'float-right')
            concat host(session)
            concat created(session)
            concat render_session_time(session)
            concat id(session)
            concat support_ticket(session) unless @user_configuration.support_ticket.empty?
            if SlurmMetrics::MetricsHelper.new.session_metrics_enabled?(@user_configuration) && session.completed?
              concat render(partial: 'batch_connect/sessions/card/session_job_metrics', locals: { session: session })
            end
            concat display_choices(session)
            safe_concat custom_info_view(session) if session.app.session_info_view
            safe_concat completed_view(session) if session.app.session_completed_view && session.completed?
          end
        )
        concat content_tag(:div) { yield }
      end
    end
  end

  Rails.logger.info 'Executing Sessions Helper completed'
end