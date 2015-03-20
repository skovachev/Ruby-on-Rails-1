class Enums
  # make it a valid Enumerable object
  include Enumerable

  def each(&block)
    @values.each(&block)
  end

  # store all created enums
  @enums = {}

  # create a new enum
  def self.map(enum_name, to: [])
    @enums[enum_name] = Enums.new enum_name, to
  end

  # try to get an enum using the Enums class
  def self.method_missing(m, *_args, &_block)
    if @enums.key? m
      @enums[m]
    else
      fail NoMethodError, "NoMethodError: undefined method `#{m}` for Enums"
    end
  end

  # creates a new enum
  def initialize(enum_name, enum_values)
    @name = enum_name
    @values = enum_values
  end

  # check if enum contains value
  def method_missing(m, *_args, &_block)
    if @values.include? m
      m
    else
      error = "NoMethodError: undefined method `#{m}` for #{inpect}"
      fail NoMethodError, error
    end
  end
end

Enums.map :direction, to: [:east, :west, :south, :north]
