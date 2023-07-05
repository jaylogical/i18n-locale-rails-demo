# frozen_string_literal: true

class DomainRegionMapper
  DEFAULT_LOCALE = :en
  DEFAULT_TLD = 'com'

  TLD_LOCALE_MAPPING = {
    'de'  => :de,
    'com' => :en,
    'fr'  => :fr
  }.freeze

  ###################
  ## Class Methods ##
  ###################

  # Take a locale as string or symbol and return the mapped TLD
  # === Parameters
  # * <tt>locale</tt> - Locale for TLD mapping
  def self.tld_for_locale(locale)
    locale ||= DEFAULT_LOCALE
    inverted_mapping_table.fetch(locale.to_sym, DEFAULT_TLD)
  end

  ######################
  ## Instance methods ##
  ######################

  # * <tt>domain</tt> - The domain for this mapper
  def initialize(domain)
    @domain = domain || 'example.com' # For checking via IP in Dev-Mode
  end

  # Maps and returns the locale of the given domain at initialization
  #
  # === List
  # * domain.de => :de
  # * domain.com => :en
  # * else => :en
  def locale
    @locale ||= TLD_LOCALE_MAPPING.fetch(tld, DEFAULT_LOCALE)
  end

  # Returns the given TLD of the given domain at initialization
  def tld
    @tld ||= @domain.split('.').pop
  end

  #############
  ## private ##
  #############

  # Returns and cache the inverted TLD_LOCALE_MAPPING
  private_class_method def self.inverted_mapping_table
    @inverted_mapping_table ||= TLD_LOCALE_MAPPING.invert
  end
end
