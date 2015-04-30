module ApplicationHelper
    def field_valid(field, form = nil)
        errors = flash[:errors] if form.nil?
        errors = form.object.errors unless form.nil?
        if errors && errors.any?
            if errors.include? field
                'has-error'
            else
                'has-success'
            end
        end
    end

    def field_error_message(field, form = nil)
        errors = flash[:errors] if form.nil?
        errors = form.object.errors unless form.nil?
        if errors && errors.any? && (errors.include? field)
            output = ''
            errors[field].each do |message|
                output = output + (render partial: '/form_error_message', locals: { message: message })
            end
            output.html_safe
        end
    end
end
