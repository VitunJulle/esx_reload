ESX = nil
lataus = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()

  while true do
    Wait(0)

    ped = GetPlayerPed(-1)
    hash = GetSelectedPedWeapon(GetPlayerPed(-1))
    local playerPedAmmo = GetAmmoInPedWeapon(ped, hash)
    local maxWeaponAmmo = GetMaxAmmoInClip(ped, hash, 1)

    if playerPedAmmo >= maxWeaponAmmo then
      SetPedAmmo(GetPlayerPed(-1), hash, maxWeaponAmmo)
    end

    if IsControlJustReleased(1, 45) then --press R to use clip
      if IsPedArmed(ped, 4) then
        if hash~=nil then
        if playerPedAmmo >= maxWeaponAmmo then
          ESX.ShowNotification('Sinulla on täysi lipas aseessasi') -- FIN
          --ESX.ShowNotification('You have already full clip on weapon') -- ENG
        elseif playerPedAmmo < maxWeaponAmmo then
          TriggerServerEvent('esx_reload:clip')
          DisablePlayerFiring(GetPlayerPed(-1), true)
        end
      end
      end
    end
  end
end)

RegisterNetEvent('esx_reload:clipreload')
AddEventHandler('esx_reload:clipreload', function()
  ped = GetPlayerPed(-1)
  hash = GetSelectedPedWeapon(GetPlayerPed(-1))
  local maxWeaponAmmo = GetMaxAmmoInClip(ped, hash, 1)

  TriggerServerEvent('esx_reload:remove')
  SetPedAmmo(GetPlayerPed(-1), hash, maxWeaponAmmo)
  ESX.ShowNotification("~r~Käytit lippaan aseen") -- FIN
  --ESX.ShowNotification("~r~You used a clip") -- ENG
  MakePedReload(GetPlayerPed(-1))
  lataus = false
end)

-- automaattinen lataus -- automatic reload when weapon ammo = 0
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local ped = GetPlayerPed(-1)
    local hash = GetSelectedPedWeapon(GetPlayerPed(-1))

    if lataus == false then
      if IsPedArmed(ped, 4) then
        if hash~=nil then
          if GetAmmoInPedWeapon(ped, hash) == 0 then
            lataus = true
            SetPedCanSwitchWeapon(GetPlayerPed(-1), false)
            TriggerServerEvent('esx_reload:clip')
          end
        end
      end
    end
  end
end)