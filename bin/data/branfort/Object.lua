Object = class(Rectangle, function(o, x, y, width, height)
  Rectangle.init(o, x, y, width, height)
  o.alive = true
  o.exists = true
end)

function Object:draw()
  Rectangle.draw(self)
end
function Object:overlap(other, ...)
  notifyCallback = arg[1]
  if self.alive and Rectangle.doesRectangleTouch(self, other) then
    if notifyCallback then notifyCallback(self, other) end
    return true
  end
  return false
end
function Object:kill()
  self.alive = false
  self.exists = false
end