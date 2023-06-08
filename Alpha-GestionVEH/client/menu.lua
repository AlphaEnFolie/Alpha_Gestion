

FrxESX = nil 
engine = true
statusengine = "~y~En Marche"
local BaseSpeedLimit, ActualSpeedLimit =1, " ~r~Indéfinie"
local LimitList, LimitSpeedList = {}, {}


Citizen.CreateThread(function()
	while FrxESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) FrxESX = obj end)
		Citizen.Wait(1000)
		PlayerData = FrxESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


function LoadLimitList()
    LimitList = LimitSpeedList
end



CreateThread(function()
    local tempnumber = 0
    while tempnumber ~= 200 do
        Wait(0)
        tempnumber = tempnumber + 1
        LimitSpeedList[tempnumber] = {Name = tempnumber, Value = tempnumber}
    end

    LoadLimitList()

    while true do 
        Wait(500)

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)
        if engine then
            statusengine = "~y~En Marche"
            SetVehicleEngineOn(vehicle, true, false, true)
        else
            statusengine = "~r~En Pause"
            SetVehicleEngineOn(vehicle, false, false, true)
        end
    end
end)

GestionMainMenu = RageUI.CreateMenu("~y~G~w~estion ~y~V~w~ehicule", " ")
PortesMenu = RageUI.CreateSubMenu(GestionMainMenu, "~y~G~w~estion ~y~V~w~ehicule", " ")
LimiteurMenu = RageUI.CreateSubMenu(GestionMainMenu, "~y~G~w~estion ~y~V~w~ehicule", " ")


GestionMainMenu:setMenu(function()
    GestionMainMenu:IsVisible(function(item)
        local ped = PlayerPedId()
        local InVehicule = IsPedSittingInAnyVehicle(ped)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local vehf = GetVehicleFuelLevel(veh)
        local vehp = GetVehicleEngineTemperature(veh)
        local vehn = GetVehicleDoorLockStatus(veh)
        local vehe = GetEntityHealth(veh) / 10
        local plaque = GetVehicleNumberPlateText(veh)

        if InVehicule then 
            Items:AddSeparator("~y~Moteur : ~s~"..statusengine)
            Items:AddSeparator("~y~État du véhicule : ~w~"..math.ceil(vehe).." %")
            Items:AddSeparator("~y~Essence : ~w~"..math.ceil(vehf).." %")
            Items:AddSeparator("~y~Plaque du véhicule : ~w~ "..(plaque).."")
            item:AddLine(246,222, 10)

            Items:CheckBox("Status Moteur", false, engine, {Style = 1}, function(s, IsChecked)
                if s then
                    if engine == false then
                        engine = true
                    else
                        engine = false
                    end
                end
            end)

            item:AddLine(246,222, 10)

            Items:AddButton("Gestion des portes", false, {RightLabel = ">"}, function(s)
                
            end, PortesMenu)

            item:AddLine(246,222, 10)

            Items:AddButton("Limitateur de vitesse", false, {RightLabel = ">"}, function(s)
                
            end, LimiteurMenu)

        end

    end)

    PortesMenu:IsVisible(function(item)
        Items:AddSeparator("~y~G~w~estion des portes")
        item:AddLine(246,222, 10)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)
        
        Items:AddButton("Avant Gauche", false, { }, function(s)
            if s then
                if not GestionConfig.DoorsStatus.OpenDoorLeft then
                    SetVehicleDoorOpen(vehicle, 0, false, false)
                    GestionConfig.DoorsStatus.OpenDoorLeft = true
                    GestionConfig.DoorsStatus.CloseDoorLeft = false
                elseif not CloseDoorLeft then
                    GestionConfig.DoorsStatus.OpenDoorLeft = false
                    GestionConfig.DoorsStatus.CloseDoorLeft = true
                    SetVehicleDoorShut(vehicle, 0, false)
                end
            end
        end)
        Items:AddButton("Avant Droite", false, { }, function(s)
            if s then
                if not GestionConfig.DoorsStatus.OpenDoorRight then
                    SetVehicleDoorOpen(vehicle, 1, false, false)
                    GestionConfig.DoorsStatus.OpenDoorRight = true
                    GestionConfig.DoorsStatus.CloseDoorRight = false
                elseif not CloseDoorRight then
                    GestionConfig.DoorsStatus.OpenDoorRight = false
                    GestionConfig.DoorsStatus.CloseDoorRight = true
                    SetVehicleDoorShut(vehicle, 1, false)
                end
            end
        end)
        Items:AddButton("Arrière Gauche", false, { }, function(s)
            if s then
                if not GestionConfig.DoorsStatus.OpenDoorBackLeft then
                    SetVehicleDoorOpen(vehicle, 2, false, false)
                    GestionConfig.DoorsStatus.OpenDoorBackLeft = true
                    GestionConfig.DoorsStatus.CloseDoorBackLeft = false
                elseif not CloseDoorBackLeft then
                    GestionConfig.DoorsStatus.OpenDoorBackLeft = false
                    GestionConfig.DoorsStatus.CloseDoorBackLeft = true
                    SetVehicleDoorShut(vehicle, 2, false)
                end
            end
        end)
        Items:AddButton("Arrière Droite", false, { }, function(s)
            if s then
                if not GestionConfig.DoorsStatus.OpenDoorBackRight then
                    SetVehicleDoorOpen(vehicle, 3, false, false)
                    GestionConfig.DoorsStatus.OpenDoorBackRight = true
                    GestionConfig.DoorsStatus.CloseDoorBackRight = false
                elseif not CloseDoorBackRight then
                    GestionConfig.DoorsStatus.OpenDoorBackRight = false
                    GestionConfig.DoorsStatus.CloseDoorBackRight = true
                    SetVehicleDoorShut(vehicle, 3, false)
                end
            end
        end)
        Items:AddButton("Capot", false, { }, function(s)
            if s then
                if not GestionConfig.DoorsStatus.OpenDoorCapot then
                    SetVehicleDoorOpen(vehicle, 4, false, false)
                    GestionConfig.DoorsStatus.OpenDoorCapot = true
                    GestionConfig.DoorsStatus.CloseDoorCapot = false
                elseif not CloseDoorCapot then
                    GestionConfig.DoorsStatus.OpenDoorCapot = false
                    GestionConfig.DoorsStatus.CloseDoorCapot = true
                    SetVehicleDoorShut(vehicle, 4, false)
                end
            end
        end)
        Items:AddButton("Coffre", false, { }, function(s)
            if s then
                if not GestionConfig.DoorsStatus.OpenDoorCoffre then
                    SetVehicleDoorOpen(vehicle, 5, false, false)
                    GestionConfig.DoorsStatus.OpenDoorCoffre = true
                    GestionConfig.DoorsStatus.CloseDoorCoffre = false
                elseif not CloseDoorCoffre then
                    GestionConfig.DoorsStatus.OpenDoorCoffre = false
                    GestionConfig.DoorsStatus.CloseDoorCoffre = true
                    SetVehicleDoorShut(vehicle, 5, false)
                end
            end
        end)
    end)

