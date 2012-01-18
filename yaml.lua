local lyaml = require 'lyaml'
local io = io
local coroutine = coroutine

local print = print

package.loaded[...] = {}
module(...)

load = lyaml.load
dump = lyaml.dump

local function file_loader(file)
    local yaml_str = ""

    while(true) do
    	local line = file:read("*l")

    	if (line == "---" and yaml_str) then
            local r = lyaml.load(yaml_str)
            if(r) then
                coroutine.yield(r)
            end
            yaml_str = ""
        elseif (line) then
            yaml_str = yaml_str .. "\n" .. line
        elseif(yaml_str) then
            local r = lyaml.load(yaml_str)
            if (r) then
                coroutine.yield(r)
            end
            break
        else
            break
    	end
    end
end

function load_file(fname)
    local file = io.open(fname, "r")
    local co = coroutine.create(function () file_loader(file) end)

    return function () -- iterator
        local code, res = coroutine.resume(co)
        return res
    end
end
