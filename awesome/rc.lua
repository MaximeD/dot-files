-- Standard awesome library
require("awful")
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")
-- User libraries
vicious = require("vicious")
require("scratch")

-- Variable definitions
altkey = "Mod1"
modkey = "Mod4"

home   = os.getenv("HOME")
exec   = awful.util.spawn
sexec  = awful.util.spawn_with_shell
scount = screen.count()

browser    = "chromium --audio-buffer-size = 8192"
mail       = "thunderbird"
terminal   = "urxvt"
editor     = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Beautiful theme
beautiful.init(home .. "/.config/awesome/zenburn.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.floating
}

-- Shifty configured tags.
shifty.config.tags = {
  term = {
    layout    = awful.layout.suit.tile,
    mwfact    = 0.60,
    exclusive = true,
    position  = 1,
    init      = true,
  },
  ed = {
    layout      = awful.layout.suit.tile,
    position    = 2,
    exclusive   = true,
    max_clients = 1
  },
  pdf = {
    layout      = awful.layout.suit.tile,
    exclusive   = true,
    position    = 2,
    max_clients = 1,
  },
  web = {
    layout      = awful.layout.suit.tile.bottom,
    mwfact      = 0.65,
    exclusive   = true,
    max_clients = 1,
    position    = 4,
  },
  mail = {
    layout      = awful.layout.suit.tile,
    mwfact      = 0.55,
    exclusive   = true,
    position    = 5,
    screen      = 2,
    max_clients = 1,
  },
  media = {
    layout    = awful.layout.suit.floating,
    exclusive = false,
    position  = 8,
  },
  office = {
    layout   = awful.layout.suit.floating,
    position = 9,
  },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
  {
    match = {
      "urxvt"
    },
    tag = "term"
  },
  {
    match = {
      "gvim",
      "emacs"
    },
    tag = "ed"
  },
  {
    match = {
      "evince",
      "zathura",
    },
    tag = "pdf"
  },
  {
    match = {
      "Navigator",
      "Chromium",
      "Firefox"
    },
    tag = "web"
  },
  {
    match = {
      "Thunderbird",
      "mutt"
    },
    tag = "mail"
  },
  {
    match = {
      "thunar"
    },
    tag = "media"
  },
  {
    match = {
      "*libreoffice.*"
    },
    tag = "office"
  },
  {
    match = {
      "Mplayer.*",
      "Xine",
      "Vlc",
    	"Mirage",
    	"gimp",
    	"easytag",
    },
    tag = "media",
    nopopup = true,
  },
  {
    match = {
      "MPlayer",
    	"Xine",
    	"Vlc",
    	"Gnuplot",
    	"galculator",
      "thunar",
    },
    float = true,
  },
  {
    match = {
      terminal,
    },
    honorsizehints = false,
    slave = true,
  },
  {
    match = {
      "exe",
      "Flash"
    },
    fullscreen = true,
    tag = "web",
  },
  {
    match = {""},
    buttons = awful.util.table.join(
    awful.button({},        1, function (c)
      client.focus = c
      c:raise()
    end),
    awful.button({modkey},  1, function(c)
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({modkey},  3, awful.mouse.client.resize)
    )
  },
}

-- SHIFTY: default tag creation rules
-- parameter description
shifty.config.defaults = {
  layout = awful.layout.suit.tile.bottom,
  ncol           = 1,
  mwfact         = 0.60,
  floatBars      = true,
  guess_name     = true,
  guess_position = true,
}

-- Wibox

-- Widgets configuration

-- Reusable separator
separator       = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_sep)

-- CPU usage and temperature
cpuicon         = widget({ type = "imagebox" })
cpuicon.image   = image(beautiful.widget_cpu)
-- Initialize widgets
cpugraph        = awful.widget.graph()
tzswidget       = widget({ type = "textbox" })
-- Graph properties
cpugraph:set_width(40):set_height(14)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_gradient_angle(0):set_gradient_colors({
  beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
})

-- Register widgets
vicious.register(cpugraph,  vicious.widgets.cpu, "$1")
vicious.register(tzswidget, vicious.widgets.thermal, " $1C", 19, "thermal_zone0")

-- Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
-- Initialize widget
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_vertical(true):set_ticks(true)
membar:set_height(12):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_gradient_colors({
  beautiful.fg_widget, beautiful.fg_center_widget, beautiful.fg_end_widget
})
-- Register widget
vicious.register(membar, vicious.widgets.mem, "$1", 13)

-- Network usage
dnicon        = widget({ type = "imagebox" })
upicon        = widget({ type = "imagebox" })
dnicon.image  = image(beautiful.widget_net)
upicon.image  = image(beautiful.widget_netup)
-- Initialize widget
netwidget     = widget({ type = "textbox" })
-- Register widget
vicious.register(netwidget, vicious.widgets.net, '<span color="'
		 .. beautiful.fg_netdn_widget ..'">${wlan0 down_kb}</span> <span color="'
		 .. beautiful.fg_netup_widget ..'">${wlan0 up_kb}</span>', 3)

-- Date and time
dateicon        = widget({ type = "imagebox" })
dateicon.image  = image(beautiful.widget_date)
-- Initialize widget
datewidget      = widget({ type = "textbox" })

-- Register widget
vicious.register(datewidget, vicious.widgets.date, "%R", 61)
-- Register buttons

-- System tray
systray = widget({ type = "systray" })

-- moc player
function hook_moc()
  moc_info  = io.popen("mocp -i"):read("*all")
  moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
  if moc_state == "PLAY" or moc_state == "PAUSE" then
    moc_artist  = string.gsub(string.match(moc_info, "Artist: %C*"), "Artist: ","")
    moc_title   = string.gsub(string.match(moc_info, "SongTitle: %C*"), "SongTitle: ","")
    moc_artist  = string.gsub(moc_artist, "&", "&amp;")
    moc_title   = string.gsub(moc_title,  "&", "&amp;")
    moc_icon    = '<span color="#4E99E6">♫ </span>'
    if moc_artist == "" then
      moc_artist = "unknown artist"
    end
    if moc_title == "" then
      moc_title = "unknown title"
    end
    moc_string = moc_icon .. moc_artist .. " - " .. moc_title
    if moc_state == "PAUSE" then
      moc_string = " [[ " .. moc_string .. " ]]"
    end
  else
    moc_string = "" --"-- MOC not playing --"
  end                                                                                                                                  
  mocwidget.text = moc_string
end

function pause_moc()
    moc_info = io.popen("mocp -i"):read("*all")
    moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
    if moc_state == "PLAY" then
        awful.util.spawn("mocp -P")
    elseif moc_state == "PAUSE" then
        awful.util.spawn("mocp -U")
    end
end

function next_moc()
  awful.util.spawn("mocp -f")
end

function prev_moc()
  awful.util.spawn("mocp -r")
end

-- Moc widget timer

mytimermoc = timer { timeout = 1 }
mytimermoc:add_signal("timeout", function() hook_moc() end)
mytimermoc:start()

-- moc widget
mocwidget = widget({ type = "textbox", name = "mocwidget", align = "right" }) 
mocwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () pause_moc()  end),
  awful.button({ }, 5, function () prev_moc()   end),
  awful.button({ }, 4, function () next_moc()   end)))
    
awful.widget.layout.margins[mocwidget] = { right = 9 }


-- Wibox initialisation
mywibox     = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist   = {}
mytaglist.buttons = awful.util.table.join(
  awful.button({ },        1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ },        3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ },        4, awful.tag.viewnext),
  awful.button({ },        5, awful.tag.viewprev
))

for s = 1, scount do
  -- Create a promptbox
  mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
  -- Create a layoutbox
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
		awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
		awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
	))
  
  -- Create the taglist
  mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({
    screen       = s,
    fg           = beautiful.fg_normal, height   = 12,
		bg           = beautiful.bg_normal, position = "top",
		border_color = beautiful.border_focus,
		border_width = beautiful.border_width
  })

   -- Add widgets to the wibox
   mywibox[s].widgets = {
      {   mytaglist[s], mylayoutbox[s], separator, mypromptbox[s],
      	  ["layout"] = awful.widget.layout.horizontal.leftright
      },
      s == 1 and systray or nil,
      separator, datewidget,
      separator, upicon,        netwidget, dnicon,
      separator, membar.widget, memicon,
      separator, tzswidget,     cpugraph.widget, cpuicon,
      separator, ["layout"] = awful.widget.layout.horizontal.rightleft,
      mocwidget
   }
