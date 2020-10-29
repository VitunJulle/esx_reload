ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_reload:clip')
AddEventHandler('esx_reload:clip', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem('clip').count >= 1 then
	  TriggerClientEvent('esx_reload:clipreload', source)
	  xPlayer.removeInventoryItem('clip', 1)
	else
		TriggerClientEvent('esx:showNotification', source, ('Sinulla ei ole lippaita mukana')) -- FIN
		--TriggerClientEvent('esx:showNotification', source, ('You don't have any clips')) -- ENG
	end
end)