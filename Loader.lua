local base = _G

local function info(str) 
	print("["..os.date("%H:%M:%S").."] ".."INFO : "..str.."\r\n")
end

Include = {}

Include.File = function( IncludeFile )
	if not Include.Files[ IncludeFile ] then
		Include.Files[IncludeFile] = IncludeFile
		info( "Include:" .. IncludeFile .. " from " .. Include.ProgramPath )
		local f = assert( base.loadfile( Include.ProgramPath .. IncludeFile .. ".lua" ) )
		if f == nil then
			error ("Could not load file " .. IncludeFile .. ".lua" )
		else
			info( "Include:" .. IncludeFile .. " loaded from " .. Include.ProgramPath )
			return f()
		end
	else
		info( "Skipping Include:" .. IncludeFile .. " loaded from " .. Include.ProgramPath )
	end
end

Include.ProgramPath = ".\\"

info( "Include.ProgramPath = " .. Include.ProgramPath)

Include.Files = {}
Include.File( "Boostrapper" )