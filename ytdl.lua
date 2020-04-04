local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)
local width,height = 600,300
local clock = os.clock

function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
win = disp:AddWindow({
	ID = 'MyWin',
	WindowTitle = 'youtube-dl',
	Geometry = {100,100,width,height},
	Spacing = 15,
	Margin = 20,

	ui:VGroup{
	ID = 'root',
	ui:HGroup{
	ui:LineEdit{ ID = "inputurl",
					PlaceholderText = "Enter a video's url",
					Text = "",
					Weight = 1.5,
					MinimumSize = {150, 24} },
	ui:Button{ID='geturl', Text='Get Video', weight=1.5}
		},
	},

})



	itm=win:GetItems()
	resolve = Resolve()
	projectManager = resolve:GetProjectManager()
	project = projectManager:GetCurrentProject()
	mediapool = project:GetMediaPool()
	folder = mediapool:GetCurrentFolder()
	mediastorage=resolve:GetMediaStorage()
	mtdvol=mediastorage:GetMountedVolumes()
	dump(mtdvol)


function win.On.MyWin.Close(ev)
	disp:ExitLoop()
end

function win.On.geturl.Clicked(ev)
	url = tostring(itm.inputurl.Text)
	dump(url)
	lpath = tostring(mtdvol[1]).."/ytdl"
	dump(lpath)

	--[[ytbsh = lpath.."/S1P1.sh"
	editytb = assert(io.output(ytbsh))
	editytb:write("#!/bin/sh")
	editytb:write("\r\nyoutube-dl "..url.." -o "..lpath.."/ytdl/input.mp4")
	editytb:close()

	bull = os.execute("chmod +x "..ytbsh)
dump(bull)]]--
	ffmpegProgramPath = '/usr/local/bin/ffmpeg'
	ytdlProgramPath = '/usr/local/bin/youtube-dl'

	yttitlecmd=ytdlProgramPath.." --get-filename "..url
	--.." -o "..lpath.."/ytdl/input.mp4"
	
	titleproc=io.popen(yttitlecmd)
local output = titleproc:read('*all')
titleproc:close()
fname = string.gsub(output, "%.%w%w%w", "")
hname = string.gsub(fname, "\n","")
	ytcommand=ytdlProgramPath.." "..url.." -o \""..lpath.."/"..hname..".%(ext)s\""
dump("Attempting to download "..hname)

	propat=os.execute(ytcommand)
--	dump(yttitlecmd)
	--dump(propat)
--[[
	EncTable = {}
	ToEncode = assert(io.popen("ls "..lpath))
		for line in ToEncode:lines() do
			table.insert(EncTable,line)
		end
		ToEncode:close()

		for i,v in ipairs(EncTable) do
			titleform = string.gsub(v,"%p%w%w%w","")
			titleform2 = string.gsub(titleform,"%s","")
		--	EncodeCommand = ffmpegProgramPath.." -y -i \'"..lpath.."/"..v.."\' -c:v prores_ks -profile:v 0 -s 1280x720 -r 29.97 \""..titleform2..".mov\""
		--	print(EncodeCommand)

		end]]
	fpath = lpath.."/"..hname..".mp4"
	dump(fpath)
	mediastorage:AddItemListToMediaPool(fpath)

--	ffmpegcmd = ffmpegProgramPath.." -y -i "..lpath.."/ytdl/input.mp4".." -c:v prores_ks -profile:v 0 -s 1280x720 -r 29.97 output.mp4"
	--encode = os.execute(ffmpegcmd)
	--dump(ffmpegcmd)

	folder = mediapool:GetCurrentFolder()


end


			--	local newXml = "/Users/haus/Movies/Drawer/Cache/"..binName.."_"..tlName.."-"..b..".fcpxml"
						--	/Users/haus/Movies/Drawer/Cache
			--	tmpXML = assert(io.output(newXml))
			--	tmpXML:write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<!DOCTYPE fcpxml>\r\n<fcpxml version=\"1.8\"> \r\n	<resources>")


			--	tmpXML:seek("end")
			--	tmpXML:wr

win:Show()
disp:RunLoop()
win:Hide()