LimiteurMenu:IsVisible(function(item)
    Items:AddSeparator("~y~G~w~estion de vitesse")
    item:AddLine(246,222, 10)
    local ped1 = PlayerPedId()
    local vehicle1 = GetVehiclePedIsUsing(ped1)

    Items:AddButton("Enlever Limitateur", false, { }, function(s)
        if s then
            
            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0 / 3.6)

        end
    end)

    Items:AddButton("Choisir KM", false, { }, function(s)
        if s then
      local crtSpeed = KeyboardInput("Vitesse ?", "", 3)
            if crtSpeed ~= nil and tonumber(crtSpeed) then
              SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), crtSpeed / 2.9)
            end
        end
    end)
    
    Items:AddButton("20 KM", false, { }, function(s)
        if s then
            
            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 26.0 / 3.6)

        end
    end)

    Items:AddButton("50 KM", false, { }, function(s)
        if s then
            
            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 65.0 / 3.6)

        end
    end)

    Items:AddButton("80 KM", false, { }, function(s)
        if s then
            
            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 75.0 / 2.6)

        end
    end)

    Items:AddButton("100 KM", false, { }, function(s)
        if s then
            
            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 93.0 / 2.6)

        end
    end)





end)
end)

Keys.Register("F5", "F5", "ouvrir le menu gestion véhicule", function()
    local ped = PlayerPedId()
    local InVehicule = IsPedSittingInAnyVehicle(ped)
    
    if InVehicule then 
        GestionMainMenu:openMenu()
    else
        FrxESX.ShowNotification('~r~Attention~s~ \ntu dois être dans un véhicule pour faire ceci !')
    end
end)

function Keyboardput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end