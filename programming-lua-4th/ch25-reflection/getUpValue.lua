function getvarvalue (name, level, isenv)
	local value
	local found = false

	level = (level or 1 ) + 1

	-- try local variables
	for i = 1,  math.huge do 
		local n, v = debug.getlocal(level, i)
		if not n then break end
		if n == name then
			value = v
			found = true
		end
	end

	if found then return "local", value end

	-- try no-local variables
	local func = debug.getinfo(level, "f").func
	for i = 1, math.huge do
		local n, v = debug.getupvalue(func, i)
		if not n then break end
		if n == name then return "upvalue", v end
	end

	if isenv then return "noenv" end -- avoid loop

	-- not found; get value from the environment
	local _, env = getvarvalue("_ENV", level, true)
	if env then
		return "global", env[name]
	else
		return "noenv"
	end
end

do 
	local a = 5
	print(getvarvalue("a"))
end

do 
	a = "xxx"
	print(getvarvalue("a"))
end

