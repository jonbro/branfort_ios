Button = class(Object, function(o, x, y, w, h)
  Object.init(o, x, y, w, h)
  o.onPress = function() end
end)
function Button:draw()
end
function Button:touchDown(x, y, id)
  if Rectangle.doesPointTouch(self, Vec2(x, y)) then
    self.onPress()
  end
end