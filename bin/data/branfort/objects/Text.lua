Text = class(Object, function(o, x, y, t)
  Object.init(o, x, y, 100, 100)
  o.text = t
end)
function Text:draw()
  tb:addText(self.text, self.pos.x, self.pos.y+font:getHeight(self.text))
end
