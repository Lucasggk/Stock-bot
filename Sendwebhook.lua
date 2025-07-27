local HttpService = game:GetService("HttpService")

function enviarWebhook(webhook, title, itens)
    local hora = os.date("%H:%M")
    local data = {
        content = "",
        embeds = {{
            title = title .. " - " .. hora,
            color = 65280,
            fields = {}
        }}
    }

    for _, texto in ipairs(itens) do
        table.insert(data.embeds[1].fields, {
            name = texto,
            value = "",
            inline = false
        })
    end

    local jsonData = HttpService:JSONEncode(data)

    local req = syn and syn.request or http and http.request or request or nil
    if req then
        req({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    else
        warn("Executor não suporta requisições HTTP.")
    end
end
