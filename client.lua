ped = PlayerPedID()

Citizen.CreateThread(function()
	SetPlayerHealthRechargeMultiplier(ped, 0.0)
       	SetPedSuffersCriticalHits(ped, true)
	
	if IsControlPressed(0, 25) then 
		DisableControlAction(0, 22, true) -- Combat Rolling
	end
		
	local isGunASniper = false
	while true do
		Citizen.Wait(0)
		local selectedGun = GetSelectedPedWeapon(ped)

		if selectedGun == 100416529 then -- Sniper Rifle
			isGunASniper = true
		elseif selectedGun == 205991906 then -- Heavy Sniper
			isGunASniper = true
		elseif selectedGun == -3342088282 then -- Marksman Rifle
			isGunASniper = true
		else
			isGunASniper = false
		end

		if not isGunASniper then
			HideHudComponentThisFrame(14)
		end
	end

	if not animatdictloaded then
		Citizen.CreateThread(function()
			while true do
			Wait(1)
	RequestAnimDict('move_m@_idles@shake_off')
		animatdictloaded = true
			while not HasAnimDictLoaded('move_m@_idles@shake_off') do
   				 Wait(150)
			end
			end
		end)
	end
end)

RegisterCommand('heal', function()
		
local veh = GetVehiclePedIsIn(ped,false)
if IsPedInVehicle(ped, veh, false) then
Notif("~r~Player cannot heal in Vehicle!")
else
if GetEntityHealth(ped) >> 200 then	
	TaskPlayAnim(ped, "move_m@_idles@shake_off", "shakeoff_1", 8.0, 1.0, 1, 2, 0, false,false,false)
	--exports['pogressBar']:drawBar(5000, "Healing Player") -- Uncomment this line if pogressbar is installed
	FreezeEntityPosition(ped, true)
	Citizen.Wait(5000)
	FreezeEntityPosition(ped, false)
	SetEntityHealth(ped, 200)
	Notif("~y~Player has been healed!")
	print("player healed") 
else 
Notif("~r~The Player is already at Max Health")
end
end
end, false)


function Notif( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

RegisterCommand('armor', function()

local veh = GetVehiclePedIsIn(ped,false)
if IsPedInVehicle(ped, veh, false) then
Notif("~r~Player cannot armor up in Vehicle!")
else
if GetEntityHealth(ped) >> 200 then	
	TaskPlayAnim(ped, "move_m@_idles@shake_off", "shakeoff_1", 8.0, 1.0, 1, 2, 0, false,false,false)
	--exports['pogressBar']:drawBar(7000, "Healing Player") -- Uncomment this line if pogressbar is installed
	FreezeEntityPosition(ped, true)
	Citizen.Wait(5000)
	FreezeEntityPosition(ped, false)
	SetEntityArmor(ped, 200)
	Notif("~y~Player has been Armored!")
	print("player armored") 
else 
Notif("~r~The Player is already at Max Armor")
end
end
end, false)
