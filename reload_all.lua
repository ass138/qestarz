script_name('ML-ReloadAll')
script_author('FYP')
script_description('Press Ctrl + R to reload all lua scripts. Also can be used to load new added scripts')
if script_properties then
	script_properties('work-in-pause', 'forced-reloading-only')
end


--- Mainw
function main()
  while true do
	wait(40)
	if isKeyDown(18) and isKeyDown(81) then -- ALT+Q
		while isKeyDown(18) and isKeyDown(81) do wait(80) end
		reloadScripts()
	end
  end
end
