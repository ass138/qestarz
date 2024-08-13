script_name('������ HELPER')
script_version("0.2.5")


--������ ����������--
require 'lib.moonloader'
 imgui = require 'mimgui' -- ���������� ���������� ������
 encoding = require 'encoding' -- ���������� ���������� ��� ������ � ������� �����������
encoding.default = 'CP1251' -- ����� ��������� �� ���������
 u8 = encoding.UTF8 -- ��� �������� ��� ������ �������� ��������/����� �� ���������
 new = imgui.new -- ������ �������� ��������� ��� ��������
 window = new.bool() -- ������ ������ ��� �������� ����
require 'lib.moonloader'
 imgui = require 'mimgui'
 ffi = require 'ffi'
 encoding = require 'encoding'
encoding.default = 'CP1251'
 u8 = encoding.UTF8
 new, str = imgui.new, ffi.string
 renderWindow = new.bool()
 sampev = require 'samp.events'
 f = require 'moonloader'.font_flag
 font = renderCreateFont('Arial', 15, f.BOLD + f.SHADOW)
 clean = false
 counter = 0
 monet_check, monet			= pcall(require, 'MoonMonet')
 ev = require 'samp.events'
 lavki = {}
 marketShop = {}
 keys = require "vkeys"
 ffi = require 'ffi'
 ti = require 'tabler_icons'
 new, str = imgui.new, ffi.string
 effil = require("effil")
 encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8
 imgui_check, imgui			= pcall(require, 'mimgui')
 samp_check, samp				= pcall(require, 'samp.events')
 effil_check, effil			= pcall(require, 'effil')
 requests_check, requests		= pcall(require, 'requests')
monet_check, monet			= pcall(require, 'MoonMonet')
dlstatus						= require('moonloader').download_status
weapons						= require('game.weapons')
ffi							= require('ffi')
encoding						= require('encoding')
encoding.default					= 'CP1251'
u8 = encoding.UTF8



--������ ����������--
function table.assign(target, def, deep)
    for k, v in pairs(def) do
        if target[k] == nil then
            if type(v) == 'table' then
                target[k] = {}
                table.assign(target[k], v)
            else  
                target[k] = v
            end
        elseif deep and type(v) == 'table' and type(target[k]) == 'table' then 
            table.assign(target[k], v, deep)
        end
    end 
    return target
end

function json(path)
	createDirectory(getWorkingDirectory() .. '/config')
	local path = getWorkingDirectory() .. '/config/' .. path
	local class = {}

	function class:save(array)
		if array and type(array) == 'table' and encodeJson(array) then
			local file = io.open(path, 'w')
			file:write(encodeJson(array))
			file:close()
		else
			sms('������ ��� ���������� �����!')
		end
	end

	function class:load(array)
		local result = {}
		local file = io.open(path)
		if file then
			result = decodeJson(file:read()) or {}
		end

		return table.assign(result, array, true)
	end

	return class
end

--������ CFG--
local inicfg = require 'inicfg'
local mainIni = inicfg.load({
	main =
    {
	    autoeat = false,
		autoeatmin = 0, -- �������� ������
		ComboTest = 0,
        autoclean = false,
		chat_id = '',
		token = '',
		diolog = false,
		cmd = false,
		info = false,
		standart = false,
        platina = false,
        mask = false,
        donate = false,
		tainik = false,
		vice = false,
        clean = false,
        settingslavka = false,
        namelavkas = '',
        running = false,
        show = false,
        speedrunning = false,
        speedrunningkey = '0x14',
        renderlavokx = 500,
        renderlavoky = 500,
        chestposx = 500,
        chestposy = 500,
        delayedtimerposx = 500,
        delayedtimerposy = 500,
        infonline = false,
        infrender = false,
        infradius = false,
        infclean = false,
        infautoclean = false,
        infautolavka = false,
        powfish = 70,
        stroki = 5,
        checkboxkodbank = false,
        kodbank = '',
        checkboxkodsklad = false,
        kodsklad = '',
        skipdiolog = false,
        nickrecons = '',
        serverrecon = '',
        
    }}, 'MiniHelper-CR.ini')
--������ CFG--

local jsonLog = json('Log.json'):load({})
local jsonConfig = json('Config.json'):load({
	['script'] = {
		scriptColor = {1.0, 1.0, 1.0},
		lastNewsCheck = 0
	},
	['notifications'] = {
		inputToken = '',
		inputGroup = '',
		resale = false,
		action = false,
		balance = false,
		statistics = false,
		death = false,
		moreItems = false,
		message = false,
		damage = false,
		catchingShop = false,
		status32 = false,
		status33 = false,
		status34 = false,
		status35 = false,
		status37 = false
	},
	['market'] = {
		fontSize = 1.0,
		fontAlpha = 1.00,
		marketAlpha = 1.00,
		marketSize = {x = 700, y = 260},
		marketBool = false,
		marketColor = {text = {1.0, 1.0, 1.0}, window = {0.2, 0.2, 0.2}},
		marketPos = {x = -1, y = -1}
	},
    ['informer'] = {
		fontSizea = 1.0,
        fontAlphaa = 1.00,
		marketAlphaa = 1.00,
		marketSizea = {x = 700, y = 260},
		marketColora = {text = {1.0, 1.0, 1.0}, window = {0.0, 0.0, 0.0}},
		marketPosa = {x = -1, y = -1}
	}
})

