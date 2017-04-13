local base = _G

local function info(str) 
	print("["..os.date("%H:%M:%S").."] ".."INFO : "..str)
end

Include = {}

Include.File = function( filePath )
	if not Include.Files[ filePath ] then
		Include.Files[filePath] = filePath
		info( "Include:" .. Include.ProgramPath .. filePath )
		local f = base.loadfile( Include.ProgramPath .. filePath .. ".lua" )
		
		if f == nil then
			f = base.loadfile( filePath .. ".lua" )
		end

		if f == nil then
			error ("Could not load file " .. filePath .. ".lua" )
		else
			info( "Include:" .. filePath .. " loaded from " .. Include.ProgramPath )
			return f()
		end
	else
		info( "Skipping Include:" .. filePath .. " loaded from " .. Include.ProgramPath )
	end
end

Include.ProgramPath = ".\\"

info( "Include.ProgramPath = " .. Include.ProgramPath)

Include.Files = {}
Include.File( "Bootstrapper" )