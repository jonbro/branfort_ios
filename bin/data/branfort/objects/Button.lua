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

TextButton = class(Button, function(o, x, y, w, h, t)
  Button.init(o, x, y, w, h)
  o.text = t
end)
function TextButton:draw()
  bb:setColor(255, 255, 255);
  bb:addRect(self.pos.x, self.pos.y, 0, self.w, self.h)
  bg:setColor(0, 0, 0);  
  tb:addText(self.text, self.pos.x+10, self.pos.y+font:getHeight(self.text)+10)
end