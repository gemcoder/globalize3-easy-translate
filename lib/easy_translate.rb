module EasyTranslate
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    def easy_translate( options = {})
      if !options.empty?
        begin
          if options.length == 0
            options = {:locales => I18n.available_locales}
          end
        rescue
        options = {}
        end
      end
      
      options[:locales].each do |this_locale|
        translated_attribute_names.each do |this_method|
          class_eval(%|def #{this_locale}_#{this_method}; globalize.fetch("#{this_locale}","#{this_method}"); end;|)
          class_eval("def #{this_locale}_#{this_method}=(this_value);" + %|globalize.write("#{this_locale}","#{this_method}", this_value); end;|)
        end unless translated_attribute_names.empty?
      end if options[:locales]
    end
  end  
end
