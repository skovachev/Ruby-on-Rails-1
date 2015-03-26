class Object
  def blank?
    obj = respond_to?(:strip) ? strip : self
    return obj.empty? if obj.respond_to?(:empty?)
    obj != true
  end

  def present?
    blank? == false
  end

  def presence
    present? ? self : nil
  end

  def try(method_name = nil, &block)
    if block_given?
      instance_eval(&block) unless nil?
    else
      send(method_name) unless nil?
    end
  end
end