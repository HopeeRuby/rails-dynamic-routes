# frozen_string_literal: true

class Page < ApplicationRecord
  include DynamicRouter

  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: 'parent_id'

  class_attribute :seo_image, default: ''

  after_save :hung_pham_cms_reload

  enum language: I18n.available_locales

  validates :language, presence: true

  def recursive_route
    parent.nil? ? route : "#{parent.recursive_route}#{route}"
  end

  def full_route
    "/#{language}#{recursive_route}"
  end

  # @param [string] key
  def self.get_by_key(key)
    @result = {}
    pages = where(key: key, visible: true)
    pages.each do |page|
      @result[page.language.to_s] = page
    end
    @result
  end

  def self.default_pages
    where(visible: true, language: I18n.default_locale).order(:id)
  end
end
