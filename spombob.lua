-- 🧩 Load Rayfield UI
local success, Rayfield = pcall(function() 
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))() 
end)

if not success then warn("Gagal load Rayfield!") return end

local Window = Rayfield:CreateWindow({
    Name = "Zoo Premium: Kuddly Edition",
    LoadingTitle = "Sniping Kuddly Baskets...",
    LoadingSubtitle = "by Tegar",
    ConfigurationSaving = {Enabled = false}
})

-- 📑 Tab & Services
local Tab = Window:CreateTab("Kuddly Sniper", nil)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Mencari Remote Knit (Sesuai jalur yang lu kasih tadi)
local KnitPath = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("acecateer_knit@1.7.2"):WaitForChild("knit"):WaitForChild("Services")
local ShopService = KnitPath:FindFirstChild("ShopService") or KnitPath:FindFirstChild("ProductService")
local PurchaseRE = ShopService and ShopService:WaitForChild("RE"):FindFirstChild("PurchaseItem")

Tab:CreateSection("Target: Kuddly Basket")

-- 🛠️ Fungsi Eksekusi
local function snipe(itemName)
    if PurchaseRE then
        PurchaseRE:FireServer(itemName)
        Rayfield:Notify({
            Title = "Request Sent",
            Content = "Mencoba beli: " .. itemName,
            Duration = 2
        })
    else
        Rayfield:Notify({
            Title = "Error",
            Content = "Remote PurchaseItem tidak ditemukan!",
            Duration = 5
        })
    end
end

-- 🛒 Tombol x1
Tab:CreateButton({
    Name = "🎁 Buy Kuddly Basket x1",
    Callback = function()
        snipe("KuddlyBasket") -- Coba tanpa suffix
        snipe("KuddlyBasket_x1") -- Fallback 1
        snipe("KuddlyBasketx1") -- Fallback 2
    end,
})

-- 🛒 Tombol x3
Tab:CreateButton({
    Name = "📦 Buy Kuddly Basket x3",
    Callback = function()
        snipe("KuddlyBasket_x3")
        snipe("KuddlyBasketx3")
    end,
})

-- 🛒 Tombol x5
Tab:CreateButton({
    Name = "🚚 Buy Kuddly Basket x5",
    Callback = function()
        snipe("KuddlyBasket_x5")
        snipe("KuddlyBasketx5")
    end,
})

Tab:CreateSection("Experimental")

-- Tombol Spam (Biar RMT makin kenceng)
Tab:CreateToggle({
    Name = "⚡ Auto Buy x1 (Spam)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoBuy = Value
        while _G.AutoBuy do
            snipe("KuddlyBasket")
            task.wait(1.5) -- Kasih delay biar nggak kena ban/kick
        end
    end,
})

Rayfield:Notify({
    Title = "Ready!",
    Content = "Script siap dipakai buat nyari cuan RMT!",
    Duration = 5
})
