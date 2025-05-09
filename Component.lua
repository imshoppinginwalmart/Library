local RunService = game:GetService("RunService")

local Component = {}
Component.__index = Component

function Component.new(props)
    local self = setmetatable({
        props   = props or {},
        events  = {},
        _inst   = nil,
    }, Component)

    if self.onInit then self:onInit() end
    self:_createInstance()
    if self.onRender then self:onRender(self._inst) end

    return self._inst
end

function Component:_createInstance()
    local inst = Instance.new("Frame")
    inst.Name  = self.props.name or self.__className
    inst.Size  = self.props.size or UDim2.new(0,100,0,30)
    self._inst = inst
end

function Component:onDestroy()
    for _, conn in ipairs(self.events) do conn:Disconnect() end
end

return Component
