local State = {}
State.__index = State

function State.new(tbl)
    local listeners = {}
    local proxy
    proxy = setmetatable({}, {
        __index = function(_, k) return tbl[k] end,
        __newindex = function(_, k, v)
            tbl[k] = v
            if listeners[k] then
                for _, cb in ipairs(listeners[k]) do cb(v) end
            end
        end
    })
    function proxy:Watch(key, cb)
        listeners[key] = listeners[key] or {}
        table.insert(listeners[key], cb)
    end
    return proxy
end

return setmetatable(State, { __call = function(_, t) return State.new(t) end })
