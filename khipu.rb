class Strand
  include Enumerable

  attr_accessor :knots

  def initialize
    @knots = []
    @group = false
    @colour = nil
    @direction = false
  end

  def each(&block) = knots.each(&block)
  def <<(val) = knots << val
  def length = count
  def insert(i, x) = knots[i] = x
  def append(item) = knots.append(item)
  def concat(strand) = strand.each { |item| append(item) }
  def clear = knots.clear
  def copy = Marshal.load(Marshal.dump(self))

  # TODO
  def decrypt(key) = nil
  def encrypt = nil

  def to_s
    "#{group ? 1 : ''}|#{colour}|#{direction ? 1 : ''}|#{knots.join}"
  end

  private

  attr_reader   :group,
                :colour,
                :direction
end

class Cord < Strand
  def colour=(rgba_array)
    @colour = Colour.new(*rgba_array)
  end

  def direction=(bool)
    @direction = bool
  end

  def +(cord)
    new_value = to_i + cord.to_i
    @knots = new_value.to_s.chars.map(&:to_i)
    self
  end

  def to_i = knots.join.to_i

  class Colour
    def initialize(r,g,b,a)
      @colour = [r,g,b,a]
    end

    def red = @colour[0]
    def green = @colour[1]
    def blue = @colour[2]
    def alpha = @colour[3]

    def to_s = "(#{red}, #{green}, #{blue}, #{alpha})"
  end
end

class Group < Strand
  attr_reader :top_cord

  def initialize(has_top = true)
    super()
    @group = true
    @has_top = has_top
    @top_cord = Cord.new if has_top?
  end

  def has_top? = !!@has_top

  def add_to_top_cord(cord)
    if has_top?
      @top_cord += cord
    else
      @top_cord = Cord.new
      @has_top = true
      @top_cord += cord
    end
  end

  def append(cord, top_cord = true)
    @knots << cord

    add_to_top_cord(cord) if top_cord
  end

  def to_s = ["1|||", @top_cord, knots].join("\n  ")

  def to_i
    return top_cord.to_i if has_top?

    knots.map(&:to_i).sum
  end

  def clear
    knots.clear
    @top_cord = Cord.new
    self
  end

  def concat(cords, update_top_cord = true)
    cords.each { |cord|
      add_to_top_cord(cord) if update_top_cord && has_top?
      knots << cord
    }
  end

  def insert(i, cord, top_cord = true)
    knots[i] = cord

    add_to_top_cord(cord) if top_cord
  end
end

class Khipu < Strand
  def to_s = knots.join("\n")

  # TODO
  def deserialize(path)
    File.readlines(path).each do |line|
      parts = line.split
      case parts
      in ["1", *]
        knots << Group.new
      in ["", String, *, String]
      end
    end
  end

  def new_cord = Cord.new
  def new_group = Group.new
  def serialize(path, indent=4, spaces=0) = nil
end
