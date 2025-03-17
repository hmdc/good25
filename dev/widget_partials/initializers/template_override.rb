# ApplicationController patch to control the lookup path of templates.
# This customization allows a template override to use the original template as part of the content.
# Very useful to add custom content before or after the original template content.
#
# When overriding a template, if you add the _custom to the original name of the template, it will use this file for the content.
# Only works for templates that are render from a controller. Any render partials will not trigger this logic.
# Sample: ./dev/widget_partials/views/batch_content/sessions/index_custom.html.erb
#
module CustomTemplateOverride
  def render(*args, **kwargs, &block)
    controller_path = self.class.name.sub("Controller", "").underscore
    template_name = args.first || action_name
    custom_template = "#{controller_path}/#{template_name}_custom"
    Rails.logger.info "template: #{custom_template} - Exists: #{lookup_context.exists?(custom_template, [], false)}"
    if lookup_context.exists?(custom_template, [], false)
      args[0] = "#{template_name}_custom" # Modify the template name
    end

    super(*args, **kwargs, &block) # Call original render method
  end
end

Rails.application.config.to_prepare do
  Rails.logger.info 'Executing Template Override extension ...'
  ApplicationController.prepend(CustomTemplateOverride)
end