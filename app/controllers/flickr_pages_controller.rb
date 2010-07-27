class FlickrPagesController < Spree::BaseController
  
  require 'flickr_fu'
  
  before_filter :protect_from_forgery, :except => [:index, :gallery]
  
  def flickr_connect(tag)
    @flickr = Flickr.new('config/flickr.yml')
    config = YAML.load_file("config/flickr.yml")
    @user = config['user']
    
    @photos = @flickr.photos.search(:user_id => "#{@user}", :tags => "#{tag}")
    @results = @photos.paginate(:page => params[:page], :per_page => 16)
  end
  
  def index
    self.flickr_connect("favorites")

    respond_to do |format|
      format.html
    end
  end
  
  def gallery
    params[:tag] = "favorites" if !params[:tag]
    self.flickr_connect("#{params[:tag]}")
    
    respond_to do |format|
      format.html { render :template => '/flickr_pages/index.html.haml' }
    end
  end
  
end