--������ 1 ��������--
local SliderOne = new.int(mainIni.main.autoeatmin)
local ComboTest = new.int((mainIni.main.ComboTest)) -- ������ ������ ��� �����
local lavka = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local radiuslavki = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local settingslavka = new.bool(mainIni.main.settingslavka) -- ����� ������ ��� ��������, ������� ���������� true/false
local namelavkas = new.char[256](u8(mainIni.main.namelavkas))
local clean = new.bool(mainIni.main.clean) -- ����� ������ ��� ��������, ������� ���������� true/false
local autoclean = new.bool(mainIni.main.autoclean) -- ����� ����� ��� ��������, ������� ���������� true/false
local autoeat = new.bool(mainIni.main.autoeat) -- ����� ������ ��� ��������, ������� ���������� true/false
local item_list = {u8'�������', u8'����� � �����'} -- ������ ������
local ImItems = imgui.new['const char*'][#item_list](item_list)
local pcoff = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local SliderTwo = new.int(0)
local SliderFri = new.int(0)
--������ 1 ��������--





---Chests---
local checkbox_standart = new.bool(mainIni.main.standart) -- ������ �������
local checkbox_donate = new.bool(mainIni.main.donate) -- ������ ���������� �������
local checkbox_tainik = new.bool(mainIni.main.tainik) -- ������ ������� (�����)
local checkbox_mask = new.bool(mainIni.main.mask) -- ������ ����� �����
local checkbox_platina = new.bool(mainIni.main.platina) -- ������ ��� �������
local checkbox_vice = new.bool(mainIni.main.vice) -- ������ Vice City
local textdraw = {
    [1] = {_, _, 1000},
    [2] = {_, _, 1000},
    [3] = {_, _, 1000},
    [4] = {_, _, 1000},
	[5] = {_, _, 1000},
	[6] = {_, _, 1000},
} 
local Chest = new.bool()
local sw, sh = getScreenResolution() 
local active_standart, active_mask, active_platina, active_donate, active_tainik, vice = false, false, false, false, false, false

local workbotton = new.bool()
local timertrue = false
---Chests---

local window = imgui.new.bool()
local showdebug = imgui.new.bool(false)
local tab = 2 -- � ���� ���������� ����� �������� ����� �������� �������

--local timechestto = new.char[256]() -- ������ ����� ��� ������
local timechestto = new.int(10) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local delayedtimer = new.bool() -- ���� space
---Auto---
local autokey1 = new.bool() -- ���� space
local timekey1 = new.int(5) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local buttonkey1 = new.char[256]() -- ������ ����� ��� ������

local autokey2 = new.bool() -- ���� space
local timekey2 = new.int(5) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local buttonkey2 = new.char[256]() -- ������ ����� ��� ������
local timekey3 = new.int(5) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local buttonkey3 = new.char[256]() -- ������ ����� ��� ������



local hotkey = require 'mimgui_hotkeys'
local running = new.bool(mainIni.main.running)
local speedrunning = new.bool(mainIni.main.speedrunning)
local speedrunningkey = new.char[256](u8(mainIni.main.speedrunningkey))
local lenwh = new.bool()
local xlopokwh = new.bool()
local shaxta = new.bool()
local autoalt = new.bool()
powfish = new.int(mainIni.main.powfish) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������

checkboxkodbank = new.bool(mainIni.main.checkboxkodbank) -- ����� ����� ��� ��������, ������� ���������� true/false
checkboxkodsklad = new.bool(mainIni.main.checkboxkodsklad) -- ����� ����� ��� ��������, ������� ���������� true/false
kodbank = new.char[256](u8(mainIni.main.kodbank)) -- ������ ����� ��� ������
kodsklad = new.char[256](u8(mainIni.main.kodsklad)) -- ������ ����� ��� ������
---Auto---

---4---

---4---

---Telegram---
local cmd = new.bool(mainIni.main.cmd)
local diolog = new.bool(mainIni.main.diolog) -- ����� ������ ��� ��������, ������� ���������� true/false
local chat_id = new.char[256](u8(mainIni.main.chat_id)) -- ������ ������ ��� ������
local token = new.char[256](u8(mainIni.main.token)) -- ������ ������ ��� ������
---Telegram---

local skipdiolog = new.bool(mainIni.main.skipdiolog)

--color--

Memory = require 'memory'




        local fontSize = imgui.new.float(jsonConfig['market'].fontSize)
        local fontAlpha = imgui.new.float(jsonConfig['market'].fontAlpha)
        local marketAlpha = imgui.new.float(jsonConfig['market'].marketAlpha)
        local marketSize = {x = imgui.new.int(jsonConfig['market'].marketSize.x), y = imgui.new.int(jsonConfig['market'].marketSize.y)}
        local marketBool = {now = imgui.new.bool(), always = imgui.new.bool(jsonConfig['market'].marketBool)}
        local marketColor = {text = imgui.new.float[3](jsonConfig['market'].marketColor.text), window = imgui.new.float[3](jsonConfig['market'].marketColor.window)}
        local marketPos = imgui.ImVec2(jsonConfig['market'].marketPos.x, jsonConfig['market'].marketPos.y)
        local marketShop = {}
        local stroki = new.int(mainIni.main.stroki) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
        local scriptColor = imgui.new.float[3](jsonConfig['script'].scriptColor)



        local infonline = new.bool(mainIni.main.infonline)
        local infrender = new.bool(mainIni.main.infrender)
        local infradius = new.bool(mainIni.main.infradius)
        local infclean = new.bool(mainIni.main.infclean)
        local infautoclean = new.bool(mainIni.main.infautoclean)
        local infautolavka = new.bool(mainIni.main.infautolavka)

        local show = imgui.new.bool(mainIni.main.show)
        local fontSizea = imgui.new.float(jsonConfig['informer'].fontSizea)
        local fontAlphaa = imgui.new.float(jsonConfig['informer'].fontAlphaa)
        local marketAlphaa = imgui.new.float(jsonConfig['informer'].marketAlphaa)
        local marketColora = {text = imgui.new.float[3](jsonConfig['informer'].marketColora.text), window = imgui.new.float[3](jsonConfig['informer'].marketColora.window)}
        local marketSizea = {x = imgui.new.int(jsonConfig['informer'].marketSizea.x), y = imgui.new.int(jsonConfig['informer'].marketSizea.y)}
        local marketPosa = imgui.ImVec2(jsonConfig['informer'].marketPosa.x, jsonConfig['informer'].marketPosa.y)

       

 
--color--

imgui.OnFrame(function() return window[0] end, function(player)
    local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sw/2.5,sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5,0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(370, 320), imgui.Cond.Always)
    imgui.Begin(u8'������ Helper v'..thisScript().version, window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    imgui.SetCursorPosY(1) -- ��������� ������ ��������� ������� �� ���������
    if imgui.Button('DEBUG') then
        showdebug[0] = true
        window[0] = false
    end
    local diamond = ti 'diamond'
    local package = ti 'package'
    local store = ti 'building-store'
    local code = ti 'code'
    local info = ti 'info-circle'
    local telegram = ti 'brand-telegram'
    local refresh = ti 'refresh-alert'

    if imgui.Button(diamond .. '##0001', imgui.ImVec2(80,36.8)) then
        tab = 1
        
    end
    if imgui.Button(package .. '##0001', imgui.ImVec2(80,36.8)) then
        tab = 2
    end
    if imgui.Button(store .. '##0001', imgui.ImVec2(80,36.8)) then
        tab = 3
    end
    if imgui.Button(code .. '##0001', imgui.ImVec2(80,36.8)) then
        tab = 4
    end
    if imgui.Button(info .. '##0001', imgui.ImVec2(80,36.8)) then
        tab = 5
    end
    if imgui.Button(telegram .. '##0001', imgui.ImVec2(80,36.8)) then
        tab = 6
    end

    if imgui.Button(refresh .. '##0001', imgui.ImVec2(80,36.8)) then  
        sampAddChatMessage('������ ���������������', 0xFF0000)
	    thisScript():reload()
    end



    imgui.SetCursorPos(imgui.ImVec2(95, 28)) -- [��� ������] ������������� ������� ��� ������ ����
    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then -- [��� ������] ������ ����� � ������� �������� ����������

        
        --- 1 �������� ����� ---
		if tab == 1 then
     
        if imgui.Checkbox(u8'������ �����', lavka) then
        end
		imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 1"))
        imgui.SameLine()
        imgui.SetCursorPosX(195)
        if imgui.Button(u8'�������##1') then
            sms('������� {mc}������{-1}, ����� ��������� �������.')
            renderlavok = true
        end
       
        imgui.Checkbox(u8'������ ����� �������', radiuslavki)
        imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 2"))
		imgui.Checkbox(u8'�������� ������� � ��', clean)
        imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 3"))
        if imgui.Checkbox(u8'����-��������', autoclean) then
            mainIni.main.autoclean = autoclean[0] 
		    inicfg.save(mainIni, "MiniHelper-CR")
        end
        if imgui.Checkbox(u8'����-�����', settingslavka) then
            
            mainIni.main.settingslavka = settingslavka[0] 
		    inicfg.save(mainIni, "MiniHelper-CR")
        end
        if imgui.InputText(u8"name-lavka", namelavkas, 256) then 
            mainIni.main.namelavkas = u8:decode(str(namelavkas))
            inicfg.save(mainIni, "MiniHelper-CR")
            end

		imgui.Separator()	
		if imgui.Checkbox(u8'����-���', autoeat) then
		mainIni.main.autoeat = autoeat[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		imgui.SameLine()
        imgui.TextQuestion(u8("������ ����� ��� �����"))
		imgui.PushItemWidth(190)
		if imgui.SliderInt(u8'������.', SliderOne, 1, 60) then -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
		mainIni.main.autoeatmin = SliderOne[0]
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		imgui.PopItemWidth()
		if imgui.Combo(u8'##',ComboTest,ImItems, #item_list) then
		 mainIni.main.ComboTest = ComboTest[0]
		 inicfg.save(mainIni, "MiniHelper-CR")
		end

        imgui.Image(imhandle, imgui.ImVec2(250, 300)) -- ��� ������� �������� ���� ��������
		--- 1 �������� ����� ---	
		
		
		


        --- 2 �������� ����� ---
		elseif tab == 2 then
		if imgui.Checkbox(u8'������ �������', checkbox_standart) then
		mainIni.main.standart = checkbox_standart[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
        end
		if imgui.Checkbox(u8'������ ���������� �������', checkbox_platina) then
	    mainIni.main.platina = checkbox_platina[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Checkbox(u8'������ ������� (�����)', checkbox_donate) then
		mainIni.main.donate = checkbox_donate[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Checkbox(u8'������ ����� �����', checkbox_mask) then
        mainIni.main.mask = checkbox_mask[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
        end	
		if imgui.Checkbox(u8'������ ��� �������', checkbox_tainik) then
	    mainIni.main.tainik = checkbox_tainik[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
	    end 	
		if imgui.Checkbox(u8'������ Vice City', checkbox_vice) then
	    mainIni.main.vice = checkbox_vice[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
        end 
        
        if imgui.Checkbox(u8'��������� �������###777', workbotton) then
            work = true
            chestonoff = true
        end

            if workbotton[0] == false then
                chestonoff = false
                work = false
                startTime = os.time() 
                delayedtimeraaaa = false
                
            end
        

            delayedtimeraaaa = false
        
        imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 4"))
        imgui.SameLine()
        imgui.SetCursorPosX(195)
        if imgui.Button(u8'�������##2') then
            sms('������� {mc}������{-1}, ����� ��������� �������.')
            chestpos = true
        end
        imgui.Separator()
       
        
        imgui.PushItemWidth(220)
        --imgui.InputText(u8"���##15689", timechestto, 256, imgui.InputTextFlags.CharsDecimal)
        
        imgui.SliderInt(u8'���##15689', timechestto, 1, 150) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        --imgui.SameLine()
       
        --imgui.Text('                  '..counter)
   
        imgui.PopItemWidth()
        if imgui.Checkbox(u8'���������� ������', delayedtimer) then
            delayedtimeraaaa = true
        end


        if delayedtimer[0] == false then
            delaychect = os.time()
            delayedtimeraaaa = false
        end

        imgui.SameLine()
        imgui.SetCursorPosX(195)
        if imgui.Button(u8'�������##3') then
            sms('������� {mc}������{-1}, ����� ��������� �������.')
            delayedtimerpos = true
        end
   

      
        if imgui.Button(u8'Inventory', imgui.ImVec2(250, 8)) then
        sampSendChat('/invent')   
        end
        --- 2 �������� ����� ---
		
	
	    --- 3 �������� ����� ---
    elseif tab == 3 then 
            
        if imgui.ActiveButton(u8(marketBool.now[0] and '��������' or '���������'), imgui.ImVec2(170)) then marketBool.now[0] = not marketBool.now[0] end
        imgui.SameLine()
        imgui.Text(u8('������ ����'))

      


    


    if imgui.Button(u8('�������� �������'), imgui.ImVec2(120)) then
        marketShop = {}
        for i = 1, stroki[0] do marketShop[i] = '�� ������ �������� ����� (1 ��.) � ������ Test �� $123.123.123.123' end
        

    end
    imgui.SameLine()
    if imgui.Button(u8('�������� �������'), imgui.ImVec2(120)) then
    marketShop = {}
    end

    if imgui.DragFloat(u8('������ ������'), fontSize, 0.01, 0.1, 2.0, "%.1f") then
        jsonConfig['market'].fontSize = fontSize[0]
        json('Config.json'):save(jsonConfig)
    end
    --if imgui.DragFloat(u8('������������ ������'), fontAlpha, 0.01, 0.0, 1.0, "%.2f") then
        --jsonConfig['market'].fontAlpha = fontAlpha[0]
       -- json('Config.json'):save(jsonConfig)
   -- end
    if imgui.DragFloat(u8('������������ ����'), marketAlpha, 0.01, 0.0, 1.0, "%.2f") then
        jsonConfig['market'].marketAlpha = marketAlpha[0]
        json('Config.json'):save(jsonConfig)
    end

    if imgui.SliderInt(u8'���-�� �����', stroki, 5, 30) then -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        mainIni.main.stroki = stroki[0]
		inicfg.save(mainIni, "MiniHelper-CR")
    end
    if imgui.ColorEdit3(u8('���� ������'), marketColor.text) then
        jsonConfig['market'].marketColor.text = {marketColor.text[0], marketColor.text[1], marketColor.text[2]}
        json('Config.json'):save(jsonConfig)
    end
    if imgui.ColorEdit3(u8('���� ����'), marketColor.window) then
        jsonConfig['market'].marketColor.window = {marketColor.window[0], marketColor.window[1], marketColor.window[2]}
        json('Config.json'):save(jsonConfig)
    end
    if imgui.ActiveButton(u8('�������'), imgui.ImVec2(85 - 2.5)) then
        sms('������� {mc}������{-1}, ����� ��������� �������.')
        window[0], marketBool.now[0] = false, true
        sampSetCursorMode(4)
        lua_thread.create(function()
            while true do
                marketPos = imgui.ImVec2(select(1, getCursorPos()), select(2, getCursorPos()))
                jsonConfig['market'].marketPos = {x = marketPos.x, y = marketPos.y}
                json('Config.json'):save(jsonConfig)
                if isKeyDown(32) then
                    sms('�������������� ���������.')
                    
                    window[0], marketBool.now[0] = true, true
                    sampSetCursorMode(0)
                    break
                end
                wait(0)
            end
        end)
    end
    imgui.SameLine()
    imgui.Text(u8('�������������� ����'))

    if imgui.ColorEdit3(u8('���� �������'), scriptColor) then getTheme() end
        --- 3 �������� ����� ---
		
       	
		--- 4 �������� ����� ---
    



        

    elseif tab == 4 then
        --imgui.Checkbox(u8'���� ������� 1 ������', autokey1)
		--imgui.SliderInt(u8'������ � ��', timekey1, 5, 100) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        --imgui.InputTextWithHint(u8'HEX ���', u8'������� HEX ��� �������', buttonkey1, 256)
		--imgui.Separator()
		--imgui.Checkbox(u8'���� ������� 2 ������###auto1', autokey2)
		--imgui.SliderInt(u8'������ � ��###auto2', timekey2, 5, 100) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        --imgui.InputTextWithHint(u8'HEX ���###auto3', u8'������� HEX ��� �������', buttonkey2, 256)
		--imgui.SliderInt(u8'������ � ��###auto4', timekey3, 5, 100) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        --imgui.InputTextWithHint(u8'HEX ���###auto5', u8'������� HEX ��� �������', buttonkey3, 256)
		--imgui.Separator()


        -- �����������: ������� "������"
        
        -- ���� ��� ������ ������� �� ��������� �������
        imgui.Checkbox(u8'������ �� ��', lenwh)
        imgui.Checkbox(u8'������ �� ������', xlopokwh)
        imgui.Checkbox(u8'������ �� �����', shaxta)
        imgui.Checkbox(u8'���� Alt', autoalt)
    
        imgui.Separator()	
        -- �������� ��� ������ �������� pov
         if imgui.SliderInt(u8'pov', powfish, 70, 110) then 
            mainIni.main.powfish = powfish[0]
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        imgui.SameLine()
        -- ������ ��� ������ �������� pov
        if imgui.Button(u8'�����') then
            cameraSetLerpFov(70.0, 70.0, 1000, 1)
            powfish[0] = 70
            mainIni.main.powfish = powfish[0]
            inicfg.save(mainIni, "MiniHelper-CR")
        end  
        imgui.Separator()	
        -- ���� ��� ������ �������� ����
        if imgui.Checkbox(u8'����������� ���', running) then
            mainIni.main.running = running[0] 
            inicfg.save(mainIni, "MiniHelper-CR")
        end
    
        if imgui.Checkbox(u8'������� ��� � ����', speedrunning) then
            mainIni.main.speedrunning = speedrunning[0] 
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        imgui.SameLine()
        imgui.PushItemWidth(40)
        if imgui.InputText(u8"HEX ���", speedrunningkey, 256) then
            mainIni.main.speedrunningkey = u8:decode(str(speedrunningkey))
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        imgui.PopItemWidth()

        imgui.Separator()
        imgui.PushItemWidth(80)
        if imgui.Checkbox(u8'���/����###checkboxkodbank', checkboxkodbank) then
            mainIni.main.checkboxkodbank = checkboxkodbank[0] 
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        imgui.SameLine()
        if imgui.InputText(u8"������ ����", kodbank, 256, imgui.InputTextFlags.CharsDecimal) then
            mainIni.main.kodbank = u8:decode(str(kodbank))
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        if imgui.Checkbox(u8'���/����###checkboxkodsklad', checkboxkodsklad) then
            mainIni.main.checkboxkodsklad = checkboxkodsklad[0] 
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        imgui.SameLine()
        if imgui.InputText(u8"������ �����", kodsklad, 256, imgui.InputTextFlags.CharsDecimal) then
            mainIni.main.kodsklad = u8:decode(str(kodsklad))
            inicfg.save(mainIni, "MiniHelper-CR")
        end
        imgui.PopItemWidth()
        --[[if imgui.Button(u8'[���� ������ ���������� � ����]') then -- ������ ������ ��������� ��� ���������
            os.execute("start https://narvell.nl/keys")
            end
           ]]
            
           
        elseif tab == 5 then  
       
            if imgui.Checkbox(u8'���/����', show) then
                mainIni.main.show = show[0] 
                inicfg.save(mainIni, "MiniHelper-CR")
        
            end
            imgui.SameLine()
            imgui.SetCursorPosX(135)
            if imgui.Checkbox(u8'������##1', infonline) then
            mainIni.main.infonline = infonline[0] 
            inicfg.save(mainIni, "MiniHelper-CR")
            end
        
            if imgui.Checkbox(u8'������ �����##1', infrender) then
                mainIni.main.infrender = infrender[0] 
                inicfg.save(mainIni, "MiniHelper-CR")
            end
        
            imgui.SameLine()
            imgui.SetCursorPosX(135)
            if imgui.Checkbox(u8'������ �����##1', infradius) then
                mainIni.main.infradius = infradius[0] 
                inicfg.save(mainIni, "MiniHelper-CR")
            end
        
            if imgui.Checkbox(u8'����� �������##1', infclean) then
                mainIni.main.infclean = infclean[0] 
                inicfg.save(mainIni, "MiniHelper-CR")
            end
        
            imgui.SameLine()
            imgui.SetCursorPosX(135)
            if imgui.Checkbox(u8'����-��������##1', infautoclean) then
                mainIni.main.infautoclean = infautoclean[0] 
                inicfg.save(mainIni, "MiniHelper-CR")
            end
        
            if imgui.Checkbox(u8'����-�����##1', infautolavka) then
                mainIni.main.infautolavka = infautolavka[0] 
                inicfg.save(mainIni, "MiniHelper-CR")
            end
        
        
            if imgui.DragFloat(u8('������ ������'), fontSizea, 0.01, 0.1, 2.0, "%.1f") then
                jsonConfig['informer'].fontSizea = fontSizea[0]
                json('Config.json'):save(jsonConfig)
            end
        
            if imgui.DragFloat(u8('������������ ����'), marketAlphaa, 0.01, 0.0, 1.0, "%.2f") then
                jsonConfig['informer'].marketAlphaa = marketAlphaa[0]
                json('Config.json'):save(jsonConfig)
            end
        
            if imgui.ColorEdit3(u8('���� ������'), marketColora.text) then
                jsonConfig['informer'].marketColora.text = {marketColora.text[0], marketColora.text[1], marketColora.text[2]}
                json('Config.json'):save(jsonConfig)
            end
            if imgui.ColorEdit3(u8('���� ����'), marketColora.window) then
                jsonConfig['informer'].marketColora.window = {marketColora.window[0], marketColora.window[1], marketColora.window[2]}
                json('Config.json'):save(jsonConfig)
            end
        
            if imgui.ActiveButton(u8('�������'), imgui.ImVec2(85 - 2.5)) then
                sms('������� {mc}������{-1}, ����� ��������� �������.')
                window[0], show[0] = false, true
                sampSetCursorMode(4)
                lua_thread.create(function()
                    while true do
                        marketPosa = imgui.ImVec2(select(1, getCursorPos()), select(2, getCursorPos()))
                        jsonConfig['informer'].marketPosa = {x = marketPosa.x, y = marketPosa.y}
                        json('Config.json'):save(jsonConfig)
                        if isKeyDown(32) then
                            sms('�������������� ���������.')
                            
                            window[0], show[0] = true, true
                            sampSetCursorMode(0)
                            break
                        end
                        wait(0)
                    end
                end)
            end
            imgui.SameLine()
            imgui.Text(u8('�������������� ����'))

   
	    --- 5 �������� ����� ---
	    elseif tab == 6 then
        if imgui.Checkbox(u8'��������� ������� �� TG', cmd) then
		mainIni.main.cmd = cmd[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
        if imgui.Checkbox(u8'���������� ������� � TG', diolog) then
		mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end	
        if imgui.InputText(u8"TG ID", chat_id, 256) then 
	    mainIni.main.chat_id = u8:decode(str(chat_id))
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
	    if imgui.InputText(u8"TG TOKEN", token, 256) then
	    mainIni.main.token = u8:decode(str(token))
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Button(u8'�������� ���������') then
        sendTelegramNotification('�������� ��������� �� '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) -- ���������� ��������� �����
	    end
        imgui.Text(u8'/help -- ������ ������.')
		
        imgui.Separator()
        --- 5 �������� ����� ---
        if imgui.Checkbox(u8'���� ��������', skipdiolog) then
        mainIni.main.skipdiolog = skipdiolog[0] 
        inicfg.save(mainIni, "MiniHelper-CR")
        end
       
         nickrecons = new.char[256](u8(mainIni.main.nickrecons))
         serverrecon = new.char[256](u8(mainIni.main.serverrecon))

        if imgui.InputText(u8"�������", nickrecons, 256) then 
            mainIni.main.nickrecons = u8:decode(str(nickrecons))
            inicfg.save(mainIni, "MiniHelper-CR")
            end
      

            if imgui.InputText(u8"ip �������", serverrecon, 256) then 
                mainIni.main.serverrecon = u8:decode(str(serverrecon))
                inicfg.save(mainIni, "MiniHelper-CR")
                end
                
                
              
        end
        imgui.EndChild()
        end
        imgui.End()
        end)

        
         

            local marketFrame = imgui.OnFrame(
                function() return not marketBool.always[0] and marketBool.now[0] and not isPauseMenuActive() and not sampIsScoreboardOpen() end,
                function(player)
                    player.HideCursor = true
                    local sx, sy = getScreenResolution()
                    local position = marketPos.x ~= -1 and marketPos or imgui.ImVec2((sx - marketSize.x[0]) / 2, sy - marketSize.y[0] - sy * 0.01)
                    imgui.SetNextWindowPos(position, imgui.Cond.Always)
                    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(marketColor.text[0], marketColor.text[1], marketColor.text[2], fontAlpha[0]))
                    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(marketColor.window[0], marketColor.window[1], marketColor.window[2], marketAlpha[0]))
                        imgui.Begin('market', market, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
                      
                        imgui.SetWindowFontScale(fontSize[0])
                            for i = #marketShop, 1, -1 do
                                imgui.Text(u8(marketShop[i]))
                            end
                        imgui.End()
                    imgui.PopStyleColor(2)
                end
            )




local debugwh3d = new.bool()
local Sliderdebugwh3d = new.int(10)
local debugwh = new.bool()
local textdrawid = new.bool()
local textdiologid = ''

imgui.OnFrame(function() return showdebug[0] end, function(player)
    local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5,0.5))
    local bug = ti 'bug'
    imgui.Begin(bug..' Debug', showdebug, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
    imgui.Checkbox(u8'WH 3d text', debugwh3d)
    if debugwh3d[0] == true then
    imgui.PushItemWidth(150)   
    imgui.SliderInt(u8'dist##1', Sliderdebugwh3d, 10, 200)
    imgui.PopItemWidth()
    end
    imgui.Checkbox(u8'WH Object', debugwh)
    imgui.Checkbox(u8'id textdraw', textdrawid)
    
    if imgui.Button('id diolog') then
        local dtx = sampGetDialogText()
        local dtp = sampGetCurrentDialogType()
        local did = sampGetCurrentDialogId()
        local dcp = sampGetDialogCaption()
        textdiologid = string.format("{00BEFC}Current dialog info:\nDialog ID:{FFFFFF} %d \n{00BEFC}Dialog Type:{FFFFFF} %d \n{00BEFC}Dialog Caption:{FFFFFF}\n%s\n{00BEFC}Dialog text:{FFFFFF}\n%s", did, dtp, dcp, dtx)
    end
    imgui.SameLine()
    if imgui.Button('clean') then
        textdiologid = ''
    end   

    imgui.TextColoredRGBs(''..textdiologid)

    imgui.End()
end).HideCursor = true -- HideCursor �������� �� ��, ����� ������ �� �����������
     
            fpsID = ''
            ping = ''
            local sessionStart = os.time()
            local sessiononline = 0
           

            local marketFramea = imgui.OnFrame(
                function() return  show[0] and not isPauseMenuActive() and not sampIsScoreboardOpen() end,
                function(player)
                    player.HideCursor = true
                    local sx, sy = getScreenResolution()
                    local position = marketPosa.x ~= -1 and marketPosa or imgui.ImVec2((sx - marketSizea.x[0]) / 2, sy - marketSizea.y[0] - sy * 0.01)
                    imgui.SetNextWindowPos(position, imgui.Cond.Always)
                    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(marketColora.text[0], marketColora.text[1], marketColora.text[2], fontAlphaa[0]))
                    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(marketColora.window[0], marketColora.window[1], marketColora.window[2], marketAlphaa[0]))
                        imgui.Begin('informer', show, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
                            imgui.SetWindowFontScale(fontSizea[0])



                  
                            imgui.Text(u8"Fps: "..fpsID)
                            imgui.SameLine() 
                            imgui.Text(u8" Ping: "..ping) 
                            if infonline[0] then
                            imgui.Text(u8("������ �� ������: "..get_timer(sessiononline)..' ')) 
                            end


                       

                            if infrender[0] then
                            if lavka[0] == true then
                                imgui.Text(u8"������ �����") 
                                imgui.SameLine() 
                                imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), u8"�������")
                                else
                                imgui.Text(u8"������ �����")  
                                imgui.SameLine()
                                imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"��������") 
                            end  
                        end
                           
                           
                            
                            if infradius[0] then
                            if radiuslavki[0] == true then
                                imgui.Text(u8"������ �����") 
                                imgui.SameLine()
                                imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), u8"�������")
                                    else
                                imgui.Text(u8"������ �����")
                                imgui.SameLine()
                                imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"��������") 
                    
                            end 
                        end
                            
                            if infclean[0] then
                            if clean[0] == true then
                                imgui.Text(u8"�������� �������")
                                imgui.SameLine()                  
                                imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), u8"�������")
                                    else
                                imgui.Text(u8"�������� �������")
                                imgui.SameLine()
                                imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"��������") 
                            end
                        end 

                            if infautoclean[0] then
                            if autoclean[0] == true then
                                imgui.Text(u8"����-��������")
                                imgui.SameLine()                  
                                imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), u8"�������")
                                    else
                                imgui.Text(u8"����-��������")
                                imgui.SameLine()
                                imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"��������") 
                            end 
                        end

                            if infautolavka[0] then
                            if settingslavka[0] == true then
                                imgui.Text(u8"����-�����") 
                                imgui.SameLine()                 
                                imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), u8"�������")
                                    else
                                imgui.Text(u8"����-�����")
                                imgui.SameLine()
                                imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"��������") 
                            end
                        end




                            --settingslavka
                            
                        imgui.End()
                    imgui.PopStyleColor(2)
                end
            )

            
    



        function imgui.ActiveButton(name, ...)
            imgui.PushStyleColor(imgui.Col.Button, convertDecimalToRGBA(palette.accent1.color_500))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, convertDecimalToRGBA(palette.accent1.color_400))
            imgui.PushStyleColor(imgui.Col.ButtonActive, convertDecimalToRGBA(palette.accent1.color_300))
            local result = imgui.Button(name, ...)
            imgui.PopStyleColor(3)
            return result
        end

        function sms(text)
            local color_chat = '7172ee'
            local text = tostring(text):gsub('{mc}', '{' .. color_chat .. '}'):gsub('{%-1}', '{FFFFFF}')
            sampAddChatMessage(string.format('� %s � {FFFFFF}%s', thisScript().name, text), tonumber('0x' .. color_chat))
        end


        
