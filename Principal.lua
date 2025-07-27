local Players = game:GetService("Players")
local player = Players.LocalPlayer

local sweb = _G.Seed
local gweb = _G.Gear
local eweb = _G.Egg

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/Stock-bot/main/Sendwebhook.lua"))()

local seedShop = player.PlayerGui:WaitForChild("Seed_Shop"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local gearShop = player.PlayerGui:WaitForChild("Gear_Shop"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local eggShop = player.PlayerGui:WaitForChild("PetShop_UI"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")

local function coletarEstoque(scroll)
    local itens = {}
    for _, i in ipairs(scroll:GetChildren()) do
        if i:IsA("Frame") and i:FindFirstChild("Main_Frame") and i.Main_Frame:FindFirstChild("Stock_Text") then
            local stock = i.Main_Frame.Stock_Text.Text
            if stock ~= "X0 Stock" then
                table.insert(itens, i.Name .. " - " .. stock)
            end
        end
    end
    table.sort(itens)
    return itens
end

local ultimoSeedGearMinuto = -1
local ultimoEggMinuto = -1

while true do
    local agora = os.date("*t")
    local segundos = agora.sec + (os.clock() % 1)

    if agora.min % 5 == 0 and segundos <= 1.5 and agora.min ~= ultimoSeedGearMinuto then
        ultimoSeedGearMinuto = agora.min

        local currentSeedStock = coletarEstoque(seedShop)
        if #currentSeedStock > 0 then
            enviarWebhook(sweb, "🌱 Seed Shop - Estoque Atualizado", currentSeedStock)
        end
        task.wait(0.2)

        local currentGearStock = coletarEstoque(gearShop)
        if #currentGearStock > 0 then
            enviarWebhook(gweb, "⚙️ Gear Shop - Estoque Atualizado", currentGearStock)
        end
    end

    if agora.min % 30 == 0 and segundos <= 1.5 and agora.min ~= ultimoEggMinuto then
        ultimoEggMinuto = agora.min

        local currentEggStock = coletarEstoque(eggShop)
        if #currentEggStock > 0 then
            enviarWebhook(eweb, "🥚 Egg Shop - Estoque Atualizado", currentEggStock)
        end
    end

    task.wait(0.2)
end
