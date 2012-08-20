module UploadHelper
  PLACE_HOLDER = '999'
  
  def multi_upload_tag(object_name, file_array, file_method, options={})
    #shown = self.upload_tag(file_array.to_s + '[0]', file_method, options)
    
    hidden = self.fields_for(object_name) {|f| upload_tag(object_name + '[' + file_array.to_s + "[#{PLACE_HOLDER}]" + ']', file_method, options)}
    shown_div = content_tag(:div, '', :id => 'upload_container')
    hidden_div = content_tag(:div, hidden, :id => 'upload_template', :class => 'hidden')

    script = button_to_function 'Add image', 'addFile()'    
      
    shown_div + hidden_div + script
  end
 
  def upload_tag(object_name, file_method, options={})
    @multipart = true
    self.fields_for(object_name) do |attachment|
      file = content_tag(:p, attachment.file_field(file_method.to_sym))
      label = attachment.label(('remote_' + file_method.to_s + '_url').to_sym, 'or image url')
      text = attachment.text_field(('remote_' + file_method.to_s + '_url').to_sym)
      url = content_tag(:p, (label + tag(:br) + text))
      source_label = attachment.label('source', 'Source')
      source_text = attachment.text_field('source')
      source = content_tag(:p, (source_label + tag(:br) + source_text)) 
      source_l_label = attachment.label('source_label', 'Source name')
      source_l_text = attachment.text_field('source_label')
      source_l = content_tag(:p, (source_l_label + tag(:br) + source_l_text))
      output = (file + url + source + source_l)
      if options.has_key?(:description)
        des_label = attachment.label(options[:description], "Image #{options[:description].to_s}")
        des_text = attachment.text_field(options[:description])
        output = output + content_tag(:p, (des_label + tag(:br) + des_text))
      end
      output
    end
  end
  
  def self.included(arg)
    ActionView::Helpers::FormBuilder.send(:include, FormBuilderMethods)
  end
  
  module FormBuilderMethods
    def multi_upload(file_array, file_method, options={})
      @template.multi_upload_tag(@object_name, file_array, file_method, options)
    end
  end
  
end



ActionView::Helpers::FormHelper.send(:include, UploadHelper)
