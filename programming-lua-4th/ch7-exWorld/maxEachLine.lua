while true do
	local n1, n2, n3 = ("n", "n", "n")
	if not n1 then
		break
	end
	io.write(math.max(n1, n2, n3), "\n")
end
