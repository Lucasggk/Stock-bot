local player = game:GetService("Players").LocalPlayer

function enviarWebhook(webhook, title, itens)
    local data = {
        content = "",
        embeds = {{
            title = title,
            color = 65280,
            fields = {},
            footer = {
                text = "Player: " .. player.Name .. " | " .. os.date("%d/%m/%Y %H:%M:%S")
            }
        }}
    }

    for _, texto in ipairs(itens) do
        table.insert(data.embeds[1].fields, {
            name = "Item",
            value = texto,
            inline = false
        })
    end

    local jsonData = game:GetService("HttpService"):JSONEncode(data)

    local requestFunction = syn and syn.request or http and http.request or request or nil
    if not requestFunction then
        warn("Nenhuma função HTTP disponível. Use Synapse ou outro executor com suporte HTTP.")
        return
    end

    requestFunction({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    })
end
