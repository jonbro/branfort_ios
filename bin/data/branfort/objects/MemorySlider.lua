MemorySlider = class(Slider, function(o, x, y, memory)
  Slider.init(o, x, y)
  o.memory = memory
end)
function MemorySlider:drawCell(x,y,value)
  Slider.drawCell(self, x, y, value)
  font:draw(string.byte(value), x+5, y-self._height/2+45)
end