dofile(blud.bundle_root .. "/branfort/imports.lua")

bb = bludShapeBatch();
bg = bludGraphics();

font = bludFont();
font:load(blud.bundle_root .. "/univers.ttf", 10)

lfont = bludFont();
lfont:load(blud.bundle_root .. "/univers.ttf", 18)

gridSize = 40;

mainState = ProgrammingState();

function blud.update(t)
  bb:clear();
  mainState:update()
end
function blud.draw()
  mainState:draw()
end

function blud.touch.down(x, y, id)
  mainState:touchDown(x, y, id)
end
function blud.touch.moved(x, y, id)
  mainState:touchMoved(x, y, id)
end
function blud.touch.up(x, y, id)
  mainState:touchUp(x, y, id)
end