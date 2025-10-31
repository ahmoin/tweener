--!strict

local TweenService = game:GetService("TweenService")

local Spring = require(script.Spring)

local Tweener = {}
Tweener.Spring = Spring

local DEFAULT_DAMPING_RATIO = 0.375
local DEFAULT_FREQUENCY = 4.0

function Tweener.Tween(instance: Instance, tweenInfo: TweenInfo, properties: {[string]: any}, shouldYield: boolean?): Tween
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    if shouldYield then
        tween:Wait()
        tween:Destroy()
        tween = nil
    else
        tween.Completed:Connect(function()
            tween:Destroy()
            tween = nil
        end)
    end
    return tween
end

function Tweener.TweenBounce(instance: Instance, dampingRatio: number?, frequency: number?, properties: {[string]: any})
    return Spring.target(instance, if dampingRatio then dampingRatio else DEFAULT_DAMPING_RATIO, if frequency then frequency else DEFAULT_FREQUENCY, properties)
end

return table.freeze(Tweener)