---����� ��� ����� � ���� �����������---

-- https://github.com/ass138/cr-helper-arz/tree/main
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/ass138/cr-helper-arz/main/version.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/ass138/cr-helper-arz/tree/main"
        end
    end
end
---����� ��� ����� � ���� �����������---



function main()
    while not isSampAvailable() do wait(100) end -- ��� ����� ���������� ����
	wait(500)
	sampAddChatMessage('� {00FF00}[������-Helper]{FFFFFF} ���������: {7FFF00}F2{FFFFFF} ��� {7FFF00}/CR {FFFFFF}�', -1)
    sampRegisterChatCommand('cr', function() window[0] = not window[0] end)	
    sampRegisterChatCommand('call', getnumber)
	getLastUpdate() -- �������� ������� ��������� ���������� ID ���������
    	          if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
		    lua_thread.create(get_telegram_updates) -- ������� ���� ������� ��������� ��������� �� �����	
			lua_thread.create(lavkirendor)
            lua_thread.create(radiuslavkis)
			lua_thread.create(cleanr)
			lua_thread.create(eat)
			lua_thread.create(autokeys)
			lua_thread.create(crtextdraw)
            lua_thread.create(chestss)
            lua_thread.create(delayedtimers)
            lua_thread.create(bind)
            lua_thread.create(sizewindow)
            lua_thread.create(lavkatextand)
            lua_thread.create(bike)
            lua_thread.create(runnings)
            lua_thread.create(lenandxlopak)
            lua_thread.create(shaxtas)
            lua_thread.create(autoalts)
            lua_thread.create(posxy)
            lua_thread.create(showfps)
            lua_thread.create(camhack)
            lua_thread.create(photopng)
            lua_thread.create(powfishpov)
            lua_thread.create(textdraws) 
            lua_thread.create(whobject)  
            lua_thread.create(wh3dtext)  
            lua_thread.create(autoreconectrandom)  
            

      

                  
            
            

	while true do wait(0)
	  if wasKeyPressed(VK_F2) and not sampIsCursorActive() then -- ���� ������ ������� R � �� ������� ���� ������
            window[0] = not window[0]  
            imgui.Process = main_window_state
            imgui.ShowCursor = false
            posX, posY = getCursorPos() -- ������� ��������� �������� ���������� ������� �� ������           
        end
    end
