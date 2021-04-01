local CustomActionName = "Steer and act"
local SystemActionName = "TURNORACTION"
BINDING_HEADER_STEERANDACT = CustomActionName

local function Rebind(Keybinding)
    local Result = true

    local ExistingKeys = {GetBindingKey(SystemActionName)}
    local _, Key
    for _, Key in ipairs(ExistingKeys) do
        if Key ~= "BUTTON2" then
            Result = Result and SetBinding(Key)
        end
    end

    Result = Result and SetBinding(Keybinding, SystemActionName)
    return Result
end

local Rebinding
local function ChangeBindings()
    if Rebinding then return end

    local Keybinding = GetBindingKey(CustomActionName)
    if Keybinding then
        Rebinding = true
        if Rebind(Keybinding) then
            print(Keybinding.." bound successfully for "..CustomActionName..". Do not worry about it disappearing in the key bindings options window - your "..Keybinding.." still will work.")
        end
        Rebinding = nil
    end
end

local f = CreateFrame("Frame", nil, UIParent)
f:RegisterEvent("UPDATE_BINDINGS")
f:SetScript("OnEvent", ChangeBindings)
