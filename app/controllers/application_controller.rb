# frozen_string_literal: true

require 'domain_region_mapper'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  def locale_from_params
    p 1_111_111_111
    return unless params.key?(:locale)

    locale = params[:locale]
    LocaleDemo::AVAILABLE_LOCALES.include?(locale) ? locale : 'fr'
  end

  def set_locale
    p 33_333_333_333_333
    p session
    p 777_777
    session[:locale] = locale_from_params if locale_from_params.present?
    session[:locale] = current_user&.locale
    session[:locale] ||= current_domain_region_mapper.locale

    I18n.locale = session[:locale]
  end

  def current_domain_region_mapper
    @current_domain_region_mapper ||= DomainRegionMapper.new(request.domain)
  end
end
