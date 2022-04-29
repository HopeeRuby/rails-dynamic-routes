# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :load_page

  def show; end

  def load_page
    @page = Page.find_by_id(params[:page_id]) if params[:page_id].present?
  end
end
