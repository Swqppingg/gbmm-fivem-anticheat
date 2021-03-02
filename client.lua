function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end


local function collectAndSendResourceList()
	local resourceList = {}
    for i=0,GetNumResources()-1 do
		resourceList[i+1] = GetResourceByFindIndex(i)
		Wait(500)
	end
	Wait(5000)
    TriggerServerEvent("gbmm:checkresources", resourceList)
end
if Config.StopUnauthorizedResources then
CreateThread(function()
    while true do
	    Wait(10000)
		collectAndSendResourceList()      
    end
end)
end 

--Remove cage objects
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		local handle, object = FindFirstObject()
		local finished = false
		repeat
			Wait(1)
			if IsEntityAttached(object) and DoesEntityExist(object) then
				if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
					ReqAndDelete(object, true)
				end
			end
			for i=1,#Config.CageObjs do
				if GetEntityModel(object) == GetHashKey(Config.CageObjs[i]) then
					ReqAndDelete(object, false)
				end
			end
			finished, object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end
end)


function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(Config.CarsBL) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end