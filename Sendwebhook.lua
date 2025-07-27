local HttpService = game:GetService("HttpService")

function enviarWebhook(webhook, title, itens)
    local agora = os.time()
    local minutosArredondados = agora - (os.date("*t", agora).min % 5) * 60
    local timestampDiscord = "<t:" .. minutosArredondados .. ":t>"

    local mensagem = table.concat(itens, "\n")
    local data = {
        content = "",
        embeds = {{
            title = title .. " - " .. timestampDiscord,
            color = 65280,
            description = mensagem
        }}
    }

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
