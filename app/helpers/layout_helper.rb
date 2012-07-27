module LayoutHelper
  
  def image_div(src, class_name='image_container')
    img = image_tag(src)
    container = content_tag(:div, img, :class => class_name)
  end
  
  def image_card(img)
    image = image_tag(img.file_url(:story), :data_full_size => img.file_url(:large))
    conatiner = content_tag(:div, image, :class => 'card')
  end
  
  def window_image(src)
    img = image_tag(src, :class => 'window_content')
    window = image_tag('window.png', :class => 'window_img')
    container = content_tag(:div, img + window, :class => 'window_container')
  end
  
end