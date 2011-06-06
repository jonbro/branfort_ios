function replace_char2(pos, str, r)
    return str:sub(1,pos-1) .. r .. str:sub(pos+1)
end
function lerp(start, stop, amt)
	return start + (stop-start) * amt;
end

LineBatch = class(function(o)
  o:clear()
end)
function LineBatch:clear()
  self.batch = {}
end
function LineBatch:addLine(x1, y1, x2, y2)
  table.insert(self.batch, {x1=x1, y1=y1, x2=x2, y2=y2})
end
function LineBatch:draw()
  for i, v in pairs(self.batch) do
    line:drawLine(v.x1, v.y1, v.x2, v.y2)
  end
end
lb = LineBatch();

TextBatch = class(LineBatch, function(o)
  LineBatch.init(o)
end)
function TextBatch:addText(output, x, y)
  table.insert(self.batch, {output=output, x=x, y=y})
end
function TextBatch:draw()
  for i, v in pairs(self.batch) do
    lfont:draw(v.output, v.x,v.y)  
  end
end
tb = TextBatch();
