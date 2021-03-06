-- Author: Lupus590
-- License: MIT

local description = {
"This script is designed to be run on startup and checks if computers have a label.",
"If it does not then it makes one based on several pieces of data which can help identify the computer.",
"The format of the resulting label is '<Advanced|Normal><Turtle|Pocket|Computer><ID>' all within 2 characters (plus id)",
"If the computer already has a label and you want this script to assign a new one then you can run the script with the argument f",
}


local function genLabel()
	local advance -- is the computer an advanced golden computer?
	local _type -- is the computer a turtle, pocketPC or just a computer?
	
	if term.isColour() then -- advanced colour PC?
		advance = "A"
	else -- must be not advanced
		advance = "N"
	end

	
	if turtle then -- turtle?
		_type = "T"
	elseif pocket then -- pocketPC?
		_type = "P"
	elseif select(2, term.getSize()) == 13 then -- plethora neural interface? -- TODO: term sizes can change now, need to find a better way to do this. peripheral.find("neuralInterface") has been suggested but it doen't work if the neural interface has no other modules in it
		advance = "N" -- neural interfaces can only be advanced, and, as funny as 'AI' would be, that would be confusing if someone manages to make an AI in CC
		_type = "I"
	else -- must be normal computer
		_type = "C"
	end
	
	if commands then -- command computer?
		os.setComputerLabel("Com"..tostring(os.getComputerID()))
	else
		os.setComputerLabel(advance.._type..tostring(os.getComputerID())) -- append the id do that the computer has a unique label
	end
end

local function printArgs()
	print("Welcome to lupus590's automatic label setting script!")
	print(table.concat(description, "\n"))
end


-- main
local args = {...} or nil
if args[1] == nil then
	-- normal mode
	if os.getComputerLabel() == nil then
		genLabel()
	end
elseif type(args[1]) == "string" and (args[1]:upper() == "--FORCE" or args[1]:upper() == "-F" or args[1]:upper() == "F") then
	-- force a re-gen
	genLabel()
	print("Label set to "..os.getComputerLabel())
else
	printArgs();
end
