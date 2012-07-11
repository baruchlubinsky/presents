module LayoutHelper
  
  def image_div(src, class_name='image_container')
    img = image_tag(src)
    container = content_tag(:div, img, :class => class_name)
  end
  
  def window_image(src)
    img = image_tag(src, :class => 'window_content')
    window = image_tag('window.png', :class => 'window_img')
    container = content_tag(:div, img + window, :class => 'window_container')
  end
  
end