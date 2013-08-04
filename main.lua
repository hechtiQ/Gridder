local addonInfo, data = ...
Gridder = {}
local context = UI.CreateContext("gridder")
local gridExists = false
local gridVisible = false
local lineList = {}

function Gridder.commandhandler(commandline)
	local x, y = commandline:match("(%d+) (%d+)")
	x, y = tonumber(x), tonumber(y)
	if (not x or not y == 0) and gridExists == false then
		print("Gridder Commands")
		print("Usage: /gridder resolutionX resolutionY")
		print("Options:")
		--print("-c {color}")
		--print("-l {amount of lines}")
		--print("Options:")
		--print("Options:")
	elseif gridExists == true then
		gridVisible = not gridVisible
		Gridder.setVisible(gridVisible)
		
		
	else
		Gridder.drawCross(x, y, {255,255,0,1},5)
		Gridder.drawVerticalLines(100,x/100,{255,255,0,1},y,1)
		Gridder.drawHorizontalLines(100,y/100,{255,255,0,1},1,x)
		gridExists = true
		gridVisible = true
	end

end
function Gridder.drawVerticalLines(amountOfLines, margin, color, height, width)
	local counter = 0
	local xCoord = 0
	while counter <= amountOfLines do
		xCoord = xCoord + margin
		local line = UI.CreateFrame("Frame","line"..counter,context)
		line:SetLayer(-1)
		line:SetHeight(height)
		line:SetWidth(width)
		line:SetPoint("TOPCENTER",context,"TOPLEFT", xCoord,0)
		line:SetBackgroundColor(color[1],color[2],color[3],color[4])
		line:SetVisible(true)
		table.insert(lineList, line)
		counter = counter + 1
	end
end

function Gridder.drawHorizontalLines(amountOfLines, margin, color, height, width)
	local counter = 0
	local xCoord = 0
	while counter <= amountOfLines do
		xCoord = xCoord + margin
		local line = UI.CreateFrame("Frame","line"..counter,context)
		line:SetLayer(-1)
		line:SetHeight(height)
		line:SetWidth(width)
		line:SetPoint("LEFTCENTER",context,"TOPLEFT",0,xCoord)
		line:SetBackgroundColor(color[1],color[2],color[3],color[4])
		line:SetVisible(true)
		table.insert(lineList, line)
		counter = counter + 1
	end
end

function Gridder.drawCross(x,y, color, width)
	local vertLine = UI.CreateFrame("Frame","line",context)
	vertLine:SetLayer(-1)
	vertLine:SetHeight(y)
	vertLine:SetWidth(width)
	vertLine:SetPoint("TOPCENTER",context,"TOPLEFT",x/2,0)
	vertLine:SetBackgroundColor(color[1],color[2],color[3],color[4])
	vertLine:SetVisible(true)
	local horLine = UI.CreateFrame("Frame","line",context)
	horLine:SetLayer(-1)
	horLine:SetHeight(width)
	horLine:SetWidth(x)
	horLine:SetPoint("CENTER",context,"TOPLEFT",x/2,y/2)
	horLine:SetBackgroundColor(color[1],color[2],color[3],color[4])
	horLine:SetVisible(true)
		table.insert(lineList, vertLine)
		table.insert(lineList, horLine)
end

function Gridder.setVisible(bool)
	for k,v in pairs(lineList) do
		v:SetVisible(bool)
	end
end

function Gridder.main()
table.insert(Command.Slash.Register("gridder"), {Gridder.commandhandler,addonInfo.identifier , "gridder"})
	

end

Gridder.main()


