local main = {}

local lexer = require "lexer"
local re_asm= require "re_assemble"

function main:compile(_file)

	local code_table = {}
	local lua_code   = ""
	local code = ""
	local file = io.open(_file)

	code = file:read("*a")
	file:close()

	code_table = lexer:tokenize(code)

	lua_code = re_asm:assemble(code_table)

	print(lua_code)

	local lua_file = io.open("test/finished.lua","w")
	lua_file:write(lua_code)
	lua_file:close()
end

main:compile("test/main.clua")