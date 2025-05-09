local Component = _G.GUI_webImport("Component.lua")
local Button    = setmetatable({}, Component)
Button.__index  = Button
Button.__className = "Button"

function Button:_createInstance()
    local btn = Instance.new("TextButton")
    btn.Size  = self.props.size or UDim2.new(0,120,0,32)
    btn.Text  = self.props.text or "Button"
    btn.Parent = self.props.parent

    btn.MouseButton1Click:Connect(function()
        if self.props.onClick then self.props.onClick() end
    end)

    self._inst = btn
end

return Button
