ProgrammingState = class(Group, function(o)
  Group.init(o)
  o.bran = branFort();
  o.program = "+++[>+++<-]>[|-*]"
  
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
  
  o.memorySlider = o:add(MemorySlider(0,0))
  o.memorySlider._options = o.bran._memory
  
  o.menu = bludImage();
  o.menu:load(blud.bundle_root .. "/branfort/assets/menu.png")
  -- add the buttons on the menu
  o.run = o:add(Button(0, 256, 64, 64))
  function o.run:onPress()
    -- wipe the memory and run the program
    o.bran.waitingForNextSync = false
    o.bran:clearMemory()
    o.output = o.output .. o.bran:runProgram(o.program)
    o.memorySlider:setValue(o.bran._memPosition)
    o.programSlider:setValue(o.bran._progPosition)
  end

  o.step = o:add(Button(64, 256, 64, 64))
  function o.step:onPress()
    -- running this assumes that the program and memory are clear and ready to go
    o.output = o.output .. o.bran:runNextCommand(o.program)
    -- we should also update the position of the program slider and the memory slider to the program state
    o.memorySlider:setValue(o.bran._memPosition)
    o.programSlider:setValue(o.bran._progPosition)
  end

  o.reset = o:add(Button(128, 256, 64, 64))
  function o.reset:onPress()
    o.bran:reset()
    o.memorySlider:setValue(o.bran._memPosition)
    o.programSlider:setValue(o.bran._progPosition)
  end

  o.copy = o:add(Button(192, 256, 64, 64))
  function o.copy:onPress()
    pasteboard:set(o.program);
  end
  o.paste = o:add(Button(256, 256, 64, 64))
  function o.paste:onPress()
    if pasteboard:get() ~= nil then
      o.program = pasteboard:get();
      o.programSlider._options = o.program
    end
  end
  o.insert = o:add(Button(320, 256, 64, 64))
  function o.insert:onPress()
    current = o.programSlider:getValue()
    o.program = replace_char2(o.programSlider:getPosition(), o.program, " "..current)
    o.programSlider._options = o.program
  end

  o.clear = o:add(Button(416, 256, 64, 64))
  function o.clear:onPress()
    o.bran:reset()
    o.memorySlider:setValue(o.bran._memPosition)
    o.programSlider:setValue(o.bran._progPosition)
    o.program = ""
    o.programSlider._options = o.program
  end

  o.output = ""
end)
function ProgrammingState:setProgram(program)
   self.program = program
   self.programSlider._options = self.program
end
function ProgrammingState:sync()
  Group.sync(self)
  if self.bran.waitingForNextSync then
    self.bran.waitingForNextSync = false
    self.bran:runProgram()
    self.memorySlider:setValue(self.bran._memPosition)
    self.programSlider:setValue(self.bran._progPosition)
  end
end
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
  -- copy the memory from the program into the memory slider
  self.memorySlider._options = self.bran._memory
end
function ProgrammingState:draw()
  -- dont call the parent here
  self.menu:draw(0,4*64);
  bb:draw();
  bg:setColor(0,0,0,255)
    
  -- draw the state of the output
  bg:setColor(255, 255, 255, 255);
  lfont:draw(self.output, 10, 192+lfont:getHeight(self.output)+22);
  
  self.programmingSlider:draw()
  self.programSlider:draw()
  self.memorySlider:draw()
end