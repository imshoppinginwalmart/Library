local owner = 'imshoppinginwalmart'
local branch = 'main'

local function webImport(file)
    return loadstring(game:HttpGetAsync(('https://raw.githubusercontent.com/%s/Library/%s/%s'):format(owner, branch, file)), file .. '.lua')()
end

_G.webImport = webImport

return webImport('Core.lua')
