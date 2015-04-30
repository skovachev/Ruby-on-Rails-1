module ApplicationHelper
    def field_valid(field)
        if flash[:errors]
            if flash[:errors].include? field
                'has-error'
            else
                'has-success'
            end
        end
    end

    def field_error_message(field)
        if flash[:errors] && (flash[:errors].include? field)
            output = ''
            flash[:errors][field].each do |message|
                output = output + (render partial: '/form_error_message', locals: { message: message })
            end
            output.html_safe
        end
    end
end
