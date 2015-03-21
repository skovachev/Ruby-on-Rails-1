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

class StringInquirer
  def initialize(string)
    @string = string
  end

  def method_missing(method)
    "#{@string}?".to_sym == method
  end
end

class String
  def inquiry
    StringInquirer.new self
  end
end
