cpu = manager.machine.devices[":maincpu"]

for tag, value in pairs(cpu.state) do print(tag) end


-- local function save_memory()
--     local memory = manager.machine.devices[":maincpu"].spaces["program"]:read_block(0x00000, 0x100000)
--     local file = io.open("memory.bin", "wb")
--     file:write(memory)
--     file:close()
-- end

-- emu.register_periodic(save_memory, 1.0)

--   if (manager.machine.devices[":maincpu"].spaces["program"]:read_u8(0xffd5) & 1) == 1 then --hirom

-- local socket = require("socket")
-- local host = "127.0.0.1"
-- local port = 12345
-- local client = assert(socket.tcp())

-- client:connect(host, port)

-- local previous_memory = {}

-- -- Monitor geheugen elke frame
-- emu.register_frame(function()
--     local start_address = 0x0000
--     local end_address = 0xFFFF

--     for address = start_address, end_address do
--         local value = manager:machine().devices[":maincpu"].spaces["program"]:read_u8(address)
--         if previous_memory[address] ~= value then
--             -- Verzend geheugenadres en waarde via socket
--             local data = string.format("0x%X = 0x%X\n", address, value)
--             client:send(data)
--             previous_memory[address] = value
--         end
--     end
-- end)

-- emu.register_exit(function()
--     client:close()
-- end)




-- cpu = manager.machine.devices[":maincpu"]
-- mem = cpu.spaces["program"]









-- local memory = manager.machine.devices[":maincpu"].spaces["program"]:read_block(0x00000, 0x100000)
--     local file = io.open("memory.bin", "wb")
--     file:write(memory)
--     file:close()




-- local function save_memory()
-- --     -- emu.debug_command('save memory.bin,0,fffff')
-- --     print("test")
--     local memory = manager.machine.devices[":maincpu"].spaces["program"]:read_block(0x00000, 0x100000)
--     local file = io.open("memory.bin", "wb")
--     file:write(memory)
--     file:close()
-- end

-- emu.register_periodic(save_memory, 1.0)


-- Start de emulator
-- emu.debugger_command("g")


-- function Check_MaxSpritesPerScanline()
--     print "test"
--     -- local memory_size = 0x100000 -- 1MB
--     -- local memory_dump = ""
--     -- for address = 0, memory_size - 1 do
--     --     memory_dump = memory_dump .. string.char(manager.machine.devices[":maincpu"].spaces["program"]:read_u8(address))
--     -- end
--     local file = io.open("memory_dump.bin", "wb")
--     file:write("test")
--     file:close()
-- end

-- emu.register_frame_done(Check_MaxSpritesPerScanline, "frame")

-- -- emu.sethook(function()
-- --     local memory_size = 0x100000 -- 1MB
-- --     local memory_dump = ""
-- --     for address = 0, memory_size - 1 do
-- --         memory_dump = memory_dump .. string.char(manager.machine.devices[":maincpu"].spaces["program"]:read_u8(address))
-- --     end
-- --     local file = io.open("memory_dump.bin", "wb")
-- --     file:write(memory_dump)
-- --     file:close()
-- -- end, "cpu_execute")