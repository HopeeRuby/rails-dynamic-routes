# frozen_string_literal: true

module DynamicRouter

  module_function
  def page_routes
    @list = []
    begin
      Page.where(visible: true, parent: nil).order(:priority).each do |page|
        push_route(@list, page)
        recursive_generate(page, @list)
      end
    rescue
      puts 'Can not create dynamic page route'
    end
    @list
  end

  def recursive_generate(page, list)
    visible_children = page.children.where(visible: true)
    visible_children&.each do |item|
      push_route(list, item)
      recursive_generate(item, list)
    end
  end

  def hung_pham_cms_load
    Rails.application.routes.draw do
      page_routes.each do |page|
        get page[:route], to: page[:to], defaults: { page_id: page[:id], locale: page[:language] }, as: page[:as], constraints: page[:constraints]
      end
    end
  end

  def hung_pham_cms_reload
    Rails.application.routes_reloader.reload!
  end

  private

  def push_route(list, page)
    route = { id: page.id, route: page.full_route, to: route_to(page), language: page.language, as: route_as(page) }

    if page.settings.present?
      route[:constraints] = {}
      page.settings.each do |key, value|
        route[:constraints][key.to_sym] = Regexp.new(value)
      end
    end

    list.push(route) unless list.include? route
  end

  def route_to(page)
    "#{page.controller || 'pages'}##{page.action || 'show'}"
  end

  def route_as(page)
    "#{page.language}_#{page.key}"
  end
end