end


-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()

-- Mouse bindings
root.buttons(awful.util.table.join(
		awful.button({}, 4, awful.tag.viewnext),
		awful.button({}, 5, awful.tag.viewprev)
	  ))

-- Key bindings
globalkeys = awful.util.table.join(
  -- Applications
  awful.key({ modkey }, "e", function () exec("emacs") end),
  awful.key({ modkey }, "v", function () exec("gvim") end),
  awful.key({ modkey }, "t", function () exec("thunar", false) end),
  awful.key({ modkey }, "f", function () exec("firefox") end),
  awful.key({ modkey }, "w", function () exec(browser) end),
  awful.key({ modkey }, "u", function () exec("urxvtc -e tmux") end),

  -- Tag browsing
  awful.key({ altkey }, "n",   awful.tag.viewnext),
  awful.key({ altkey }, "p",   awful.tag.viewprev),
  awful.key({ modkey }, "Tab", awful.tag.history.restore),

  -- Prompt menus
  awful.key({ altkey }, "F2", function ()
    awful.prompt.run({ prompt = "Run: " }, mypromptbox[mouse.screen].widget,
    function (...)
      mypromptbox[mouse.screen].text = exec(unpack(arg), false)
    end,
    awful.completion.shell, awful.util.getdir("cache") .. "/history")
  end),
  
  awful.key({ altkey }, "F3", function ()
    awful.prompt.run({ prompt = "Web: " }, mypromptbox[mouse.screen].widget,
    function (command)
      sexec("chromium 'www.google.com/search?q="..command.."'")
      --                awful.tag.viewonly(tags[scount][3])
    end)
  end),
  
  awful.key({ altkey }, "F4", function ()
    awful.prompt.run({ prompt = "Lua: " }, mypromptbox[mouse.screen].widget,
    awful.util.eval, nil, awful.util.getdir("cache") .. "/history_eval")
  end),

  -- Awesome controls
  awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
  end),

  awful.key({ modkey, "Shift" }, "q", awesome.quit),
  awful.key({ modkey, "Shift" }, "r", function ()
    mypromptbox[mouse.screen].text = awful.util.escape(awful.util.restart())
  end),

  -- Shifty: keybindings specific to shifty
  awful.key({modkey, "Shift"},    "d", shifty.del),       -- delete a tag
  awful.key({modkey},             "a", shifty.add),       -- create a new tag
  awful.key({modkey},             "r", shifty.rename),    -- rename a tag
  awful.key({modkey, "Shift"},    "n", shifty.send_prev), -- client to prev tag
  awful.key({modkey},             "n", shifty.send_next), -- client to next tag
  awful.key({modkey, "Control"},  "n", function()
    local t = awful.tag.selected()
		local s = awful.util.cycle(screen.count(), t.screen + 1)
    awful.tag.history.restore()
		t = shifty.tagtoscr(s, t)
    awful.tag.viewonly(t)
  end),

  awful.key({modkey, "Shift"},  "a", function()
    shifty.add({nopopup = true})
  end),

  awful.key({modkey,},          "j", function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({modkey,},          "k", function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),

  -- Layout manipulation
  awful.key({modkey, "Shift"},    "j", function() awful.client.swap.byidx(1) end),
  awful.key({modkey, "Shift"},    "k", function() awful.client.swap.byidx(-1) end),
  awful.key({modkey, "Control"},  "j", function() awful.screen.focus(1)   end),
  awful.key({modkey, "Control"},  "k", function() awful.screen.focus(-1)  end),
  awful.key({modkey,},            "u", awful.client.urgent.jumpto),

   -- Standard program
   awful.key({modkey,           } , "l",      function() awful.tag.incmwfact(0.05)      end),
   awful.key({modkey,           } , "h",      function() awful.tag.incmwfact(-0.05)     end),
   awful.key({modkey, "Shift"   } , "h",      function() awful.tag.incnmaster(1)        end),
   awful.key({modkey, "Shift"   } , "l",      function() awful.tag.incnmaster(-1)       end),
   awful.key({modkey, "Control" } , "h",      function() awful.tag.incncol(1)           end),
   awful.key({modkey, "Control" } , "l",      function() awful.tag.incncol(-1)          end),
   awful.key({modkey,           } , "space",  function() awful.layout.inc(layouts, 1)   end),
   awful.key({modkey, "Shift"   } , "space",  function() awful.layout.inc(layouts, -1)  end)
)


-- Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
clientkeys = awful.util.table.join(
  awful.key({modkey,},           "f",      function(c) c.fullscreen = not c.fullscreen  end),
  awful.key({modkey, "Shift"},   "c",      function(c) c:kill() end),
  awful.key({modkey, "Control"}, "space",  awful.client.floating.toggle),
  awful.key({modkey, "Control"}, "Return", function(c) c:swap(awful.client.getmaster()) end),
  awful.key({modkey,},           "o", awful.client.movetoscreen),
   --    awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
  awful.key({modkey},            "t", awful.client.togglemarked),
  awful.key({modkey,},           "m",	     function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys  = clientkeys
shifty.config.modkey      = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
  globalkeys = awful.util.table.join(globalkeys,

  awful.key({modkey},                     i, function()
    local t =  awful.tag.viewonly(shifty.getpos(i))
  end),

  awful.key({modkey, "Control"},          i, function()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end),

  awful.key({modkey, "Control", "Shift"}, i, function()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end),

  -- move clients to other tags
	awful.key({modkey, "Shift"},            i, function()
    if client.focus then
      t = shifty.getpos(i)
      awful.client.movetotag(t)
      awful.tag.viewonly(t)
    end
  end)
  )
end

-- Set keys
root.keys(globalkeys)

-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_focus
  end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_normal
  end
end)


-- Client manipulation
clientkeys = awful.util.table.join(
   awful.key({ modkey }, "c", function (c) c:kill()                             end ),
   awful.key({ modkey }, "d", function (c) scratch.pad.set(c, 0.60, 0.60, true) end ),
   awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen      end ),
   awful.key({ modkey }, "m", function (c)
     c.maximized_horizontal = not c.maximized_horizontal
     c.maximized_vertical   = not c.maximized_vertical
   end),
   awful.key({ modkey },            "o",                 awful.client.movetoscreen),
   awful.key({ modkey },            "Next",  function () awful.client.moveresize( 20,  20, -40, -40)  end),
   awful.key({ modkey },            "Prior", function () awful.client.moveresize(-20, -20,  40,  40)  end),
   awful.key({ modkey },            "Down",  function () awful.client.moveresize(  0,  20,   0,   0)  end),
   awful.key({ modkey },            "Up",    function () awful.client.moveresize(  0, -20,   0,   0)  end),
   awful.key({ modkey },            "Left",  function () awful.client.moveresize(-20,   0,   0,   0)  end),
   awful.key({ modkey },            "Right", function () awful.client.moveresize( 20,   0,   0,   0)  end),
   awful.key({ modkey, "Control" }, "r",     function (c) c:redraw()                                  end),
   awful.key({ modkey, "Shift"   }, "0",     function (c) c.sticky = not c.sticky                     end),
   awful.key({ modkey, "Shift"   }, "m",     function (c) c:swap(awful.client.getmaster())            end),
   awful.key({ modkey, "Shift"   }, "c",     function (c) exec("kill -CONT " .. c.pid)                end),
   awful.key({ modkey, "Shift"   }, "s",     function (c) exec("kill -STOP " .. c.pid)                end),
   awful.key({ modkey, "Shift"   }, "t",     function (c)
     if   c.titlebar then awful.titlebar.remove(c)
     else awful.titlebar.add(c, { modkey = modkey }) end
   end),
   awful.key({ modkey, "Shift" }, "f", function (c) if awful.client.floating.get(c)
     then awful.client.floating.delete(c);    awful.titlebar.remove(c)
     else awful.client.floating.set(c, true); awful.titlebar.add(c) end
   end)
)
