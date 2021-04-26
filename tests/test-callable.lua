#!/usr/bin/lua
require("os")

local function callable(cls)
	local inst = {}
	setmetatable(inst, { __index = cls })
	return inst
end

local function test()
	local A = {
		__call = callable,
	}
	setmetatable(A, A)

	local B = {}
	setmetatable(B, { __call = callable })

	A()
	B()

	return 0
end
os.exit(test())
