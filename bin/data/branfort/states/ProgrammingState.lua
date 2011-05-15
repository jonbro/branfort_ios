ProgrammingState = class(Group, function(o)
  Group.init(o)
  o.bran = branFort();
  o.program = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."
  
  o.programSlider = o:add(Slider(0, 64))
  o.programSlider._options = o.program
  
  o.programmingSlider = o:add(Slider(0, 128));
  function o.programmingSlider:touchUp(x, y, id)
    if id == self._currentTouch and self._hasTouch then
      o.program = replace_char2(o.programSlider:getPosition(), o.program, o.programmingSlider:getValue())
      o.programSlider._options = o.program
    end
    Slider.touchUp(self, x, y, id)
  end
  
  o.menu = bludImage();
  o.menu:load(blud.bundle_root .. "/branfort/assets/menu.png")
  -- add the buttons on the menu
  o.run = o:add(Button(0, 256, 64, 64))
  function o.run:onPress()
    -- wipe the memory and run the program
    o.bran:clearMemory()
    o.output = o.output .. o.bran:runProgram(o.program)
  end
  o.output = "Hello World"
end)
function ProgrammingState:update()
  Group.update(self)
  -- replace linebreaks in output with spaces
  self.output = self.output:gsub("\n", " ")
  -- make sure that the output isn't flowing off the screen
  -- delete one character per loop :)
  if(lfont:getWidth(self.output) > bg:getWidth() - 20) then
    -- delete the first character off of the string
    self.output = self.output:sub(2)
  end
end
function ProgrammingState:draw()
  -- dont call the parent here
  self.menu:draw(0,4*64);
  bb:draw();
  bg:setColor(0,0,0,255)
  
  -- display the state of the memory
  for i=1,20 do
    if self.bran._memory:sub(i, i) then
      font:draw(string.byte(self.bran._memory:sub(i, i)), i*18, 15)
    end
  end
  
  -- draw the state of the output
  bg:setColor(255, 255, 255, 255);
  lfont:draw(self.output, 10, 192+lfont:getHeight(self.output)+22);
  
  self.programmingSlider:draw()
  self.programSlider:draw()
end