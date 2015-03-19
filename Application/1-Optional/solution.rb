class Optional

    def value
        value = @value
        @value = nil
        value
    end

    def initialize(obj)
        @obj = obj
        @value = obj
    end

    def determine_target
        target = @obj

        if !@value.nil?
            target = @value
        end

        target
    end

    def method_missing(m, *args, &block)  
        target = self.determine_target

        @value = target.method(m).call

        self

    rescue NameError
        @value = nil
        self
    end

    def to_s
        target = self.determine_target
        @value = target.to_s
        self
    end

end

User = Struct.new(:account)

user = User.new nil
o = Optional.new user
puts o.account.value

puts Optional.new(nil).no_such_method.value

nr = Optional.new 42
puts nr.succ.succ.succ.succ.succ.to_s.value;