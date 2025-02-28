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