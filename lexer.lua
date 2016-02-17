local lexer = {}

function lexer:tokenize(string)
	local code = {}

	local tokens = " ,.\n\t<>(){}[]/?+-*/=!#%^&~`$"
	local word   = ""

	for i = 1,#string do
		local char = string:sub(i,i)

		if string.find(tokens,char,1,true) then

			if #word > 0 then
				table.insert(code,word)
			end

			table.insert(code,char)
			
			word = ""
		else
			if char ~= '\n' and char ~= '\t' and char ~= ' ' then
				word = word .. char
			end
		end

	end

	return code
end

return lexer