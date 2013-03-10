class Percent < Numeric
  attr_reader :value

  def initialize(object)
    @value = object
  end

  def f_percent(options={})
    options.reverse_merge! decimal_format: ',', symbol: true

    val = sprintf("%0.03f", @value).gsub('.', options[:decimal_format])
    val = case
      when val[-3,3] == '000' then val[0..-5]
      when val[-1,1] == '0' then val[0..-2]
      else val
    end

    val += '%' if options[:symbol]

    return val
  end

  def mongoize
    @value.to_s.rjust(10, '0')
  end

  def percent
    @value.to_f
  end

  class << self
    def demongoize(object)
      self.new(object.to_f / 1000)
    end

    def evolve(object)
      object.mongoize
    end

    def mongoize(object)
      case object
        when Percent then object.mongoize
        else Percent.new_from_string(object).mongoize
      end
    end

    def new_from_mongo(object)
      Numeric(object.to_f / 1000)
    end

    def new_from_string(object)
      begin
        val = (object.to_s.gsub(',', '.').gsub('%', '').to_f * 1000).to_i
      rescue
        val = 0
      end

      self.new val
    end
  end
end

class Numeric
  def percent
    Percent.new (self * 1000).to_i
  end
end
