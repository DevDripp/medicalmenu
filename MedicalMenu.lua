_menuPool = NativeUI.CreatePool()
MedicalMenu = NativeUI.CreateMenu("~r~Medical Menu", "~r~Apply first aid to your ped")
_menuPool:Add(MedicalMenu)
Healcooldown = true
cooldown = 5000
bool = false


function HealMe(menu) 
    local health = GetEntityHealth(PlayerPedId())
    local click = NativeUI.CreateItem("~h~Apply a bandage", "~g~Heals your player to 75%")
    menu:AddItem(click)
    menu.OnItemSelect = function(sender, item, index)
        if item == click then
            Healcooldown = false
            if Healcooldown == false then
                if GetEntityHealth(PlayerPedId()) >= 135 then --If peds health is 135 or bigger command will alert out
                    notify("~r~Cannot Heal, Player is at 75% Health")
                    return

            end
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                return
                notify("~r~Cannot apply a bandage while driving a vehicle") 
    --Will not allow for you to heal when in the driver seat of a vehicle
            end


            if IsPedInAnyVehicle(PlayerPedId(), true) then
                notify("~r~Applying Bandage")
                Wait(cooldown)
                SetEntityHealth(PlayerPedId(), 135)
                notify("~g~Bandage Applied")
                Wait(600000)
                return
    --If someone is in vehicle and not driver, will apply bandage and not emote.
            end
            
                print(health)
                TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, 1)
                notify("~r~Applying Bandage")
                Wait(cooldown)
                    
                     print(Healcooldown)
                         Healcooldown = true
                    SetEntityHealth(PlayerPedId(), 135)
                    notify("~g~Bandage Applied")
                    Healcooldown = false
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    Wait(600000)
        --When player is on foot and under 135 health ped will kneel for 5 seconds then ped will heal to 135.
                end
        end
            if Healcooldown == true then
                notify("~r~ You must wait 5 seconds to use this again")
            end
        end
    end

HealMe(MedicalMenu)

_menuPool:RefreshIndex()
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 288) then 
            MedicalMenu:Visible(not MedicalMenu:Visible())
        end
    end
end)
function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end