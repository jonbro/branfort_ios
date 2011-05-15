branFort = class(function(o)
  -- init memory
  o:clearMemory()
  o._memPosition = 1
  o._progPosition = 1
  o._program = ""
  o._output = ""
end)
function branFort:clearMemory()
  self._memory = ""
  for i=1,3000 do
    self._memory = self._memory .. string.char(0)
  end
end
function branFort:runProgram(program)
  self._program = program
  self._progPosition = 1
  self._memPosition = 1
  -- clear the output
  self._output = ""
  while(self._progPosition < self._program:len()+1) do
    self:runCommand(self._program:sub(self._progPosition, self._progPosition))
  end
  return self._output
end
function branFort:runNextCommand()
  self:runCommand(self._program:sub(self._progPosition, self._progPosition))
  print(self._progPosition, self._program:sub(self._progPosition, self._progPosition), self._memPosition, string.byte(self._memory, self._memPosition))
end
function branFort:moveToNextCommand()
  self._progPosition = self._progPosition+1
  if self._progPosition >= self._program:len()-1 then
    return nil
  end
  return self._program:sub(self._progPosition, self._progPosition)
end
function branFort:moveToPrevCommand()
  self._progPosition = self._progPosition-1
  if self._progPosition < 1 then
    return nil
  end
  return self._program:sub(self._progPosition, self._progPosition)
end
function branFort:runCommand(command)
  if command == ">" then
    self._memPosition = self._memPosition+1
    self:moveToNextCommand()
  elseif command == "<" then
    self._memPosition = self._memPosition-1
    self:moveToNextCommand()
  elseif command == "+" then
    new_char = string.char(math.min(string.byte(self._memory, self._memPosition)+1, 255));
    self._memory = replace_char2(self._memPosition, self._memory, new_char)
    self:moveToNextCommand()
  elseif command == "-" then
    -- print("mnus", string.byte(self._memory, self._memPosition)-1)
    new_char = string.char(math.max(string.byte(self._memory, self._memPosition)-1,0));
    self._memory = replace_char2(self._memPosition, self._memory, new_char)
    self:moveToNextCommand()
    -- print("mempos", self._memPosition, string.byte(self._memory, self._memPosition))
  elseif command == "[" then
    val = string.byte(self._memory, self._memPosition)
    -- self._memPosition = self._memPosition-1
    if val == 0 then
      count = 1;
      while 1 == 1 do
        c = self:moveToNextCommand()
        if c == nil then break end
        if c == "[" then count = count+1 end
        if c == "]" then count = count-1 end
        -- print("the count [", count, c)
        if count == 0 then
          self:moveToNextCommand();
          break;
        end
      end
    else
      self:moveToNextCommand();
    end
  elseif command == "]" then
    val = string.byte(self._memory, self._memPosition)
    -- self._memPosition = self._memPosition-1
    if val > 0 then
      count = 1;
      while 1 == 1 do
        c = self:moveToPrevCommand()
        if c == nil then break end
        if c == "[" then count = count-1 end
        if c == "]" then count = count+1 end
        -- print("the count ]", count, c)
        if count == 0 then
          break;
        end
      end
    else
      self:moveToNextCommand();
    end
  elseif command == "." then
    -- append the current memory position to the output
    self._output = self._output .. string.char(string.byte(self._memory, self._memPosition))
    self:moveToNextCommand();
  else
    self:moveToNextCommand();
  end
end