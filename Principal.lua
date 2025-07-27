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
        if i:FindFirstChild("Main_Frame") and i.Main_Frame:FindFirstChild("Stock_Text") then
            local stock = i.Main_Frame.Stock_Text.Text
            if stock ~= "X0 Stock" then
                table.insert(itens, i.Name .. " - " .. stock)
            end
        end
    end
    table.sort(itens)
    return itens
end

local lastSeedStock = {}
local lastGearStock = {}
local lastEggStock = {}

local function tabelaIgual(t1, t2)
    if #t1 ~= #t2 then return false end
    for i = 1, #t1 do
        if t1[i] ~= t2[i] then return false end
    end
    return true
end

local function podeEnviar()
    local agora = os.date("*t")
    return agora.min % 5 == 0 and agora.sec <= 0.5
end

while true do
    local currentSeedStock = coletarEstoque(seedShop)
    local currentGearStock = coletarEstoque(gearShop)
    local currentEggStock = coletarEstoque(eggShop)

    if podeEnviar() then
        if not tabelaIgual(currentSeedStock, lastSeedStock) and #currentSeedStock > 0 then
            enviarWebhook(sweb, "🌱 Seed Shop - Estoque Atualizado", currentSeedStock)
            lastSeedStock = currentSeedStock
        end

        if not tabelaIgual(currentGearStock, lastGearStock) and #currentGearStock > 0 then
            enviarWebhook(gweb, "⚙️ Gear Shop - Estoque Atualizado", currentGearStock)
            lastGearStock = currentGearStock
        end

        if not tabelaIgual(currentEggStock, lastEggStock) and #currentEggStock > 0 then
            enviarWebhook(eweb, "🥚 Egg Shop - Estoque Atualizado", currentEggStock)
            lastEggStock = currentEggStock
        end
    end

    task.wait(0.1)
end
