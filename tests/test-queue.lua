#!/usr/bin/lua
require "os"

local Queue = require("libs.containers.queue")

local function test()
	local tests = {
		{
			name = "storage",
			input = {1, 2, 3, 4},
		}
	}

	local rb = Queue()

	--assert(rb:size() == 0, "Queue: size not zero")
	assert(rb:peekhead() == nil, "Queue: an empty buffer didn't return nil")
	assert(rb:empty() == true, "Queue: reports not empty")

	for _, t in ipairs(tests) do
		rb = Queue()
		for _, i in ipairs(t.input) do
			rb:pushtail(i)
		end
		assert(rb:empty() == false,
			   string.format("Queue:%s reports empty", t.name))
		local i = 1
		for _, v in rb:iterate() do
			assert(v == t.input[i],
				   string.format("Queue:%s failed", t.name))
			i = i + 1
		end
	end

	return 0
end
os.exit(test())
