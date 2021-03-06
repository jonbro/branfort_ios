-- group
-- getNearest(vec2) -- returns the member closest to point
-- remove(Object)   -- marks the object for removal from its member list and returns it
-- add(Object)      -- adds the object to the list

Group = class(function(o)
  o.members = {}
  o.alive = true
  o.exists = true
end)
function Group:getNearest(o)
  assert(o.pos, "The object being passed to nearest does not apper to have a position")
  local low; local nearest;
  if self.members then
    for i, v in pairs(self.members) do
      if v.alive then
        dist = v.pos:distance(o.pos)
        if low == nil or dist < low then low = dist; nearest = v end
      end
    end
    return nearest
  end
end
function Group:add(o)
  assert(o, "nil group member added")
  table.insert(self.members, o)
  return o
end
function Group:remove(o)
  for i=table.maxn(self.members),1,-1 do
    if self.members[i] == o then table.remove(self.members, i); end
  end
end
function Group:callAll(functionName)
  if self.members then
    for i, v in pairs(self.members) do if v[functionName] then v[functionName](v) end end
  end
end
function Group:countLiving()
  count = 0
  for i, v in pairs(self.members) do if v.alive then count = count+1 end end
  return count
end
function Group:draw()
  if self.members then
    for i, v in ipairs(self.members) do
      if v.exists and v.draw then v:draw() end
    end
  end
end
function Group:update()
  if self.members then
    for i, v in pairs(self.members) do
      if v.exists and v.update then v:update() end
      -- if v.update then v:update() end
    end
  end
end
-- check to see if this object overlaps with another one
function Group:overlap(other, ...)
  notifyCallback = arg[1]
  r_val = false
  if self.members then
    for i, v in pairs(self.members) do
      if other.members then
        for j, w in pairs(other.members) do
          if v.alive and v:overlap(w, notifyCallback) then r_val = true end
        end
      else
        if v.alive and v:overlap(other, notifyCallback) then r_val = true end
      end
    end
  end
  return r_val
end
function Group:touchDown(x, y, id)
  if self.members then
    for i, v in pairs(self.members) do
      if v.exists and v.touchDown then v:touchDown(x,y,id) end
    end
  end
end
function Group:touchMoved(x, y, id)
  if self.members then
    for i, v in pairs(self.members) do
      if v.exists and v.touchMoved then v:touchMoved(x,y,id) end
    end
  end
end
function Group:touchUp(x, y, id)
  if self.members then
    for i, v in pairs(self.members) do
      if v.exists and v.touchUp then v:touchUp(x,y,id) end
    end
  end
end
function Group:sync()
  self:callAll("sync")
end