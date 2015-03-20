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
    error_message = "NoMethodError: undefined method `#{m}` for Enums"
    @enums[m] || (fail NoMethodError, error_message)
  end

  # creates a new enum
  def initialize(enum_name, enum_values)
    @name, @values = enum_name, enum_values
  end

  # check if enum contains value
  def method_missing(m, *_args, &_block)
    return m if @values.include? m
    error = "NoMethodError: undefined method `#{m}` for #{inpect}"
    fail NoMethodError, error
  end
end

Enums.map :direction, to: [:east, :west, :south, :north]
