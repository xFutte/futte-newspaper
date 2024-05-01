CreateThread(function()
    if GetResourceState('ox_inventory') == "started" or GetResourceState('ox_inventory') == "starting" then
        Config.UseOxInventory = true
    end
    
    if Config.UseOxInventory then
        Framework.RegisterUsableItem = function(itemName, callBack)
            exports(itemName, function(event, item, inventory, slotId, data)
                local slot = exports.ox_inventory:GetSlot(inventory.id, slotId)
                callBack(inventory.id, slot)
            end)
        end
    
        Framework.DoesItemExist = function(itemName)
            if not itemName then return false end
            
            local itemList = exports.ox_inventory:Items()
    
            return itemList and itemList[itemName] ~= nil
        end
    
        Framework.GetItemCount = function(serverId, name)
            local itemCount = exports.ox_inventory:Search(serverId, 'count', name, nil)
    
            if itemCount then
                return itemCount, {}
            else
                return 0, {}
            end
        end
    
        Framework.AddInventoryItem = function(serverId, name, count, metadata)
            if not metadata then
                metadata = {}
            end
    
            local success, response = exports.ox_inventory:AddItem(serverId, name, count, metadata)
            
            if not success then
                return print(response)
            end
        end
    
        Framework.RemoveInventoryItem = function(serverId, name, count)
            exports.ox_inventory:RemoveItem(serverId, name, count)
        end
    end
end)