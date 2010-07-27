map.connect '/photos', :controller => 'flickr_pages', :action => 'index'
map.connect '/photos/:tag', :controller => 'flickr_pages', :action => 'gallery'