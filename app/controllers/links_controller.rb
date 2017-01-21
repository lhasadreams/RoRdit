require 'uri'

class LinksController < ApplicationController
  before_action :authorize, only: [:new, :create]
  before_action :get_links_count, only: [:get_newest_links, :get_popular_links]

  PER_PAGE = 10

  def index
  end

  def new
  end

  def show
  end

  def create
    link = Link.new(title: link_params[:title], url: link_params[:url], user_id: @current_user.id,
                    username: @current_user.username, hostname: URI.parse(link_params[:url]).hostname.sub(/^www\./, ''))
    if link.save
      Rails.cache.delete("links_count")
      render json: { message: links_path(link.id) }, status: 200
    else
      render json: { message: model_errors_json(link) }, status: 422
    end
  end

  def get_search_results
    result = Link.__elasticsearch__.search(link_params[:search]).records
    paged_links = result.paginate(link_params[:page].to_i, PER_PAGE)
    page_count = pages_count(result.count)
    render json: { links: paged_links.as_json, page_count: page_count }
  end

  def get_popular_links
    paged_links = Link.order("popularity DESC").paginate(link_params[:page].to_i, PER_PAGE)
    render json: { links: paged_links.as_json, page_count: @page_count }
  end

  def get_newest_links
    paged_links = Link.order("created_at DESC").paginate(link_params[:page].to_i, PER_PAGE)
    render json: { links: paged_links.as_json, page_count: @page_count }
  end

  def get_link
    @link = Link.find_by(id: link_params[:id])
    render json: @link.as_json
  end

  private

  def get_links_count
    links_count = Rails.cache.fetch("links_count") { Link.count }
    @page_count = pages_count(links_count)
  end

  def pages_count(count)
    if (count % PER_PAGE) == 0
      (count / PER_PAGE) - 1
    elsif (count / PER_PAGE) < 1
      0
    else
      (count / PER_PAGE)
    end
  end

  def link_params
    params.permit(:id, :utf8, :authenticity_token, :url, :title, :page, :search)
  end
end