end

function imgui.TextColoredRGBs(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4
    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end
    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end
    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end
    render_text(text)
end



function wh3dtext()
    while true do
        wait(0)
        if debugwh3d[0] then 
        local font = renderCreateFont("Arial", 10, 14)
        for id = 0, 2048 do
            local result = sampIs3dTextDefined(id)
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
                    local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                    local dist = getDistanceBetweenCoords3d(playerX, playerY, playerZ, posX, posY, posZ)
                    if dist <= Sliderdebugwh3d[0] then
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(font,text, wposX, wposY,-1)
                    end
                end
            end
        end
    end
end
end

function whobject()
    while true do
		wait(0)
        local font = renderCreateFont("Arial", 7, 4)
		if debugwh[0] then
			for _, v in pairs(getAllObjects()) do
				local asd
				if sampGetObjectSampIdByHandle(v) ~= -1 then
					asd = sampGetObjectSampIdByHandle(v)
				end
				if isObjectOnScreen(v) then
					local _, x, y, z = getObjectCoordinates(v)
					local x1, y1 = convert3DCoordsToScreen(x,y,z)
					local model = getObjectModel(v)
					local x2,y2,z2 = getCharCoordinates(PLAYER_PED)
					local x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
					local distance = string.format("%.1f", getDistanceBetweenCoords3d(x, y, z, x2, y2, z2))
               
					if debugwh[0] then
    
						renderFontDrawText(font, (debugwh[0] and asd and "model = "..model.."; id = "..asd or "model = "..model).."; distance: "..distance, x1, y1, -1)	          
					end
				end
			end
		end
	end
end



function textdraws()
    local font = renderCreateFont("Arial", 8, 7) --creating font	
	while true do --inf loop
	wait(0) --this shit is important
		if textdrawid[0] then --params that not declared has a nil value that same as false
			for a = 0, 2304	do --cycle trough all textdeaw id
				if sampTextdrawIsExists(a) then --if textdeaw exists then
					x, y = sampTextdrawGetPos(a) --we get it's position. value returns in game coords
					x1, y1 = convertGameScreenCoordsToWindowScreenCoords(x, y) --so we convert it to screen cuz render needs screen coords
					renderFontDrawText(font, a, x1, y1, 0xFFBEBEBE) --and then we draw it's id on textdeaw position
				end
			end
		end
	end
end

function powfishpov()
    original_fov = getCameraFov()
    changeable_fov = getCameraFov()
    while true do wait(0)
        

        cameraSetLerpFov(powfish[0], powfish[0], 1000, 1)
end
end

local dhook, hook = pcall(require, 'lib.samp.events')
function photopng()
	if not doesDirectoryExist("moonloader\\config\\MiniCrHelper") then createDirectory('moonloader\\config\\MiniCrHelper') end	
	downloadUrlToFile('https://i.imgur.com/THUtlo7.png', getWorkingDirectory() .. '/config/MiniCrHelper/123.png')
	end






function camhack()
	--sampAddChatMessage('��?', 0xFFFFFF)
	flymode = 0  
	speed = 1.0
	radarHud = 0
	time = 0
	keyPressed = 0
	while true do
	--displayRadar(false)
		wait(0)
		time = time + 1
		if isKeyDown(VK_X) and isKeyDown(VK_1) then
			if flymode == 0 then
				--setPlayerControl(playerchar, false)
				displayRadar(false)
				displayHud(false)	    
				posX, posY, posZ = getCharCoordinates(playerPed)
				angZ = getCharHeading(playerPed)
				angZ = angZ * -1.0
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
				angY = 0.0
				--freezeCharPosition(playerPed, false)
				--setCharProofs(playerPed, 1, 1, 1, 1, 1)
				--setCharCollision(playerPed, false)
				lockPlayerControl(true)
				flymode = 1
			--	sampSendChat('/anim 35')
			end
		end
		if flymode == 1 and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
			offMouX, offMouY = getPcMouseMovement()  
			  
			offMouX = offMouX / 4.0
			offMouY = offMouY / 4.0
			angZ = angZ + offMouX
			angY = angY + offMouY

			if angZ > 360.0 then angZ = angZ - 360.0 end
			if angZ < 0.0 then angZ = angZ + 360.0 end

			if angY > 89.0 then angY = 89.0 end
			if angY < -89.0 then angY = -89.0 end   

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)

			curZ = angZ + 180.0
			curY = angY * -1.0      
			radZ = math.rad(curZ) 
			radY = math.rad(curY)                   
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 10.0     
			cosZ = cosZ * 10.0       
			sinY = sinY * 10.0                       
			posPlX = posX + sinZ 
			posPlY = posY + cosZ 
			posPlZ = posZ + sinY              
			angPlZ = angZ * -1.0
			--setCharHeading(playerPed, angPlZ)

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)

			if isKeyDown(VK_W) then      
				radZ = math.rad(angZ) 
				radY = math.rad(angY)                   
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * speed      
				cosZ = cosZ * speed       
				sinY = sinY * speed  
				posX = posX + sinZ 
				posY = posY + cosZ 
				posZ = posZ + sinY      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0         
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)

			if isKeyDown(VK_S) then  
				curZ = angZ + 180.0
				curY = angY * -1.0      
				radZ = math.rad(curZ) 
				radY = math.rad(curY)                   
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * speed      
				cosZ = cosZ * speed       
				sinY = sinY * speed                       
				posX = posX + sinZ 
				posY = posY + cosZ 
				posZ = posZ + sinY      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)
			  
			if isKeyDown(VK_A) then  
				curZ = angZ - 90.0
				radZ = math.rad(curZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinZ = sinZ * speed
				cosZ = cosZ * speed
				posX = posX + sinZ
				posY = posY + cosZ
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY
			pointCameraAtPoint(poiX, poiY, poiZ, 2)       

			if isKeyDown(VK_D) then  
				curZ = angZ + 90.0
				radZ = math.rad(curZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)       
				sinZ = sinZ * speed
				cosZ = cosZ * speed
				posX = posX + sinZ
				posY = posY + cosZ      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)   

			if isKeyDown(VK_SPACE) then  
				posZ = posZ + speed
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0       
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2) 

			if isKeyDown(VK_SHIFT) then  
				posZ = posZ - speed
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0       
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2) 

			if keyPressed == 0 and isKeyDown(VK_F10) then
				keyPressed = 1
				if radarHud == 0 then
					displayRadar(true)
					displayHud(true)
					radarHud = 1
				else
					displayRadar(false)
					displayHud(false)
					radarHud = 0
				end
			end

			if wasKeyReleased(VK_F10) and keyPressed == 1 then keyPressed = 0 end

			if isKeyDown(187) then 
				speed = speed + 0.01
				printStringNow(speed, 1000)
			end 
			               
			if isKeyDown(189) then 
				speed = speed - 0.01 
				if speed < 0.01 then speed = 0.01 end
				printStringNow(speed, 1000)
			end   

			if isKeyDown(VK_X) and isKeyDown(VK_2) then
				--setPlayerControl(playerchar, true)
				displayRadar(true)
				displayHud(true)
				radarHud = 0	    
				angPlZ = angZ * -1.0
				--setCharHeading(playerPed, angPlZ)
				--freezeCharPosition(playerPed, false)
				lockPlayerControl(false)
				--setCharProofs(playerPed, 0, 0, 0, 0, 0)
				--setCharCollision(playerPed, true)
				restoreCameraJumpcut()
				setCameraBehindPlayer()
				flymode = 0     
			end
		end
	end
end

function get_timer(time)
    return string.format("%s:%s:%s",string.format("%s%s",((tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0)))) < 10 and 0 or ""),(tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0))))),os.date("%M",time),os.date("%S",time))
    end

function showfps()
    while true do wait(400)
        if sampGetGamestate() == 3 then sessiononline = os.time() - sessionStart end
        fps = Memory.getfloat(0xB7CB50, 0, false)
        fpsID = string.format('%.f', fps)
        _, PINGUPDATE = sampGetPlayerIdByCharHandle(PLAYER_PED)
        ping = sampGetPlayerPing(PINGUPDATE)
        end
    end





function posxy()
while true do wait(0)
    if renderlavok then
        local mouseX, mouseY = getCursorPos()
        mainIni.main.renderlavokx, mainIni.main.renderlavoky = mouseX, mouseY
        if isKeyDown(32) then
            inicfg.save(mainIni, "MiniHelper-CR")
            renderlavok = false
            sampAddChatMessage("������� ���������", -1)
        end
    end
if chestpos then
    local chestposX, chestposY = getCursorPos()
    mainIni.main.chestposx, mainIni.main.chestposy = chestposX, chestposY
    if isKeyDown(32) then
        inicfg.save(mainIni, "MiniHelper-CR")
        chestpos = false
        sampAddChatMessage("������� ���������", -1)
    end
