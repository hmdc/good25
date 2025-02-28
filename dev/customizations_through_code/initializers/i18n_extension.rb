# frozen_string_literal: true
module I18nExtension
  def t(key, **options)
    user_config = UserConfiguration.new(request_hostname: 'localhost')
    custom_value = user_config.send(:fetch, key)
    return custom_value unless custom_value.nil?

    super
  end
end

I18n.singleton_class.prepend(I18nExtension)

module TranslationHelperOverride
  def t(key, **options)
    I18n.t(key, **options).html_safe
  end
end

ActionView::Helpers::TranslationHelper.prepend(TranslationHelperOverride)
