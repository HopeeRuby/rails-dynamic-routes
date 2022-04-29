module ApplicationHelper
  # @param [string] default
  def title(default = 'Home')
    if @page.present?
      @page.seo_title.present? ? @page.seo_title : @page.title
    else
      default
    end
  end
end