end
if delayedtimerpos then
    local delayedtimerpossX, delayedtimerpossY = getCursorPos()
    mainIni.main.delayedtimerposx, mainIni.main.delayedtimerposy = delayedtimerpossX, delayedtimerpossY
    if isKeyDown(32) then
        inicfg.save(mainIni, "MiniHelper-CR")
        delayedtimerpos = false
        sampAddChatMessage("������� ���������", -1)
    end
end
end
end













local fontlenandxlopak = renderCreateFont("arial", 10, 12)

---------WH------
function lenandxlopak()
    while true do wait(0)
        if lenwh[0] then
        for id = 0, 2048 do
            local result = sampIs3dTextDefined( id )
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
                if text:match('˸�%((%d+) �� (%d+)%)') then
                    n1,n2=text:match('˸�%((%d+) �� (%d+)%)') 
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontlenandxlopak, "˸�("..n1..' �� '..n2..')', wposX, wposY, 0xFF00FF00)			
                    end
                end
                if text:match('˸� � �������� ����� (.+)') then
                    t1=text:match('˸� � �������� ����� (.+)')
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1)  then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontlenandxlopak, ""..t1, wposX, wposY,-1)
                    end				
                end
            end
        end
    end
    for id = 0, 2048 do
        local result = sampIs3dTextDefined( id )
        if result then
    local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
                if xlopokwh[0] then
                if text:match('������%((%d+) �� (%d+)%)') then
                    n1,n2=text:match('������%((%d+) �� (%d+)%)') 
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontlenandxlopak, "������("..n1..' �� '..n2..')', wposX, wposY, 0xFF00FF00)
                    end
                end
                if text:match('������ � �������� ����� (.+)') then
                    t1=text:match('������ � �������� ����� (.+)')
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1)  then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontlenandxlopak, ""..t1, wposX, wposY,-1)
                    end				
                end              
          end
        end
    end
end
end



function Search3Dtext(x, y, z, radius, patern) -- https://www.blast.hk/threads/13380/post-119168
    local text = ""
    local color = 0
    local posX = 0.0
    local posY = 0.0
    local posZ = 0.0
    local distance = 0.0
    local ignoreWalls = false
    local player = -1
    local vehicle = -1
    local result = false

    for id = 0, 2048 do
        if sampIs3dTextDefined(id) then
            local text2, color2, posX2, posY2, posZ2, distance2, ignoreWalls2, player2, vehicle2 = sampGet3dTextInfoById(id)
            if getDistanceBetweenCoords3d(x, y, z, posX2, posY2, posZ2) < radius then
                if string.len(patern) ~= 0 then
                    if string.match(text2, patern, 0) ~= nil then result = true end
                else
                    result = true
                end
                if result then
                    text = text2
                    color = color2
                    posX = posX2
                    posY = posY2
                    posZ = posZ2
                    distance = distance2
                    ignoreWalls = ignoreWalls2
                    player = player2
                    vehicle = vehicle2
                    radius = getDistanceBetweenCoords3d(x, y, z, posX, posY, posZ)
                end
            end
        end
    end
    return result, text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle
end


function autoalts()
    while true do
		wait(450) -- ��������
		if autoalt[0] then
			local x, y, z = getCharCoordinates(PLAYER_PED)
			local result, _, _, _, _, _, _, _, _, _ = Search3Dtext(x, y, z, 3, "{73B461}���")
			if result then
				setGameKeyState(21, 255)
				wait(5)
				setGameKeyState(21, 0)
				result = false
			end
        end
    end
end


local fontshaxta = renderCreateFont("impact", 12, 12)

function shaxtas()
while true do wait(0)
if shaxta[0] then
        for id = 0, 2048 do
            local result = sampIs3dTextDefined( id )
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
                if text:match('������������� ��������') then
                    n10= '����'
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontshaxta, n10, wposX, wposY, 0xFF00FF00)
                    end
                end
            end
        end
    end
end
end



---------WH------


local mem = require "memory"
function runnings()
    while true do
        wait(0)
if running[0] then
    mem.setint8(0xB7CEE4, 1)
else
    mem.setint8(0xB7CEE4, 0)
end
end
end


function getnumber(id)
    sampAddChatMessage('[����������] {FFFFFF}������� {00FF00}/call id {FFFFFF}������.', 0xFFFF00)
    sampSendChat("/number " .. id)
end

function isKeyCheckAvailable()
	if not isSampLoaded() then
		return true
	end
	if not isSampfuncsLoaded() then
		return not sampIsChatInputActive() and not sampIsDialogActive()
	end
	return not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()
end


function bike()
    while true do
        wait(0)
        if speedrunning[0] then
            if isCharOnAnyBike(playerPed) and isKeyCheckAvailable() and isKeyDown(u8:decode(str(speedrunningkey))) then	-- onBike&onMoto SpeedUP [[LSHIFT]] --
                if getCarModel(storeCarCharIsInNoSave(playerPed)) then
                    setGameKeyState(16, 255)
                    wait(10)
                    setGameKeyState(16, 0)
                end
            end
            
            
        if isKeyDown(u8:decode(str(speedrunningkey))) and isKeyCheckAvailable() then -- onFoot&inWater SpeedUP [[1]] --
                setGameKeyState(16, 256)
                wait(10)
                setGameKeyState(16, 0)  
            
        
    end
end
end
end



        
    
---Kim_Blady {BEBB55}��������{FFFFFF} �����
--Andrey_Paxalenko {555ABE}������{FFFFFF} �����

---..thisScript().version
---script_namew

local fontas = renderCreateFont("Arial", 10, 5)
local nametegs = {'Papa_Prince', 'Papa_King', 'Kevin_Halt', 'Kevin_Robert', 'Luank_Prince'};

function lavkatextand()
    while true do
        wait(0)
        for id = 0, 2048 do
            local result = sampIs3dTextDefined(id)
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById(id)
                for a, b in ipairs(nametegs) do
                if text:find(b) then
                    local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                    local dist = getDistanceBetweenCoords3d(playerX, playerY, playerZ, posX, posY, posZ)
                    if dist <= 100.0 and dist >= 5 then
                        local wposX, wposY, wposZ = convert3DCoordsToScreen(posX, posY, posZ)
                        local resX, resY = getScreenResolution()
                        if wposX < resX and wposY < resY and isPointOnScreen(posX, posY, posZ, 1) then
                            renderFontDrawText(fontas, text, wposX, wposY, 0xFF00FF00)
                        end
                    end
                end
            end
        end
    end
end
end









function sizewindow()
    while true do wait(0)
        if changepos then -- �������������� ������� ������, ��� ����� �������� � � ��� ������
            posX, posY = getCursorPos() -- ������� ��������� �������� ���������� ������� �� ������
            if isKeyJustPressed(1) then -- ���� ������ ���, �� ��������� �������
                changepos = false
            end
        end
    end
end




function imgui.ColoredButton(text,hex,trans,size)
    local r,g,b = tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
    if tonumber(trans) ~= nil and tonumber(trans) < 101 and tonumber(trans) > 0 then a = trans else a = 60 end
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r/255, g/255, b/255, a/100))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r/255, g/255, b/255, a/100))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r/255, g/255, b/255, a/100))
    local button = imgui.Button(text, size)
    imgui.PopStyleColor(3)
    return button
end

function delayedtimers()
    while true do 
        wait(0)
        if delayedtimeraaaa then	
            delaychect = os.time() + timechestto[0] * 60 -- ������������� ������ �� 5 �����
            while os.time() < delaychect do
                wait(0)
                local timeRemainings = delaychect - os.time()
                local minutess = math.floor(timeRemainings / 60)
                local secondss = timeRemainings % 60
                local timeStrings = string.format("%02d:%02d", minutess, secondss)
                renderFontDrawText(font,'Timer '..timeStrings, mainIni.main.delayedtimerposx, mainIni.main.delayedtimerposy, 0xFFFF0000, 0x90000000)
            end
            -- �������� �� ���������� �������
            
            -- ����� ����� ���� ������ �������� � ����������� �� ����� ������
            
            workbotton = new.bool(true)
            chestonoff = true
            work = true
            delayedtimer = new.bool(false)
            --imgui.StrCopy(timechestto, '')
            delaychect = os.time()
            delayedtimeraaaa = false
            --break -- ����� �� ����� ����� ���������� �������
        end
    end
end

pizdap = false

function onReceivePacket(id)
    if id == 32 then
        sendTelegramNotification('C����� ������ ����������')
            workbotton[0] = false 
            chestonoff = false
            work = false
            startTime = os.time()  
            pizdap = true

    end
    if id == 33 then
        sendTelegramNotification('C����� ������ ����������')
            workbotton[0] = false 
            chestonoff = false
            work = false
            startTime = os.time() 
            pizdap = true

    end
end

function random(min, max)
    local kf = math.random(min, max)
    math.randomseed(os.time() * kf)
    local rand = math.random(min, max)
    return tonumber(rand)
end



function autoreconectrandom()
    while true do
		wait(0)
    if pizdap then
            delaychectqaq = os.time() +  random(15,30) * 60 -- ������������� ������ �� 5 �����.
            local wwwwwwwwwwwad = delaychectqaq - os.time()
            local minuawdawdatessa = math.floor(wwwwwwwwwwwad / 60)
            sendTelegramNotification('�������������� ��������� �����: '..minuawdawdatessa.. ' ���.')
            while os.time() < delaychectqaq do
                wait(0)
                local sw,sh = getScreenResolution()
                local timeRemainingsa = delaychectqaq - os.time()
                local minutessa = math.floor(timeRemainingsa / 60)
                local secondssa = timeRemainingsa % 60
                local rtimea  = string.format("%02d:%02d", minutessa, secondssa)
                renderFontDrawText(font,''..rtimea,sw/2-renderGetFontDrawTextLength(font,'�����!')/2,sh/2,0xFFFF0000 )             
            end           
            sampSetLocalPlayerName(mainIni.main.nickrecons)
            wait(200)
            sampConnectToServer(mainIni.main.serverrecon, 7777)
            pizdap = false
         end
    end
end

    


-- ������� ���������� ��� �������� ���������� �� �����������
local circleCoordinates = {}

-- ������� ��� ���������� ���������� � ����� ����������
function addCircleInfo(x, y, radius)
    table.insert(circleCoordinates, {x, y, radius})
end




function radiuslavkis()
	while true do
		wait(0)
		if radiuslavki[0] then
			local myPos = {getCharCoordinates(1)}
	        for IDTEXT = 0, 2048 do
	            if sampIs3dTextDefined(IDTEXT) then
	                local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
	                if text == "���������� ��������." and not isCentralMarket(posX, posY) then
	                    local distanceToText = getDistanceBetweenCoords3d(posX, posY, posZ, myPos[1], myPos[2], myPos[3])
	                    if distanceToText <= 20.0 then
	                        drawCircleIn3d(posX,posY,posZ-1.3,5,36,1.5,	getDistanceBetweenCoords3d(posX,posY,0,myPos[1],myPos[2],0) > 5 and 0xFFFFFFFF or 0xFFFF0000)
	                    end
	                end
	            end
	        end
	    end
	end
end


drawCircleIn3d = function(x, y, z, radius, polygons,width,color)
    local step = math.floor(360 / (polygons or 36))
    local sX_old, sY_old
    for angle = 0, 360, step do
        local lX = radius * math.cos(math.rad(angle)) + x
        local lY = radius * math.sin(math.rad(angle)) + y
        local lZ = z
        local _, sX, sY, sZ, _, _ = convert3DCoordsToScreenEx(lX, lY, lZ)
        if sZ > 1 then
            if sX_old and sY_old then
                renderDrawLine(sX, sY, sX_old, sY_old, width, color)
            end
            sX_old, sY_old = sX, sY
        end
    end
