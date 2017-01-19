local base = _G

Tracer = {}

function Tracer.info(str) 
	print("Info: "..str)
end

Include = {}

Include.File = function( IncludeFile )
	if not Include.Files[ IncludeFile ] then
		Include.Files[IncludeFile] = IncludeFile
		Tracer.info( "Include:" .. IncludeFile .. " from " .. Include.ProgramPath )
		local f = assert( base.loadfile( Include.ProgramPath .. IncludeFile .. ".lua" ) )
		if f == nil then
			error ("Could not load file " .. IncludeFile .. ".lua" )
		else
			Tracer.info( "Include:" .. IncludeFile .. " loaded from " .. Include.ProgramPath )
			return f()
		end
	end
end

Include.ProgramPath = ".\\"

Tracer.info( "Include.ProgramPath = " .. Include.ProgramPath)

Include.Files = {}
Include.File( "Boostrapper" )