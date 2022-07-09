local Gen = Ambi.General
local MsgC, istable, isnumber = MsgC, istable, isnumber
local table_GetKeys, table_sort, string_rep, tostring = table.GetKeys, table.sort, string.rep, tostring
local COLOR1, COLOR2 = Color( 0, 0, 0 ), Color( 255, 255, 255 )

-- --------------------------------------------------------------------------------------------------------------------------------------------
function PrintTable( tTable, nIndent, tDone )
	if not tTable or not istable( tTable ) then Gen.Error( 'General', 'PrintTable only for table!' ) return end

	tDone = tDone or {}
	nIndent = nIndent or 0

	local keys = table_GetKeys( tTable )

	table_sort( keys, function( a, b )
		if ( isnumber( a ) && isnumber( b ) ) then return a < b end
		return tostring( a ) < tostring( b )
	end )

	tDone[ tTable ] = true

	for i = 1, #keys do
		local key = keys[ i ]
		local value = tTable[ key ]
		MsgC( string_rep( "\t", nIndent ) ) -- TODO: added colors

		if  ( istable( value ) && !tDone[ value ] ) then
			tDone[ value ] = true
			MsgC( key, ":\n" )
			PrintTable( value, nIndent + 2, tDone )
			tDone[ value ] = nil
		else
			MsgC( key, "\t=\t", value, "\n" )
		end
	end
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
printtable = PrintTable
printTable = PrintTable
Print = print

IsVector = isvector
IsAngle = isangle
IsTable = istable
IsString = isstring
IsNumber = isnumber
IsBool = isbool
IsFunction = isfunction
IsMatrix = ismatrix
IsPanel = ispanel

ToBool = tobool
ToString = tostring
ToNumber = tonumber

rgb = Color
RGB = Color
color = Color