end

isCentralMarket = function(x, y)
	return (x > 1044 and x < 1197 and y > -1565 and y < -1403)
end









local TextDraw_Remove = {{4, 203, 347}, {4, 204, 349}, {2, 208, 351}}

function crtextdraw()
    while true do wait(0)
		for i = 1, 4096 do
			if sampTextdrawIsExists(i) then
				local style = sampTextdrawGetStyle(i)
				local x, y = sampTextdrawGetPos(i)
				local text = sampTextdrawGetString(i)
				for i_table = 1, #TextDraw_Remove do
					if (style == TextDraw_Remove[i_table][1] and math.floor(x) == TextDraw_Remove[i_table][2] and math.floor(y) == TextDraw_Remove[i_table][3]) then	
						sampTextdrawDelete(i)
					end
                end
            end
        end
    end
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local col = imgui.Col
    
    local designText = function(text__)
        local pos = imgui.GetCursorPos()
        if sampGetChatDisplayMode() == 2 then
            for i = 1, 1 --[[������� ����]] do
                imgui.SetCursorPos(imgui.ImVec2(pos.x + i, pos.y))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
                imgui.SetCursorPos(imgui.ImVec2(pos.x - i, pos.y))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
                imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y + i))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
                imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y - i))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
            end
        end
        imgui.SetCursorPos(pos)
    end
    
    
    
    local text = text:gsub('{(%x%x%x%x%x%x)}', '{%1FF}')

    local color = colors[col.Text]
    local start = 1
    local a, b = text:find('{........}', start)   
    
    while a do
        local t = text:sub(start, a - 1)
        if #t > 0 then
            designText(t)
            imgui.TextColored(color, t)
            imgui.SameLine(nil, 0)
        end

        local clr = text:sub(a + 1, b - 1)
        if clr:upper() == 'STANDART' then color = colors[col.Text]
        else
            clr = tonumber(clr, 16)
            if clr then
                local r = bit.band(bit.rshift(clr, 24), 0xFF)
                local g = bit.band(bit.rshift(clr, 16), 0xFF)
                local b = bit.band(bit.rshift(clr, 8), 0xFF)
                local a = bit.band(clr, 0xFF)
                color = imgui.ImVec4(r / 255, g / 255, b / 255, a / 255)
            end
        end

        start = b + 1
        a, b = text:find('{........}', start)
    end
    imgui.NewLine()
    if #text >= start then
        imgui.SameLine(nil, 0)
        designText(text:sub(start))
        imgui.TextColored(color, text:sub(start))
    end
end


function imgui.TextQuestion(text)
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(450)
        imgui.TextUnformatted(text)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end



function autokeys()
while true do wait(0)
if autokey1[0] then	
setVirtualKeyDown(u8:decode(str(buttonkey1)), true)
wait(timekey1[0]*1)
setVirtualKeyDown(u8:decode(str(buttonkey1)), false)
end
if autokey2[0] then	
setVirtualKeyDown(u8:decode(str(buttonkey2)), true)
wait(timekey2[0]*1)
setVirtualKeyDown(u8:decode(str(buttonkey2)), false)
setVirtualKeyDown(u8:decode(str(buttonkey3)), true)
wait(timekey3[0]*1)
setVirtualKeyDown(u8:decode(str(buttonkey3)), false)

end
end
end


function chestss()
    while true do
        wait(0)
        if chestonoff then
        if work then
            sampCloseCurrentDialogWithButton(0)
            wait(500)
            sampCloseCurrentDialogWithButton(0)
            sampAddChatMessage('[�hest] {FFFFFF}������ ��������� ���������.', 0xFFFF00)
            wait(500)
            sampSendChat('/mn')
            wait(500)
            sampCloseCurrentDialogWithButton(0)
            wait(500)   
            sampSendChat('/invent')
            wait(500)
            for i = 1, 6 do
                if not work then break end
                sampSendClickTextdraw(textdraw[i][1])
                wait(textdraw[i][3])
                sampSendClickTextdraw(textdraw[i][2])
                wait(textdraw[i][3])
            end
            wait(100)
            sampAddChatMessage('[�hest] {FFFFFF}������� ������ �� 1�.', 0xFFFF00)
            startTime = os.time() + 60 * 60 -- ������������� ������
            work = false
   
            startTime = os.time() + 60 * 60 -- ������������� ������ �� 5 �����
            while os.time() < startTime do
                wait(0)
                local timeRemaining = startTime - os.time()
                local minutes = math.floor(timeRemaining / 60)
                local seconds = timeRemaining % 60
               
                local timeString = string.format("%02d:%02d", minutes, seconds)
                renderFontDrawText(font,'Timer '..timeString, mainIni.main.chestposx, mainIni.main.chestposy, 0xFF00FF00, 0x90000000)
                
                end
                work = true -- ������������� ���� work � true ����� ���������� �������
            end
        end
    end
end


   
   function ev.onShowTextDraw(id, data)

       if work then
           if checkbox_standart[0] and data.modelId == 19918 then textdraw[1][1] = id  end
           if checkbox_platina[0] and data.modelId == 1353 then textdraw[2][1] = id  end
           if checkbox_mask[0] and data.modelId == 1733 then textdraw[3][1] = id  end
           if checkbox_donate[0] and data.modelId == 19613 then textdraw[4][1] = id  end
           if checkbox_tainik[0] and data.modelId == 2887 then textdraw[5][1] = id  end
           if checkbox_vice[0] and data.modelId == 1333 then textdraw[6][1] = id  end
           if data.text == 'USE' or data.text == '�C�O���O�A��' then 
               textdraw[1][2] = id + 1
               textdraw[2][2] = id + 1
               textdraw[3][2] = id + 1
               textdraw[4][2] = id + 1
               textdraw[5][2] = id + 1
               textdraw[6][2] = id + 1
           end
       end
    end 







function bind()
    while true do wait(0)

    if isKeyDown(161) and isKeyDown(49) then 
        activediaq = not activediaq
        if activediaq then
        if lavka[0] == false then 
        sampAddChatMessage('{FFFF00}[Binder] {FFFFFF}������ ����� {00FF00}��������.', -1)
        lavka[0] = true
        wait(200) 
        else
        if lavka[0] == true then
        sampAddChatMessage('{FFFF00}[Binder] {FFFFFF}������ ����� {FF0000}���������.', -1)   
        lavka[0] = false
        wait(200) 
    end
end
end
end
    if isKeyDown(161) and isKeyDown(50) then 
        activediaw = not activediaw
        if activediaw then 
        if radiuslavki[0] == false then  
        sampAddChatMessage('{FFFF00}[Binder] {FFFFFF}������ ����� ������� {00FF00}��������.', -1)
        radiuslavki[0] = true
        wait(200)
        else 
        if radiuslavki[0] == true then  
        sampAddChatMessage('{FFFF00}[Binder] {FFFFFF}������ ����� ������� {FF0000}���������.', -1)   
        radiuslavki[0] = false
        wait(200)
    end
end
end
end

    if isKeyDown(161) and isKeyDown(51) then
        activediae = not activediae
        if activediae then
        if clean[0] == false then  
        sampAddChatMessage('{FFFF00}[Binder] {FFFFFF}�������� ������� � �� {00FF00}��������.', -1)
        clean[0] = true 
        wait(200)
        else 
        if clean[0] == true then  
        sampAddChatMessage('{FFFF00}[Binder] {FFFFFF}�������� ������� � �� {FF0000}���������.', -1)   
        clean[0] = false 
        wait(200)
    end
end
end
end
   if isKeyDown(161) and isKeyDown(52) then  
    activediae = not activediae
        if activediae then
            wait(200)
    marketBool.now[0] = true
    else
        wait(200)
            marketBool.now[0] = false
        end
    end
    
    if isKeyDown(161) and isKeyDown(53) then 
        activediaw = not activediaw
        if activediaw then 
        wait(200)
        workbotton[0] = true 
        chestonoff = true
        work = true 
        end
    end

    if isKeyDown(161) and isKeyDown(54) then  
        thisScript():reload() 
    end
