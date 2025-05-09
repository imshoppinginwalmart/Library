local webImport = _G.GUI_webImport
local Component = webImport("Component.lua")
local State     = webImport("State.lua")
local Themes    = webImport("Themes.lua")
local Utils     = webImport("Utils.lua")

local Core = {}

local components   = {}
local activeThemes = { Light = Themes.Light, Dark = Themes.Dark }

local function makeComponent(name)
    assert(components[name], "Unknown component: "..name)
    return function(props)
        return components[name].new(props)
    end
end

function Core.new(appName, opts)
    opts = opts or {}
    local self = setmetatable({}, { __index = Core })

    local parent = opts.parent or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local root   = Instance.new("ScreenGui")
    root.Name    = appName
    root.Parent  = parent

    self._root     = root
    self._theme    = activeThemes[opts.theme or "Light"]
    self.State     = State
    self.Utils     = Utils
    
    for name in pairs(components) do
        self[name] = makeComponent(name)
    end

    return self
end

function Core.registerComponent(name, module)
    components[name] = module
end
function Core.registerTheme(name, tbl)
    activeThemes[name] = tbl
end
function Core.loadTheme(self, name)
    self._theme = assert(activeThemes[name], "Theme not found: "..name)
    -- TODO: re‑apply to existing instances
end

return Core
