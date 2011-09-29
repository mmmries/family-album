module PictureHelper
  #thumbnails link to the picture#show action
  def picture_thumbnail(picture)
    return "<div class='picture-frame'><a href='/pictures/#{picture.id}'><img src='/pictures/#{picture.id}?size=thumbnail' /></a></div>".html_safe
  end
  
  #medium sized pictures link to the fullsize picture without a template
  def picture_medium(picture)
    return "<div class='picture-frame'><a href='/pictures/#{picture.id}?size=fullsize'><img src='/pictures/#{picture.id}?size=medium' /></a></div>".html_safe
  end
end