end
end



   function lavkirendor()
    while true do wait(0)
            if lavka[0] then		
                local input = sampGetInputInfoPtr()
                local input = getStructElement(input, 0x8, 4)
                local PosX = getStructElement(input, 0x8, 4)
                local PosY = getStructElement(input, 0xC, 4)
                local lavki = 0
                
                for id = 0, 2304 do
                    if sampIs3dTextDefined(id) then
                        local text, _, posX, posY, posZ, _, _, _, _ = sampGet3dTextInfoById(id)
                        if (math.floor(posZ) == 17 or math.floor(posZ) == 1820) and text == '' then
                            lavki = lavki + 1
                            if isPointOnScreen(posX, posY, posZ, nil) then
                                local pX, pY = convert3DCoordsToScreen(getCharCoordinates(PLAYER_PED))
                                local lX, lY = convert3DCoordsToScreen(posX, posY, posZ)
                                renderFontDrawText(font, '��������', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
                                renderDrawLine(pX, pY, lX, lY, 1, 0xFF52FF4D)
                                renderDrawPolygon(pX, pY, 10, 10, 10, 0, 0xFFFFFFFF)
                                renderDrawPolygon(lX, lY, 10, 10, 10, 0, 0xFFFFFFFF)  
                            end
                        end
                    end
                end
                local input = sampGetInputInfoPtr()
                local input = getStructElement(input, 0x8, 4)
                local PosX = getStructElement(input, 0x8, 4)
                local PosY = getStructElement(input, 0xC, 4)
                renderFontDrawText(font, '��������: '..lavki, mainIni.main.renderlavokx, mainIni.main.renderlavoky, 0xFFFF0000, 0x90000000)
                
        end
        end
    end       
  
    


function senddell()
    activedia = not activedia
    if activedia then 
    clean[0] = true
        
    sendTelegramNotification('�������� ������� � �� ��������.')
    else
    clean[0] = false
        
    sendTelegramNotification('�������� ������� � �� ���������.')
    end
end


function chestts()
    activedia = not activedia
    if activedia then 
    sendTelegramNotification('���� �������� �������� ��������.')
    sampSendClickTextdraw(65535)
    workbotton[0] = true 
    chestonoff = true
    work = true
    else
    sendTelegramNotification('���� �������� �������� ���������.')
    sampSendClickTextdraw(65535)
    startTime = os.time() 
    workbotton[0] = false 
    chestonoff = false
    work = false
    wait(10000)
    startTime = os.time() 
    end
end

function cleanr()
    while true do wait(0)
     if clean[0] then
    local removedPlayers = 0
            for i, v in ipairs(getAllChars()) do
                if doesCharExist(v) and i ~= 1 then
                    local _, id = sampGetPlayerIdByCharHandle(v)
                    if id ~= -1 then
                        removePlayer(id)
                        removedPlayers = removedPlayers + 1
                    end
                end
            end
            local removedVehicles = 0
            for i, v in ipairs(getAllVehicles()) do
                local res, id = sampGetVehicleIdByCarHandle(v)
                if res then
                    if (isCharInAnyCar(1) and storeCarCharIsInNoSave(1) ~= v) or not isCharInAnyCar(1) then
                        removeVehicle(id)
                        removedVehicles = removedVehicles + 1
                    end
                end
            end
            local result, ped = sampGetCharHandleBySampPlayerId(id)
            deleteChar(ped)
        end
    end 
    end
    
    function removePlayer(id)
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt16(bs, id)
        raknetEmulRpcReceiveBitStream(163, bs)
        raknetDeleteBitStream(bs)
    end
    
    function removeVehicle(id)
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt16(bs, id)
        raknetEmulRpcReceiveBitStream(165, bs)
        raknetDeleteBitStream(bs)
    end




function eat()
 while true do wait(0)
if autoeat[0] then
      if ComboTest[0] == 0 then
        sampSendChat('/jmeat')
      elseif ComboTest[0] == 1 then
        sampSendChat('/meatbag')
      end
	  wait(SliderOne[0]*60000)
    end
  end
  end



------------------------------------------------------------------------------------------------------------------------------------------------------------

local updateid -- ID ���������� ��������� ��� ���� ����� �� ���� �����

function threadHandle(runner, url, args, resolve, reject)
	local t = runner(url, args)
	local r = t:get(0)
	while not r do
		r = t:get(0)
		wait(0)
	end
	local status = t:status()
	if status == 'completed' then
		local ok, result = r[1], r[2]
		if ok then resolve(result) else reject(result) end
	elseif err then
		reject(err)
	elseif status == 'canceled' then
		reject(status)
	end
	t:cancel(0)
end



function requestRunner()
	return effil.thread(function(u, a)
		local https = require 'ssl.https'
		local ok, result = pcall(https.request, u, a)
		if ok then
			return {true, result}
		else
			return {false, result}
		end
	end)
end

function async_http_request(url, args, resolve, reject)
	local runner = requestRunner()
	if not reject then reject = function() end end
	lua_thread.create(function()
		threadHandle(runner, url, args, resolve, reject)
	end)
end

function encodeUrl(str)
	for c in str:gmatch('[%c%p%s]') do
		if c ~= '%' then
			local find = str:find(c, 1, true)
			if find then
				local char = str:sub(find, find)
				str = str:gsub(string.format('%%%s', char), ('%%%%%02X'):format(char:byte()))
			end
		end
	end
	return u8(str)
end






function sendTelegramNotification(msg) -- ������� ��� �������� ��������� �����
	msg = msg:gsub('{......}', '') --��� ���� ������� ����
	msg = encodeUrl(msg) -- �� ��� �� ���������� ������
	async_http_request('https://api.telegram.org/bot' .. u8:decode(str(token)) .. '/sendMessage?chat_id=' .. u8:decode(str(chat_id)) .. '&text='..msg,'', function(result) end) -- � ��� ��� ��������
end



function get_telegram_updates() -- ������� ��������� ��������� �� �����
    while not updateid do wait(1) end -- ���� ���� �� ������ ��������� ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1' -- ������� ������
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end



function processing_telegram_messages(result) -- ������� ���������� ���� ��� �������� ���
    local proc_result, proc_table = pcall(decodeJson, result)
        if proc_result and proc_table and proc_table.ok then

        -- ���� �� ��������� ��� �� �����
        local proc_table = decodeJson(result)
        if proc_table.ok then
            if #proc_table.result > 0 then
                local res_table = proc_table.result[1]
                if res_table then
                    if res_table.update_id ~= updateid then
                        updateid = res_table.update_id
                        local message_from_user = res_table.message.text
						user_idtg = res_table.message.from.id

                         if message_from_user then
                            -- � ��� ���� ��� �������� ����� �� �������
                            local text = u8:decode(message_from_user) .. ' ' --��������� � ����� ������ ���� �� ��������� ���. ��������� � ���������(���� ���� !q �� ��������� ��� !qq)
                           

                                if text:match('^/stats') then
                                telegrams()
								elseif text:match('^/pcoff') then
								sendTelegramNotification('��������� ����� ������������� ��������')
                                pcoffs()
								elseif text:match('^/rec') then
								sendTelegramNotification('��������������� � ������� 15 ���')
                                rec()
                                elseif text:match('^/nickrecon') then
								sendTelegramNotification('��������������� � ������� 5 ���')
                                nickrecon()
								elseif text:match('^/status') then
								sendStatusTg()
                                elseif text:match('^/send') then
                                local argq = text:gsub('/send ','',1)
                                sampSendChat(argq)


                                elseif text:match('^/diolog') then
                                    sendDialog()
                                

                                elseif text:match('^/dell') then
                                senddell()

                                elseif text:match('^/monitoroff') then
                                os.execute([[ "powershell nircmd.exe monitor off" ]])
                                
                              
                                
                                elseif text:match('^/chest') then
                                chestts()

                                elseif text:match('^/killdiolog') then
                                sampCloseCurrentDialogWithButton(0)
                                wait(200)
                                sampCloseCurrentDialogWithButton(0)
                                sendTelegramNotification('�������� ���� ��������')
              
                                elseif text:match('^/reload') then
                                    thisScript():reload()
                                sendTelegramNotification('������ ���������������')


                                elseif text:match('^/money') then
                                moneya = getPlayerMoney()
                                sendTelegramNotification('��������: $'..moneya)
                                

                         
                                elseif text:match('^/version') then
                                sendTelegramNotification('������ ������� v'..thisScript().version)

                                
								elseif text:match('^/help') then
								sendTelegramNotification('%E2%9D%97�������%E2%9D%97\n\n/stats -- ���������� ��������.\n\n/money -- ������ �� �����.\n\n/pc�ff -- ���������� ��.\n\n/re� -- ��������� �� ������ � ��������� 5 ���.\n\n/nickrecon -- ��������� �� ������ � ��������� �����.\n\n/monitoroff -- ��������� �������(NirCmd)\n\n/status -- ������ �������.\n\n/di�log -- �������� ��� ��������� �������� �������� � TG.\n\n/killdiol�g -- �������� ���� ��������\n\n/send -- �������� ��������� � ���.\n\n/d�ll --�������� ��� ��������� �������� ������� � ��.\n\n/chest -- ��������� ���� �������� ��������.\n\n/version -- ������ �������.\n\n/rel�ad -- ������������� ������.')	 
                                else -- ���� �� �� �������� �� ���� �� ������ ����, ������� ���������
                                sendTelegramNotification('����������� �������!')
                           
                            
                        end
                    end
                end
            end
        end
    end
end
end



function getLastUpdate() -- ��� �� �������� ��������� ID ���������, ���� �� � ��� � ���� ����� ��������� ������ � chat_id, �������� ��� ������� ��� ���� ���� �������� ��������� ���������
    async_http_request('https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1','',function(result)
        if result then
            local proc_table = decodeJson(result)
            if proc_table.ok then
                if #proc_table.result > 0 then
                    local res_table = proc_table.result[1]
                    if res_table then
                        updateid = res_table.update_id
                    end
                else
                    updateid = 1 -- ��� ������� �������� 1, ���� ������� ����� ������
                end
            end
        end
    end)
end
	
local bank_check = false
local payday_notification_str = '%E2%9D%97__________���������� ���__________%E2%9D%97\n'
local function collectAndSendPayDayData(text)
    local ptrs = {
        "������� ����� � �����: %$[%d%.]+",
        "������� ����� �� ��������: %$[%d%.]+",
        "����� ���������� �����: %$[%d%.]+",
        "������� � �����: VC%$[%d%.]+",
        "����� � �������: VC%$[%d%.]+",
        "������� ����� � �����: VC%$[%d%.]+",
        "������� ����� �� ��������: VC%$[%d%.]+"
    }

    local text = text:gsub("{%x+}", "")
    for _, v in ipairs(ptrs) do
        if text:find(v) then
            payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        end
    end

    if text:find("������ �� �����(.+): (.+)") then
        payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        if bank_check then
            sendTelegramNotification(("%s"):format(payday_notification_str)) -- copy string
            --sendTelegramNotification('������� ����� '..counter.. ' ��������')
            payday_notification_str = '%E2%9D%97__________���������� ���__________%E2%9D%97\n'
        end
        bank_check = false
    end
end







function sampev.onServerMessage(color, text)
    if text:find('���������� ���') then bank_check = true end
    if bank_check then collectAndSendPayDayData(text) end

    local message = ""

    if text:find('^%[����������%] %{ffffff%}�� ������������ ������ � ��������� � ��������') and color == 1941201407 then
        local drop_starter_donate = text:match('^%[����������%] %{ffffff%}�� ������������ ������ � ��������� � �������� (.+)!')
        counter = counter + 1
        message = message .. drop_starter_donate .. "\n"
    end
    
    if text:find('^%[����������%] %{ffffff%}�� ������������ ���������� ������ � ��������� � ��������') and color == 1941201407 then
        local drop_platinum = text:match('^%[����������%] %{ffffff%}�� ������������ ���������� ������ � ��������� � �������� (.+)!')
        counter = counter + 1
        message = message .. drop_platinum .. "\n"
    end 
    
    if text:find('^%[����������%] %{ffffff%}�� ������������ ������ ����� ����� � ��������') and color == 1941201407 then
        local drop_elon_musk = text:match('^%[����������%] %{ffffff%}�� ������������ ������ ����� ����� � �������� (.+)!')
        counter = counter + 1
        message = message .. drop_elon_musk .. "\n"
    end
    
    if (text:find('^�� ������� ������ ��� �������!') or text:find('^�� ������� ������ Vice City!')) and color == 1118842111 then
    elseif text:find('^%[����������%] %{ffffff%}��������: (.+) � (.+)!') and color == 1941201407 then
        counter = counter + 1
        local drop_ls_vc_1, drop_ls_vc_2 = text:match('^%[����������%] %{ffffff%}��������: (.+) � (.+)!')
        message = message .. drop_ls_vc_1 .. "\n" .. drop_ls_vc_2 .. "\n"
    end
    
    sendTelegramNotification(message)
   
    
    if text:find('^%[������%] %{ffffff%}����� ����� �������� ������������� ��� �� ������!') and color == -1104335361 then
        local text = '����� ����� �������� ������������� ��� �� ������!'
        sendTelegramNotification(''..text.. '\n'..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))  
    end

    local hookMarket = {
		{text = '^%s*(.+) ����� � ��� (.+), �� ��������(.+)$(.+) �� ������� %(�������� %d+ �������%(�%)%)$', color = -1347440641, key = 2},
		{text = '^%s*�� ������� ������� (.+) �������� (.+), � ������� ��������(.+)$(.+) %(�������� %d+ �������%(�%)%)$', color = -65281, key = 2},
		{text = '^%s*�� ������ (.+) � ������ (.+) ��(.+)$(.+)', color = -1347440641, key = 3},
		{text = '^%s*�� ������� ������ (.+) � (.+) ��(.+)$(.+)', color = -65281, key = 3}
	}

	for k, v in ipairs(hookMarket) do
		if string.find(text, v['text']) and v['color'] == color then
			local args = splitArguments({text:match(v['text'])}, text:find('����� � ���'))
			local textLog = getTypeMessageMarket(text, args)

            sendTelegramNotification(''..textLog.. '\n\n'..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
			

			if #marketShop >= stroki[0]  then marketShop = {} end
			table.insert(marketShop, textLog)


			end
		end


        if text:match("%a+_%a+%[%d+%]:    {......}%d+$") then
            local number = text:match("%a+_%a+%[%d+%]:    {......}(%d+)$")
            lua_thread.create(function()
                sampAddChatMessage('Calling: {aa0000}'..number, -1)
                wait(500)
                sampSendChat("/call " .. number)
            end)
            return false
        end
    
        if text:find('���� ��������� ��������������� �� ������ {......}(.+)') then
            local nikc = text:match('���� ��������� ��������������� �� ������ {......}(.+)')
            local result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            if sampGetPlayerNickname(id) == nikc then
                sampSendChat("/lock")
            end
            end
	
    if text:find('{FFFFFF}� ��� ���� 3 ������, ����� ��������� �����, ����� ������ ������ ����� ��������.') then
        lavka = new.bool(false) 
        radiuslavki = new.bool(false)
        marketBool.now[0] = true
        local text = '[����������] �� ������ �����!'
        sendTelegramNotification(''..text.. '\n\n'..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
        marketShop = {}
        if autoclean[0] then
            clean = new.bool(true)
            radiuslavki = new.bool(false)
            sampProcessChatInput('/plt')
            
           
    end    
end

local hookActionsShop = {
    '^%s*%[����������%] {FFFFFF}�� ���������� �� ������ �����!',
    '^%s*%[����������%] {FFFFFF}�� ����� �����!',
    '^%s*%[����������%] {FFFFFF}���� ����� ���� �������, ��%-�� ���� ��� �� � ��������!'
}

for k, v in ipairs(hookActionsShop) do
    if text:find(v) then
        marketBool.now[0] = false       
        sendTelegramNotification(''..text.. '\n\n'..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
        end
    end
end





function splitArguments(array, key)
	return {
		['name'] = (key and array[1] or array[2]),
		['item'] = (key and array[2] or array[1]),
		['ViceCity'] = array[3],
		['money'] = stringToCount(array[4])
	}
end

function getTypeMessageMarket(text, args)
	local array = {
		['����� � ���'] = '%s %s ����� "%s" ��%s$%s',
		['�� ������'] = '%s %s ������ "%s" ��%s$%s',
		['�� ������� �������'] = '%s [����� �����] %s ����� "%s" ��%s$%s',
		['�� ������� ������'] = '%s [����� �����] %s ������ "%s" ��%s$%s'
	}
	for k, v in pairs(array) do
		if text:find(k) then return string.format(v, os.date('[%H:%M:%S]'), args['name'], args['item'], args['ViceCity'], money_separator(args['money'])) end
	end
end

function stringToCount(text)
	local count = ''
	for line in text:gmatch('%d') do
		count = count .. line
	end
	return tonumber(count)
end

function money_separator(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

---[����������] {ffffff}�� ������������ ������ � ��������� � �������� ���������� �������!



function telegrams()
if cmd[0] then
diolog[0] = true
sampSendChat('/stats')
wait(500)
diolog[0] = false
sampCloseCurrentDialogWithButton(0)
end
end


function pcoffs()
if cmd[0] then
os.execute('shutdown /h')
end
end

function rec()
if cmd[0] then
wait(1000)
sampDisconnectWithReason(quit)
wait(5000)
sampSetGamestate(1)
end
end

function nickrecon()
    if cmd[0] then
    wait(1000)
    sampDisconnectWithReason(quit)
    wait(200)
    sampSetLocalPlayerName(mainIni.main.nickrecons)
    wait(5000)
    sampConnectToServer(mainIni.main.serverrecon, 7777)
    end
    end

    

function getOnline()
	local countvers = 0
	for i = 0, 999 do
		if sampIsPlayerConnected(i) then
			countvers = countvers + 1
		end
	end
	return countvers
end

function sendStatusTg()
	local response = ''
	if sampGetCurrentServerName() then
		response = response .. 'Server: ' .. sampGetCurrentServerName() .. '\n'
	end
	response = response .. 'Online: ' .. getOnline() .. '\n'
	sendTelegramNotification(response)
end




function sendDialog()
	activedia = not activedia
	if activedia then 
        diolog[0] = true
        mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
    
        sendTelegramNotification('�������� �������� ��������.')
	else
        diolog[0] = false
        mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
    
        sendTelegramNotification('�������� �������� ���������.')
	end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------
local sampev = require 'lib.samp.events'

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
if text:find('�����!') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
	end

    if dialogId == 25194 then
        sampSendDialogResponse(dialogId,1,1,nil) 
        return false

    end

    if dialogId == 26012 then
        sampSendDialogResponse(dialogId,1,1,nil) 
        sampSendChat('/lock')
        return false

    end

    if dialogId == 26558 then
        if checkboxkodbank[0] == true then
        sampSendDialogResponse(dialogId, 1, nil); return false 
        end
    end

    if dialogId == 26559 then
        if checkboxkodbank[0] == true then
            sampSendDialogResponse(dialogId, 1, nil, mainIni.main.kodbank); return false   
        end
    end


    if dialogId == 25202 then
        if checkboxkodsklad[0] == true then
        sampSendDialogResponse(dialogId, 1, nil, mainIni.main.kodsklad); return false     
        end
    end


    if dialogId == 26827 then  
        if skipdiolog[0] then
        sampSendDialogResponse(dialogId, 0, 0, nil); return false         
    end
end


    if dialogId == 25526 then
        if skipdiolog[0] then
        sampSendDialogResponse(dialogId, 1, 1, nil); return false      
    end
end


    if text:find('�� ���� ������ ��� �� �������') then 
        if skipdiolog[0] then
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
end

    if text:find('�� ������� ������� �') then 
        if skipdiolog[0] then
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
end

    if text:find('�� ���� ������ ��� �� �������') then 
        if skipdiolog[0] then
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
end

   
    
--26558      
--26559    
    
if settingslavka[0] then
    if title:find ('{BFBBBA}�������� ��� ����� �����') then
		sampSendDialogResponse(dialogId,1,1,nil)
        return false
	end

   if text:find('{FFFFFF}������� �������� ����� �����') then
		sampSendDialogResponse(dialogId, 1, nil, mainIni.main.namelavkas); return false
	end

    if title == '{BFBBBA}�������� ����' and text:find('{E94E4E}|||||||||||||||||||') then
    sampSendDialogResponse(dialogId,1,15,nil)
    return false
    end
end



if diolog[0] then
if style == 1 or style == 3 then
			sendTelegramNotification('' .. title .. '\n' .. text .. '\n\n[______________]\n\n[' .. button1 .. '] | [' .. button2 .. ']' )
		else
			if style == 0 then
				sendTelegramNotification('' .. title .. '\n' .. text .. '\n\n[' .. button1 .. '] | [' .. button2 .. ']' )
			else
				sendTelegramNotification('' .. title .. '\n' .. text .. '\n\n[' .. button1 .. '] | [' .. button2 .. ']' )

end
end
end
end

local on = require 'lib.samp.events'

function on.onSendSpawn()
sendTelegramNotification('�������� ��� ����� '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))..' ��� ���������.')

end

function convertDecimalToRGBA(u32, alpha)
	local a = bit.band(bit.rshift(u32, 24), 0xFF) / 0xFF
	local r = bit.band(bit.rshift(u32, 16), 0xFF) / 0xFF
	local g = bit.band(bit.rshift(u32, 8), 0xFF) / 0xFF
	local b = bit.band(u32, 0xFF) / 0xFF
	return imgui.ImVec4(r, g, b, a * (alpha or 1.0))
end

function getTheme()
	jsonConfig['script'].scriptColor = {scriptColor[0], scriptColor[1], scriptColor[2]}
	json('Config.json'):save(jsonConfig)

	local dec = imgui.GetColorU32Vec4(imgui.ImVec4(scriptColor[0], scriptColor[1], scriptColor[2], 1.0))
	local color = bit.tohex(bit.bswap(dec))
	local hex = ('%s'):format(color:sub(1, #color - 2))
	theme(tonumber('0x' .. hex), 1.5, true)
end

local function loadIconicFont(fontSize)
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    local iconRanges = imgui.new.ImWchar[3](ti.min_range, ti.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(ti.get_font_data_base85(), fontSize, config, iconRanges)
end


imgui.OnInitialize(function()
    imgui.OnInitialize(function()
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\123.png') then -- ������� ����������� �������� � ��������� example.png � ����� moonloader/resource/
            imhandle = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\123.png') -- ���� �������, �� ���������� � ���������� ����� ��������
        end
    end)

	imgui.GetIO().IniFilename = nil
	getTheme()
    
    loadIconicFont(26)
    imgui.GetIO().IniFilename = nil

	fonts = {}
	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()

	-->> Default Font

	-->> Other Fonts
    for k, v in ipairs({15, 18, 25, 30}) do
		fonts[v] = imgui.GetIO().Fonts:AddFontFromFileTTF(u8(getWorkingDirectory() .. '/ReplaceWindow/EagleSans-Regular.ttf'), v, nil, glyph_ranges)
	end

	-->> Logo
	logo = imgui.CreateTextureFromFile(u8(getWorkingDirectory() .. '/ReplaceWindow/ReplaceWindow.png'))
end)

function theme(color, chroma_multiplier, accurate_shades)
	imgui.SwitchContext()
	palette = monet.buildColors(color, chroma_multiplier, accurate_shades)
	local style = imgui.GetStyle()
	local colors = style.Colors
	local flags = imgui.Col

	imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
	imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
	imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
	imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(5, 5)
	imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)

	imgui.GetStyle().IndentSpacing = 20
	imgui.GetStyle().ScrollbarSize = 12.5
	imgui.GetStyle().GrabMinSize = 10

	imgui.GetStyle().WindowBorderSize = 0
	imgui.GetStyle().ChildBorderSize = 1
	imgui.GetStyle().PopupBorderSize = 1
	imgui.GetStyle().FrameBorderSize = 0
	imgui.GetStyle().TabBorderSize = 0

	imgui.GetStyle().WindowRounding = 3
	imgui.GetStyle().ChildRounding = 3
	imgui.GetStyle().PopupRounding = 3
	imgui.GetStyle().FrameRounding = 3
	imgui.GetStyle().ScrollbarRounding = 1.5
	imgui.GetStyle().GrabRounding = 3
	imgui.GetStyle().TabRounding = 3

	imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.50, 0.50)

	colors[flags.Text] = convertDecimalToRGBA(palette.neutral1.color_50)
	colors[flags.TextDisabled] = convertDecimalToRGBA(palette.neutral1.color_400)
	colors[flags.WindowBg] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.ChildBg] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.PopupBg] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.Border] = convertDecimalToRGBA(palette.accent2.color_300)
	colors[flags.BorderShadow] = imgui.ImVec4(0, 0, 0, 0)
	colors[flags.FrameBg] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.FrameBgHovered] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.FrameBgActive] = convertDecimalToRGBA(palette.accent1.color_400)
	colors[flags.TitleBgActive] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.ScrollbarBg] = convertDecimalToRGBA(palette.accent2.color_800)
	colors[flags.ScrollbarGrab] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.ScrollbarGrabHovered] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.ScrollbarGrabActive] = convertDecimalToRGBA(palette.accent1.color_400)
	colors[flags.CheckMark] = convertDecimalToRGBA(palette.neutral1.color_50)
	colors[flags.SliderGrab] = convertDecimalToRGBA(palette.accent2.color_400)
	colors[flags.SliderGrabActive] = convertDecimalToRGBA(palette.accent2.color_300)
	colors[flags.Button] = convertDecimalToRGBA(palette.accent2.color_700)
	colors[flags.ButtonHovered] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.ButtonActive] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.Header] = convertDecimalToRGBA(palette.accent1.color_800)
	colors[flags.HeaderHovered] = convertDecimalToRGBA(palette.accent1.color_700)
	colors[flags.HeaderActive] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.Separator] = convertDecimalToRGBA(palette.accent2.color_200)
	colors[flags.SeparatorHovered] = convertDecimalToRGBA(palette.accent2.color_100)
	colors[flags.SeparatorActive] = convertDecimalToRGBA(palette.accent2.color_50)
	colors[flags.ResizeGrip] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.ResizeGripHovered] = convertDecimalToRGBA(palette.accent2.color_800)
	colors[flags.ResizeGripActive] = convertDecimalToRGBA(palette.accent2.color_700)
	colors[flags.Tab] = convertDecimalToRGBA(palette.accent1.color_700)
	colors[flags.TabHovered] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.TabActive] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.PlotLines] = convertDecimalToRGBA(palette.accent3.color_300)
	colors[flags.PlotLinesHovered] = convertDecimalToRGBA(palette.accent3.color_50)
	colors[flags.PlotHistogram] = convertDecimalToRGBA(palette.accent3.color_300)
	colors[flags.PlotHistogramHovered] = convertDecimalToRGBA(palette.accent3.color_50)
	colors[flags.DragDropTarget] = convertDecimalToRGBA(palette.accent1.color_100)
	colors[flags.ModalWindowDimBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.95)
end


