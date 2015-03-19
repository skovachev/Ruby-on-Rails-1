def delegate(*methods)

    options = methods.pop

    unless options.is_a?(Hash) && to = options[:to]
        raise ArgumentError, 'Delegation needs a target. Supply an options hash with a :to key as the last argument.'
    end

    to = to.to_s
    to = 'self.class' if to == 'class'

    methods.each do |method|

        definition = (method =~ /[^\]]=$/) ? 'arg' : '*args, &block'

        exception = %(raise DelegationError, "#{self}##{method} delegated to #{to}.#{method}, but #{to} is nil")

        method_def = [
            "def #{method}(#{definition})",  
            " _ = #{to}",                             
            "  _.#{method}(#{definition})",         
            "rescue NoMethodError => e",         
            "  if _.nil? && e.name == :#{method}",    
            "    #{exception}",                        
            "  else",                            
            "    raise",                   
            "  end", 
            "end"
        ].join ';'

        module_eval(method_def)
    end
end

User = Struct.new(:first_name, :last_name)

class Invoice
    delegate :first_name, :last_name, to: :'@user'

    def initialize(user)
        @user = user
    end
end

user = User.new 'Genadi', 'Samokovarov'
invoice = Invoice.new(user)

puts invoice.first_name
