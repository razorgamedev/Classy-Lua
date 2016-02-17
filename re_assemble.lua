local re_assemble = {}

function re_assemble:first_pass(code)
	local working = {}
	local skip    = 0

	for i = 1,#code do
		local word = code[i]

		if skip > 0 then

			skip = skip - 1

		elseif word == "+" and code[i + 1] == "+" then

			local n = 1
			while code[i-n] == ' ' do
				n = n + 1
			end
			local name = code[i - n]

			table.remove(working, #working)
			table.insert(working, "=")
			table.insert(working, name)			
			table.insert(working, "+")			
			table.insert(working, "1")			

			skip = 1
		elseif word == "+" or 
			   word == "-" or
			   word == "*" or
			   word == "/" or
			   word == "%" and code[i+1] == "=" then

			local n = 1
			while code[i-n] == ' ' do
				n = n + 1
			end
			local name = code[i - n]

			table.remove(working, #working)
			table.insert(working, "=")
			table.insert(working, name.." ")	
			table.insert(working, word)			

			skip = 1

		else
			table.insert(working,word)
		end


	end
	return working
end

function re_assemble:assemble(code)
	local lua_code = ""

	code = self:first_pass(code)

	for i, word in ipairs(code) do
		
		lua_code = lua_code .. word

	end

	return lua_code
end

return re_assemble