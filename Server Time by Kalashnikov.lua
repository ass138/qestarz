require "lib.moonloader"
local huy = require("samp.events")
local piska = 0

local oX = 250
local oY = 430

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	while true do	
		local current_time = os.time() + piska
		local milliseconds = math.floor(os.clock() * 1000) % 1000
		local time_with_ms = os.date("%H:%M:%S", current_time) .. string.format(".%03d", milliseconds)
		sampTextdrawCreate(222, time_with_ms, oX + 32, oY)
		sampTextdrawSetLetterSizeAndColor(222, 0.3, 1.7, 0xFFe1e1e1)
		sampTextdrawSetOutlineColor(222, 0.5, 0xFFFF0000)
		sampTextdrawSetAlign(222, 1)
		sampTextdrawSetStyle(222, 2)
		wait(50) 
	end
end

function huy.onShowDialog(dialogId, style, title, button1, button2, text)
	if string.match(text, "Текущее время") then
		chislo, mesyac, god = string.match(text, "Сегодняшняя дата: 	{2EA42E}(%d+):(%d+):(%d+)")
		chas, minuti, sekundi = string.match(text, "Текущее время: 	{345690}(%d+):(%d+):(%d+)")
		datetime = {year = god, month = mesyac, day = chislo, hour = chas, min = minuti, sec = sekundi}
		piska = tostring(os.time(datetime)) - os.time()
	end
end
