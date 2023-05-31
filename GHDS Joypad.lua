-- GHDS Inputs script by TANNISTER
-- Made so that you don't have to use autohotkey and antimicrox anymore
--      LessBloatware(tm)

-- GUITAR JOYPAD INPUTS
-- Order of the table : TRIGGER, STRUM UP, STRUM DOWN, AUTOWHAMMY
-- List of possible inputs : up, down, left, right, start, select, A, B, X, Y, L, R
local guitar_joypad = {"left", "up", "down", "right"}

-- Global variables
local joypad_data = {current=joypad.get(), last=joypad.get()}
local stylus_data = {x=0, y=0, pos=-1}
local strum_data = {xs=127, ys=40, xe=127, ye=160}
local whammy_data = {timer=0, forward=false, count=15}
local enabled = false
local debugging = false

-- Utility
local function clicked(k)
	return joypad_data["current"][k] and not joypad_data["last"][k]
end

local function pressed(k)
	return joypad_data["current"][k]
end

local function lerp(a, b, t)
	return a * (1 - t) + b * t
end

-- Stylus control functions
local function guitar_strum()
	if stylus_data.pos == 0 then 
		stylus_data.x = strum_data.xe
		stylus_data.y = strum_data.ye
		stylus_data.pos = 1
	else
		stylus_data.x = strum_data.xs
		stylus_data.y = strum_data.ys
		stylus_data.pos = 0
	end
end

local function guitar_whammy()
	if stylus_data.pos ~= -1 then 
		stylus_data.pos = -1
	else
		local percent = whammy_data.timer / whammy_data.count
		stylus_data.x = lerp(strum_data.xs, strum_data.xe, percent)
		stylus_data.y = lerp(strum_data.ys, strum_data.ye, percent)

		if whammy_data.forward then whammy_data.timer = whammy_data.timer + 1
							   else whammy_data.timer = whammy_data.timer - 1
		end
		
		if whammy_data.timer == 0 
		or whammy_data.timer == whammy_data.count
		then whammy_data.forward = not whammy_data.forward 
		end
	end
end

local function guitar_joypad_loop()
	if clicked(guitar_joypad[1]) then enabled = false end
	
	if clicked(guitar_joypad[2]) then guitar_strum()  end
	if clicked(guitar_joypad[3]) then guitar_strum()  end
	
	if pressed(guitar_joypad[4]) then guitar_whammy() 
	else
		if stylus_data.pos == -1 then
			if whammy_data.timer < whammy_data.count/2 then
				stylus_data.x = strum_data.xs
				stylus_data.y = strum_data.ys
				stylus_data.pos = 0
			else
				stylus_data.x = strum_data.xe
				stylus_data.y = strum_data.ye
				stylus_data.pos = 1
			end
			whammy_data.forward = false
			whammy_data.timer = whammy_data.count
		elseif stylus_data.pos == -2 then
			starpower_data.timer = starpower_data.timer + 1
			if starpower_data.timer == starpower_data.count then
				stylus_data.x = strum_data.xs
				stylus_data.y = strum_data.ys
				stylus_data.pos = 0
				starpower_data.timer = 0
			end
		end
	end
	
	stylus.set({x=stylus_data.x, y=stylus_data.y, touch=true})
end

function script_loop()
	joypad_data["last"]    = copytable(joypad_data["current"])
	joypad_data["current"] = joypad.get(1)
	
	if clicked("debug") then debugging = not debugging end
	
	if not enabled then
		stylus_data.pos = -1
		whammy_data.timer = 0
		if clicked(guitar_joypad[1]) then enabled = true end
	else guitar_joypad_loop()
	end
end

local function script_gui()
	if enabled then 
		gui.text(147,-190, "JOYPAD TOUCHSCREEN")
		if debugging then
			gui.text(1,1, math.floor(stylus_data.x + 0.5) .. " " .. math.floor(stylus_data.y + 0.5) .. " " .. stylus_data.pos)
			gui.line(strum_data.xs, strum_data.ys, strum_data.xe, strum_data.ye, "#AA00AA")
			gui.drawbox(stylus_data.x-1, stylus_data.y-1, stylus_data.x+1, stylus_data.y+1, "#FFFFFF")
			gui.pixel(stylus_data.x, stylus_data.y, "#FF0000")
		end
	else gui.text(153,-190, "MOUSE TOUCHSCREEN")
	end
end

emu.registerbefore(script_loop)
gui.register(script_gui)