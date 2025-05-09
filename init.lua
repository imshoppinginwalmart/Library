local owner = 'imshoppinginwalmart'
local branch = 'main'

local function webImport(file)
    return loadstring(game:HttpGetAsync(('https://raw.githubusercontent.com/%s/Library/%s/%s.lua'):format(owner, branch, file)), file .. '.lua')()
end

return webImport('Core')
