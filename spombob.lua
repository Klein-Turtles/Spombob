-- 🧩 Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Zoo Event Sniper: St. Patrick's",
    LoadingTitle = "Bypassing Knit Controllers...",
    LoadingSubtitle = "by Tegar",
    ConfigurationSaving = {Enabled = false}
})

local Tab = Window:CreateTab("Event Shop", nil)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

-- 🛠️ Fungsi Eksekusi Knit Service
local function eventBuy(itemName)
    -- Kita coba cari Service yang menangani event ini
    -- Biasanya namanya StPatricksService atau EventService
    local TargetService = Knit.GetService("StPatricksService") or Knit.GetService("EventService") or Knit.GetService("ShopService")
    
    if TargetService then
        -- Di Knit, method server dipanggil lewat RE atau RF
        -- Kita tembak fungsi "Purchase" atau "Buy"
        pcall(function()
            -- Coba panggil method "PurchaseItem" (standar Knit)
            TargetService.PurchaseItem:Fire(itemName)
            Rayfield:Notify({Title = "Sent", Content = "Target: " .. itemName, Duration = 2})
        end)
    else
        Rayfield:Notify({Title = "Error", Content = "Service Event gak ketemu!", Duration = 5})
    end
end

Tab:CreateSection("Event Items (St. Patrick's 2026)")

-- Tombol Sniper (Sesuai tebakan ID lu)
Tab:CreateButton({
    Name = "🍀 Buy Kuddly Basket x1",
    Callback = function()
        eventBuy("KuddlyBasket")
        eventBuy("KuddlyBasket_x1")
    end,
})

Tab:CreateButton({
    Name = "🍀 Buy Kuddly Basket x3",
    Callback = function()
        eventBuy("KuddlyBasket_x3")
        eventBuy("KuddlyBasketx3")
    end,
})

Tab:CreateSection("Manual ID Input")
Tab:CreateInput({
    Name = "Custom Event ID",
    PlaceholderText = "KuddlyBasket_x5...",
    Callback = function(Text)
        eventBuy(Text)
    end,
})

-- 🔍 ANALYTIC BYPASS
-- Biar gak kedetect "ShopInteraction" yang tadi lu kasih
local AnalyticRE = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("acecateer_knit@1.7.2"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("AnalyticReportService"):WaitForChild("RE"):WaitForChild("ShopInteraction")

Tab:CreateToggle({
    Name = "Ghost Mode (Spoof Analytics)",
    CurrentValue = true,
    Callback = function(Value)
        _G.GhostMode = Value
        if Value then
            -- Ini bakal ngirim log palsu ke dev seolah-olah lu cuma "pencet UI"
            AnalyticRE:FireServer("ShopItemClicked", "KuddlyBasket")
        end
    end,
})
