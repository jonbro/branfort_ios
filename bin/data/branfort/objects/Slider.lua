Slider = class(Object, function(o, x, y)
  o._min = 0
  o._max = 10
  o._width = bg:getWidth()
  o._height = 63
  o._hasTouch = false
  o._currentTouch = 0
  o._options = " <>+-[].,"
  o._value = 0
  Object.init(o, x, y, o._width, o._height)
end)

function Slider:draw()
  x_start = self._width/2-30
  for i=1,#self._options do
    bg:setColor(255, 255, 255, 255)
    lfont:draw(self._options:sub(i, i), self._value + self.pos.x+60*(i-1) + x_start+20, self.pos.y+30)
  end
end

function Slider:update()
  x_start = self._width/2-30
  for i=1,#self._options do
    bb:setColor(0,0,0,150)
    bb:addRect(self._value + self.pos.x+60*(i-1) + x_start + 1, self.pos.y+self._height/2-29, 0, 58, self._height);
  end
  -- draw the square for the selected one
  bb:setColor(0,0,0,255)
  bb:addRect(self.pos.x+self._width/2-30, self.pos.y+self._height/2-30, 0, 58, self._height);
  -- lerp the value to the nearest whole cell
  if self._hasTouch == false then
    if self._min and -1*self._value < self._min then
      self._value = lerp(self._value, self._min, .5)
    else
      local rem = self._value % 60
      if rem < 30 then
        t = math.floor(self._value/60)*60
        self._value = lerp(self._value, t, .5)
      else
        t = math.ceil(self._value/60)*60
        self._value = lerp(self._value, t, .5)
      end
    end
  end
end
function Slider:getPosition()
  if self._min and -1*self._value < self._min then
    return -1*math.floor(self._min/60)+1
  else
    local rem = self._value % 60
    if rem < 30 then
      return -1*math.floor(self._value/60)+1
    else
      return -1*math.ceil(self._value/60)+1
    end 
  end 
end
function Slider:getValue()
  return self._options:sub(self:getPosition(), self:getPosition())
end
function Slider:touchDown(x, y, id)
  if Rectangle.doesPointTouch(self, Vec2(x, y)) then
    self._hasTouch = true
    self._currentTouch = id
    self._lastPos = Vec2(x, y)
  end
end
function Slider:touchMoved(x, y, id)
  if(self._hasTouch and self._currentTouch == id) then
    self._value = self._value + x - self._lastPos.x
    self._lastPos = Vec2(x, y)
  end
end
function Slider:touchUp(x, y, id)
  if self._currentTouch == id then
    self._hasTouch = false
  end
end