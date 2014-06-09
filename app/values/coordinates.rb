class Coordinates
  def initialize(x,y)
    @x, @y = x, y
  end

  def distance(coordinates)
    dx = coordinates.x - x
    dy = coordinates.y - y
    Math.hypot(dx, dy)
  end
end
