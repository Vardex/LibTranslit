local MAJOR_VERSION = "LibTranslit-1.0"
local MINOR_VERSION = 2
if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local CyrToLat = {
	["А"] = "A",
	["а"] = "a",
	["Б"] = "B",
	["б"] = "b",
	["В"] = "V",
	["в"] = "v",
	["Г"] = "G",
	["г"] = "g",
	["Д"] = "D",
	["д"] = "d",
	["Е"] = "E", 
	["е"] = "e",
	["Ё"] = "e",
	["ё"] = "e",
	["Ж"] = "Zh",
	["ж"] = "zh",
	["З"] = "Z",
	["з"] = "z",
	["И"] = "I",
	["и"] = "i",
	["Й"] = "Y",
	["й"] = "y",
	["К"] = "K",
	["к"] = "k",
	["Л"] = "L",
	["л"] = "l",
	["М"] = "M",
	["м"] = "m",
	["Н"] = "N",
	["н"] = "n",
	["О"] = "O",
	["о"] = "o",
	["П"] = "P",
	["п"] = "p",
	["Р"] = "R",
	["р"] = "r",
	["С"] = "S",
	["с"] = "s",
	["Т"] = "T",
	["т"] = "t",
	["У"] = "U",
	["у"] = "u",
	["Ф"] = "F",
	["ф"] = "f",
	["Х"] = "Kh",
	["х"] = "kh",
	["Ц"] =  "Ts",
	["ц"] = "ts",
	["Ч"] = "Ch",
	["ч"] = "ch",
	["Ш"] = "Sh",
	["ш"] = "sh",
	["Щ"] = "Shch",
	["щ"] = "shch",
	["Ъ"] = "",
	["ъ"] = "", 
	["Ы"] = "Y",
	["ы"] = "y",
	["Ь"] = "",
	["ь"] = "",
	["Э"] = "E",
	["э"] = "e",
	["Ю"] = "Yu",
	["ю"] = "yu",
	["Я"] = "Ya",
	["я"] = "ya",
}

function lib:Transliterate(str, mark)
	local mark = mark or ""
	if not str then
		return ""
	end
		
	if string.len(str) > 0 and str:sub(1, 1) == mark then
		return str
	end
	
	local tstr = ""
	local is_translit = false
	local i = 1
	while i <= string.len(str) do
		local c = str:sub(i,i)
		local b = string.byte(c)
		
		if b == 208 or b == 209 then
			c = str:sub(i+1, i+1)
			tstr = tstr .. (CyrToLat[string.char(b, string.byte(c))] or string.char(b, string.byte(c)))
			i = i + 2
			is_translit = true
		else
			tstr = tstr .. c
			i = i + 1
		end
	end
	
	if is_translit then
		return mark .. tstr
	else
		return tstr
	end
end