require 'formtastic/inputs/base/labelling'
module Formtastic
  module Inputs
    module Base
      module Labelling

        include Formtastic::LocalizedString

        def label_html
          render_label? ? builder.label(input_name, label_text, label_html_options) : "".html_safe
        end

        def label_html_options
          {
            :for => input_html_options[:id],
            :class => ['formtastic-label'],
          }
        end

      end
    end
  end
end
