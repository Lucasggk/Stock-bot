local HttpService = game:GetService("HttpService")
local player = game:GetService("Players").LocalPlayer

function enviarWebhook(webhook, title, itens)
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = title,
            ["color"] = 65280,
            ["fields"] = {},
            ["footer"] = {
                ["text"] = "Player: " .. player.Name .. " | " .. os.date("%d/%m/%Y %H:%M:%S")
            }
        }}
    }

    for _, texto in ipairs(itens) do
        table.insert(data.embeds[1].fields, {
            ["name"] = "Item",
            ["value"] = texto,
            ["inline"] = false
        })
    end

    HttpService:PostAsync(webhook, HttpService:JSONEncode(data))
end
