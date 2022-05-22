local Game = _G.game; -- Bypass some environment checking stuff hopefully

local Hook = function(Method, Func)
	local mType = type(Method);
	
	if type(Method) == "string" then
		local fType = type(Func) -- Only get type if other type is valid
		
		if type(Func) == "function" then
			local Success, _ = pcall(function(...)
				hookmetamethod(Game, Method, newcclosure(Func));
			end);
			
			if not Success then
				error("Error: invalid metamethod!");
			end
		end
	end
	
	return "failed";
end

-- Example usage

local Target = game.Players.LocalPlayer.Setings;

Hook("__index", function(...)
	local Args = {...};
	
	local T = Args[1];
	local I = Args[2];
	local V = Args[3];
	
	if T == Target and I == "Value" then
		return 2 ^ ((V / 64) % 1024); -- Make the number beeg :)
	end
end);
