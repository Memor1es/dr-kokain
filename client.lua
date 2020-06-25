ESX = nil
local incooking = false
local paketliyor = false
local ped = PlayerPedId()

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
      end
end)


RegisterNetEvent('dr:pisirmeclient')
AddEventHandler('dr:pisirmeclient', function()
	if incooking then
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BBQ', 0, true)
    TriggerEvent("mythic_progbar:client:progress", {name = "kofte_hazir", duration = Config.pisirmezamani * 1000, label = "Pişiyorsun..."})
	Citizen.Wait(Config.pisirmezamani * 1000)
	incooking = false 

	TriggerServerEvent('dr:pisirme3')
	exports['mythic_notify']:SendAlert('success', 'Başarıyla işi bitirdin.', 4000)
	ClearPedTasksImmediately(ped)
end
end)

RegisterNetEvent('dr:pisirmeclientfail')
AddEventHandler('dr:pisirmeclientfail', function()
	if incooking then
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BBQ', 0, true)
    TriggerEvent("mythic_progbar:client:progress", {name = "kofte_hazir", duration = Config.pisirmezamani * 1000, label = "Pişiyorsun..."})
	Citizen.Wait(Config.pisirmezamani * 1000)
	incooking = false 
	ClearPedTasksImmediately(ped)
	exports['mythic_notify']:SendAlert('error', 'Bu nasıl mal pişirmek kardeşim bütün malı ziyan ettin.', 4000)
	end
end)

RegisterNetEvent('dr:islemeclient')
AddEventHandler('dr:islemeclient', function()
	if paketliyor then
		local dict = 'mp_arresting'
		Citizen.Wait(500)
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
    	end
    	TaskPlayAnim(ped, dict, 'a_uncuff', 8.0, -8.0, 5000, 1, 0, false, false, false)
    	TriggerEvent("mythic_progbar:client:progress", {name = "mal_bir", duration = Config.birlestirmezamani * 1000, label = "Malı Ayıklayıp paketliyorsun.."})
		Citizen.Wait(Config.birlestirmezamani * 1000)
		paketliyor = false
    	TriggerServerEvent('dr:islemeprice')
    	exports['mythic_notify']:SendAlert('inform', 'Başarıyla kokain yaptın', 5000)
		ClearPedTasksImmediately(ped)
	end
end)

RegisterNetEvent('dr:islemeclientfail')
AddEventHandler('dr:islemeclientfail', function()
	if paketliyor then
		local dict = 'mp_arresting'
		Citizen.Wait(500)
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
    	end
    	TaskPlayAnim(ped, dict, 'a_uncuff', 8.0, -8.0, 5000, 1, 0, false, false, false)
    	TriggerEvent("mythic_progbar:client:progress", {name = "mal_bir", duration = Config.birlestirmezamani * 1000, label = "Malı Ayıklayıp paketliyorsun.."})
		Citizen.Wait(Config.birlestirmezamani * 1000)
		paketliyor = false
    	exports['mythic_notify']:SendAlert('error', 'Huniyle bile paketleyemedin..', 5000)
		ClearPedTasksImmediately(ped)
	end
end)

RegisterNetEvent('dr:islemeclienthuni')
AddEventHandler('dr:islemeclienthuni', function()
	if paketliyor then
		local dict = 'mp_arresting'
		Citizen.Wait(500)
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
    	end
    	TaskPlayAnim(ped, dict, 'a_uncuff', 8.0, -8.0, 5000, 1, 0, false, false, false)
    	TriggerEvent("mythic_progbar:client:progress", {name = "mal_bir", duration = Config.birlestirmezamani * 1000, label = "Malı Ayıklayıp paketliyorsun.."})
		Citizen.Wait(Config.birlestirmezamani * 1000)
		paketliyor = false
    	exports['mythic_notify']:SendAlert('error', 'Huni olmadan mal paketlemeyi denedin. Gitti bütün mal', 5000)
		ClearPedTasksImmediately(ped)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)
	while true do
		local sleepThread = 500
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local dstCheck = GetDistanceBetweenCoords(pedCoords, Config.pisirme["x"], Config.pisirme["y"], Config.pisirme["z"], true)
		if dstCheck <= 5.0 then
			sleepThread = 5
			local text = "Pişirme Noktası"
			if dstCheck <= 0.65 then
				text = "Pişirmeye başlamak için [~g~E~s~] Tuşuna bas."
				if IsControlJustPressed(0, 38) then
					if not incooking then
					TriggerServerEvent('dr:pisirme2')
					incooking = true
					end
				end
			end
			ESX.Game.Utils.DrawText3D(Config.pisirme, text, 0.6)
		end
		if dstCheck >= 7.0 then
			Citizen.Wait(5000)
		else 
			Citizen.Wait(5)
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local dstCheck = GetDistanceBetweenCoords(pedCoords, Config.isleme["x"], Config.isleme["y"], Config.isleme["z"], true)
		if dstCheck <= 5.0 then
			sleepThread = 5
			local text = "Paketleme Noktası"
			if dstCheck <= 0.65 then
				text = "Paketlemeye başlamak için [~g~E~s~] Tuşuna bas."
				if IsControlJustPressed(0, 38) then
					if not paketliyor then
						TriggerServerEvent('dr:isleme2')
						paketliyor = true
					end
				end
			end
			ESX.Game.Utils.DrawText3D(Config.isleme, text, 0.6)
		end
		if dstCheck >= 7.0 then
			Citizen.Wait(5000)
		else 
			Citizen.Wait(5)
		end
	end
end)