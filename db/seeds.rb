# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include DynamicRouter

puts 'Create page configs'
page_file = Rails.root + 'db/seed/pages.yml'
pages = YAML::load(File.open(page_file))

pages.to_h.each_pair do |k, v|
  I18n.available_locales.each do |locale|
    puts '================================='
    puts "Checking page #{k}-#{locale} 1%..."
    data = v.dig('general')
    translation = v.dig('translations', locale.to_s)
    c = data.merge translation
    page = Page.find_by_key_and_language(k, locale)
    puts "Checking page #{k}-#{locale} 50%..."
    unless page
      p = Page.new(c.merge({language: locale, key: k}))
      p.save!
      puts "Page #{k} created!"
    else
      unless page.route == c.dig('route')
        puts "Update route #{k}-#{locale} from #{page.route} --> #{c.dig('route')}"
        page.update(route: c.dig('route'))
      end

    end
    puts "Checking page #{k}-#{locale} 100%..."
    puts '================================='
  end
end

hung_pham_cms_load
