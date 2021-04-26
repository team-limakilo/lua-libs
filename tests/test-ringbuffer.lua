#!/usr/bin/lua
require "os"

local RingBuffer = require("libs.containers.ringbuffer")

local function test()
	local tests = {
		{
			name = "storage",
			size = 4,
			input = {1, 2, 3, 4},
			verify = {1, 2, 3, 4},
		}, {
			name = "overflow",
			size = 4,
			input = {33, 22, 3, 5, 31, 2, 9, 10, 23, 45},
			verify = {9, 10, 23, 45},
		}, {
			name = "min",
			size = 10,
			input = {1, 2, 3, 4},
			verify = {1, 2, 3, 4},
		},

	}

	local rb = RingBuffer()

	assert(rb:size() == 0, "RingBuffer: size not zero")
	assert(rb:peek() == nil, "RingBuffer: an empty buffer didn't return nil")
	assert(rb:full() == false, "RingBuffer: reports full")
	assert(rb:empty() == true, "RingBuffer: reports not empty")

	for _, t in ipairs(tests) do
		rb = RingBuffer(t.size)
		for _, i in ipairs(t.input) do
			rb:push(i)
		end
		assert(rb:empty() == false,
			   string.format("Ringbuffer:%s reports empty", t.name))
		assert(rb:peek() == t.verify[1],
			   string.format("RingBuffer:%s peek failed", t.name))
		for _, i in ipairs(t.verify) do
			assert(rb:peek() == i,
				   string.format("RingBuffer:%s:peek %d != %d",
								 t.name, rb:peek(), i))
			assert(rb:pop() == i,
				   string.format("RingBuffer:%s:pop failed", t.name))
		end
	end

	return 0
end
os.exit(test())
