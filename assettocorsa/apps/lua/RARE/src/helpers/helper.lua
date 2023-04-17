function readOnly(t)
	local proxy = {}
	local mt = {
		__index = t,
		__newindex = function(t, k, v)
			error("attempt to update a read-only value", 2)
		end,
	}
	setmetatable(proxy, mt)
	return proxy
end