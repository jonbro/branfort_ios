dofile(blud.bundle_root .. "/branfort/imports.lua")

bb = bludShapeBatch();
bg = bludGraphics();

font = bludFont();
font:load(blud.bundle_root .. "/univers.ttf", 10)

lfont = bludFont();
lfont:load(blud.bundle_root .. "/univers.ttf", 18)

gridSize = 40;
pasteboard = bludClipboard();
mainState = ProgrammingState();
if pasteboard:getDefaults()~= nil then
  -- print("the defaults = " .. pasteboard:getDefaults())
  mainState:setProgram(pasteboard:getDefaults())
end
function blud.update(t)
  bb:clear();
  mainState:update()
end
function blud.draw()
  mainState:draw()
end
function blud.exit()
  pasteboard:setDefaults(mainState.program)  
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

-- import all of the sounds
sb = SoundBank()
sounds = {}
for i=1,16 do
  sounds[i] = sb:addSound(blud.bundle_root .. "/branfort/assets/oneloginacc_gl_pk1_"..i.."_.wav")
  sounds[i]:setLoopType(1)
end

triggerCounter = 0
triggerCallback = function()
  triggerCounter = triggerCounter +1
  -- bring an enemy onto the screen every measure
  if triggerCounter % 8 == 0 then
    mainState:sync()
  end
end
bpm = 92
rate = (44100 * 60 / bpm) / 16;     -- takes a rate in bpm
ms_between_syncs = (rate/44100) * 1000.0
secs_between_syncs = ms_between_syncs/1000.0*8.0
last_sync_time = 0
current_time = 0
trigger = bludAudioSync(rate);
trigger:setCallback(triggerCallback, 1);