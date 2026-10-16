-- Port of karabiner/.config/karabiner/karabiner.json ("Windows style" profile).
--
-- Key codes are *physical* (ANSI names), exactly like Karabiner's key_code, so
-- on an AZERTY layout kc.w is the Z key, kc.q is the A key, kc["6"] is the - key.

local eventtap = hs.eventtap
local types = eventtap.event.types
local props = eventtap.event.properties

-- Marks events we post so the tap lets them through instead of remapping them again.
local SYNTHETIC = 0x4B415242

local kc = {
  a = 0, s = 1, f = 3, h = 4, g = 5, z = 6, x = 7, c = 8, v = 9,
  b = 11, q = 12, w = 13, e = 14, r = 15, y = 16, t = 17, equal_sign = 24, hyphen = 27,
  ["6"] = 22, ["0"] = 29, o = 31, u = 32, i = 34, l = 37, k = 40, n = 45,
  tab = 48, delete_or_backspace = 51,
  keypad_plus = 69, keypad_hyphen = 78, keypad_0 = 82,
  f3 = 99, f4 = 118, f5 = 96,
  left_arrow = 123, right_arrow = 124, down_arrow = 125, up_arrow = 126,
  -- Apple top-row media keys (sent instead of F3/F4 when fn is not held)
  mission_control = 160, spotlight = 177, launchpad = 131,
}

-- NX_DEVICE* bits, used to tell left modifiers from right ones
local LEFT_MASK = { ctrl = 0x1, shift = 0x2, cmd = 0x8, alt = 0x20 }

---------------------------------------------------------------------------
-- Application conditions (Lua patterns translated from Karabiner's regexes)
---------------------------------------------------------------------------

local terminals = {
  "^com%.apple%.Terminal$", "^com%.googlecode%.iterm2$", "^co%.zeit%.hyperterm$",
  "^co%.zeit%.hyper$", "^io%.alacritty$", "^org%.alacritty$",
  "^net%.kovidgoyal%.kitty$", "^com%.mitchellh%.ghostty$",
}

local remoteDesktops = {
  "^com%.microsoft%.rdc$", "^com%.microsoft%.rdc%.", "^net%.sf%.cord$",
  "^com%.thinomenon%.RemoteDesktopConnection$", "^com%.itap%-mobile%.qmote$",
  "^com%.nulana%.remotixmac$", "^com%.p5sys%.jump%.mac%.viewer$",
  "^com%.p5sys%.jump%.mac%.viewer%.", "^com%.teamviewer%.TeamViewer$",
  "^com%.vmware%.horizon$", "^com%.2X%.Client%.Mac$",
  "^com%.OpenText%.Exceed%-TurboX%-Client$", "^com%.realvnc%.vncviewer$",
  "^com%.citrix%.receiver%.icaviewer", "^com%.vmware%.fusion$", "^com%.vmware%.view$",
  "^com%.parallels%.desktop$", "^com%.parallels%.vm$", "^com%.parallels%.desktop%.console$",
  "^org%.virtualbox%.app%.VirtualBoxVM$", "^com%.citrix%.XenAppViewer$",
  "^com%.vmware%.proxyApp%.", "^com%.parallels%.winapp%.", "^com%.utmapp%.UTM$",
}

local emacs = {
  "^org%.gnu%.Emacs$", "^org%.gnu%.AquamacsEmacs$", "^org%.gnu%.Aquamacs$",
  "^org%.pqrs%.unknownapp%.conkeror$",
}

local browsers = {
  "^org%.mozilla%.firefox$", "^org%.mozilla%.firefoxdeveloperedition$",
  "^org%.mozilla%.nightly$", "^com%.microsoft%.Edge", "^com%.microsoft%.edgemac",
  "^com%.google%.Chrome$", "^com%.brave%.Browser$", "^com%.apple%.Safari$",
}

local function concat(...)
  local out = {}
  for _, list in ipairs({ ... }) do
    for _, v in ipairs(list) do out[#out + 1] = v end
  end
  return out
end

-- Karabiner's two exclusion lists: remote desktops/VMs, and those plus terminals/emacs
local notRemote = { unless = remoteDesktops }
local notRemoteOrTerminal = { unless = concat(remoteDesktops, terminals, emacs) }
local inTerminal = { only = terminals }
local inBrowser = { only = browsers }

local frontApp = hs.application.frontmostApplication()
local frontBundleID = frontApp and frontApp:bundleID() or ""

appWatcher = hs.application.watcher.new(function(_, event, app)
  if event == hs.application.watcher.activated and app then
    frontBundleID = app:bundleID() or ""
  end
end):start()

local function matchesAny(patterns)
  for _, p in ipairs(patterns) do
    if frontBundleID:find(p) then return true end
  end
  return false
end

local function conditionHolds(cond)
  if not cond then return true end
  if cond.only then return matchesAny(cond.only) end
  if cond.unless then return not matchesAny(cond.unless) end
  return true
end

---------------------------------------------------------------------------
-- Rules, in Karabiner order (first match wins)
--
-- from = { key, mods = { mandatory... }, any = true|nil }
--   mods: "ctrl" / "cmd" / "alt" / "shift" match either side,
--         "left_ctrl" / "left_cmd" / "left_alt" / "left_shift" only the left one.
--   any:  Karabiner's optional = ["any"]; extra modifiers are allowed and kept.
-- to   = { key, mods = { generic modifiers } }
---------------------------------------------------------------------------

local rules = {
  -- Change Cmd+Tab to Option+Tab
  { from = { kc.tab, mods = { "left_cmd" } }, to = { kc.tab, mods = { "alt" } } },
  -- PC-Style Control+Delete/Backspace
  { from = { kc.delete_or_backspace, mods = { "ctrl" }, any = true },
    to = { kc.delete_or_backspace, mods = { "alt" } }, cond = notRemote },
  -- Tmux fix split pane
  { from = { kc.h, mods = { "cmd" }, any = true }, to = { kc.h, mods = { "cmd" } }, cond = inTerminal },
  -- Paste / Copy in Terminal [Ctrl-Shift-V / Ctrl-Shift-C]
  { from = { kc.v, mods = { "left_ctrl", "left_shift" }, any = true }, to = { kc.v, mods = { "cmd" } }, cond = inTerminal },
  { from = { kc.c, mods = { "left_ctrl", "left_shift" }, any = true }, to = { kc.c, mods = { "cmd" } }, cond = inTerminal },
  -- PC-Style Find
  { from = { kc.f, mods = { "ctrl" }, any = true }, to = { kc.f, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.g, mods = { "ctrl" }, any = true }, to = { kc.g, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Control+Up/Down/Left/Right
  { from = { kc.left_arrow, mods = { "ctrl" }, any = true }, to = { kc.left_arrow, mods = { "alt" } }, cond = notRemoteOrTerminal },
  { from = { kc.right_arrow, mods = { "ctrl" }, any = true }, to = { kc.right_arrow, mods = { "alt" } }, cond = notRemoteOrTerminal },
  { from = { kc.up_arrow, mods = { "ctrl" }, any = true }, to = { kc.up_arrow, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.down_arrow, mods = { "ctrl" }, any = true }, to = { kc.down_arrow, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Bold/Italic/Underline
  { from = { kc.b, mods = { "ctrl" }, any = true }, to = { kc.b, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.i, mods = { "ctrl" }, any = true }, to = { kc.i, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.u, mods = { "ctrl" }, any = true }, to = { kc.u, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Browser Zoom (Ctrl+Plus/Minus/0); kc["6"] is the - key on AZERTY
  { from = { kc["6"], mods = { "ctrl" }, any = true }, to = { kc.hyphen, mods = { "cmd" } }, cond = inBrowser },
  { from = { kc.keypad_hyphen, mods = { "ctrl" }, any = true }, to = { kc.keypad_hyphen, mods = { "cmd" } }, cond = inBrowser },
  { from = { kc.equal_sign, mods = { "ctrl" }, any = true }, to = { kc.equal_sign, mods = { "cmd" } }, cond = inBrowser },
  { from = { kc.keypad_plus, mods = { "ctrl" }, any = true }, to = { kc.keypad_plus, mods = { "cmd" } }, cond = inBrowser },
  { from = { kc["0"], mods = { "ctrl" }, any = true }, to = { kc["0"], mods = { "cmd" } }, cond = inBrowser },
  { from = { kc.keypad_0, mods = { "ctrl" }, any = true }, to = { kc.keypad_0, mods = { "cmd" } }, cond = inBrowser },
  -- PC-Style Control+K
  { from = { kc.k, mods = { "ctrl" }, any = true }, to = { kc.k, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Browser open location (Ctrl+L)
  { from = { kc.l, mods = { "ctrl" }, any = true }, to = { kc.l, mods = { "cmd" } }, cond = inBrowser },
  -- PC-Style Quit Application (Cmd+F4 to Cmd+Q); kc.a is the Q key on AZERTY.
  -- The built-in keyboard sends Spotlight instead of F4 when fn is not held.
  { from = { kc.f4, mods = { "left_cmd" } }, to = { kc.a, mods = { "cmd" } }, cond = notRemote },
  { from = { kc.spotlight, mods = { "left_cmd" } }, to = { kc.a, mods = { "cmd" } }, cond = notRemote },
  -- PC-Style Reload (Ctrl+R, F5)
  { from = { kc.r, mods = { "ctrl" }, any = true }, to = { kc.r, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.f5, any = true }, to = { kc.r, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Open / New Tab
  { from = { kc.o, mods = { "ctrl" }, any = true }, to = { kc.o, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.t, mods = { "ctrl" }, any = true }, to = { kc.t, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Close Window (AZERTY Ctrl+W)
  { from = { kc.z, mods = { "ctrl" }, any = true }, to = { kc.z, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style New
  { from = { kc.n, mods = { "ctrl" }, any = true }, to = { kc.n, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Lock Screen (Option+L to Ctrl+Cmd+Q)
  { from = { kc.l, mods = { "left_alt" } }, to = { kc.a, mods = { "ctrl", "cmd" } }, cond = notRemote },
  -- PC-Style Save
  { from = { kc.s, mods = { "ctrl" }, any = true }, to = { kc.s, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Redo (Ctrl+Y to Cmd+Shift+Z on AZERTY)
  { from = { kc.y, mods = { "ctrl" }, any = true }, to = { kc.w, mods = { "cmd", "shift" } }, cond = notRemoteOrTerminal },
  -- PC-Style Undo (AZERTY Ctrl+Z)
  { from = { kc.w, mods = { "ctrl" }, any = true }, to = { kc.w, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Select-All (AZERTY Ctrl+A)
  { from = { kc.q, mods = { "ctrl" }, any = true }, to = { kc.q, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  -- PC-Style Copy/Paste/Cut
  { from = { kc.c, mods = { "ctrl" }, any = true }, to = { kc.c, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.v, mods = { "ctrl" }, any = true }, to = { kc.v, mods = { "cmd" } }, cond = notRemoteOrTerminal },
  { from = { kc.x, mods = { "ctrl" }, any = true }, to = { kc.x, mods = { "cmd" } }, cond = notRemoteOrTerminal },
}

-- fn_function_keys: F3 and F4 media actions do nothing
local swallowed = { [kc.mission_control] = true, [kc.spotlight] = true, [kc.launchpad] = true }

---------------------------------------------------------------------------
-- Engine
---------------------------------------------------------------------------

local GENERIC = { "cmd", "alt", "shift", "ctrl" }

local rulesByKey = {}
for _, rule in ipairs(rules) do
  local key = rule.from[1]
  rulesByKey[key] = rulesByKey[key] or {}
  table.insert(rulesByKey[key], rule)
end

-- Returns the modifiers to send if the event matches, nil otherwise
local function match(rule, flags, rawFlags)
  local required = {}
  for _, m in ipairs(rule.from.mods or {}) do
    local generic = m:gsub("^left_", "")
    if not flags[generic] then return nil end
    if generic ~= m then
      if rawFlags() & LEFT_MASK[generic] == 0 then return nil end
    end
    required[generic] = true
  end

  local out = {}
  for _, m in ipairs(GENERIC) do
    if flags[m] and not required[m] then
      if not rule.from.any then return nil end
      out[m] = true
    end
  end
  for _, m in ipairs(rule.to.mods or {}) do out[m] = true end
  if flags.fn then out.fn = true end

  local list = {}
  for m in pairs(out) do list[#list + 1] = m end
  return list
end

local function post(mods, key, isDown)
  local e = eventtap.event.newKeyEvent(mods, key, isDown)
  e:setProperty(props.eventSourceUserData, SYNTHETIC)
  return e
end

-- Key code -> { key, mods } for remapped keys still held down,
-- so the key up goes out as the same key the key down was sent as.
local held = {}

local function onKey(event)
  if event:getProperty(props.eventSourceUserData) == SYNTHETIC then return false end

  local code = event:getKeyCode()
  local isDown = event:getType() == types.keyDown

  if not isDown and held[code] then
    local h = held[code]
    held[code] = nil
    return true, { post(h.mods, h.key, false) }
  end

  if swallowed[code] and not event:getFlags().cmd then return true end

  local candidates = rulesByKey[code]
  if not candidates then return false end

  local flags = event:getFlags()
  local raw
  local function rawFlags()
    raw = raw or event:getRawEventData().CGEventData.flags
    return raw
  end

  for _, rule in ipairs(candidates) do
    if conditionHolds(rule.cond) then
      local mods = match(rule, flags, rawFlags)
      if mods then
        if not isDown then return true, { post(mods, rule.to[1], false) } end
        held[code] = { key = rule.to[1], mods = mods }
        return true, { post(mods, rule.to[1], true) }
      end
    end
  end
  return false
end

-- Open in new tab: Ctrl+click to Cmd+click
local function onClick(event)
  local flags = event:getFlags()
  if flags.ctrl then
    flags.ctrl = nil
    flags.cmd = true
    event:setFlags(flags)
  end
  return false
end

keyTap = eventtap.new({ types.keyDown, types.keyUp }, onKey):start()
clickTap = eventtap.new({ types.leftMouseDown, types.leftMouseUp }, onClick):start()

-- macOS disables taps whose callback is slow; turn them back on
tapWatchdog = hs.timer.doEvery(5, function()
  if not keyTap:isEnabled() then keyTap:start() end
  if not clickTap:isEnabled() then clickTap:start() end
end)

---------------------------------------------------------------------------
-- Per-device simple modifications, done in the HID driver with hidutil
---------------------------------------------------------------------------

local hid = {
  fn = 0xFF00000003,
  left_control = 0x7000000E0,
  right_control = 0x7000000E4,
  right_option = 0x7000000E6,
  right_command = 0x7000000E7,
}

local devices = {
  -- Built-in keyboard: swap fn and left control, right command -> right option -> right control
  {
    matching = '{"Built-In":true}',
    map = {
      { hid.fn, hid.left_control },
      { hid.left_control, hid.fn },
      { hid.right_command, hid.right_option },
      { hid.right_option, hid.right_control },
    },
  },
  -- Corsair keyboard: right option -> right command
  {
    matching = '{"VendorID":6940,"ProductID":6985}',
    map = { { hid.right_option, hid.right_command } },
  },
}

local function applyHidMappings()
  for _, device in ipairs(devices) do
    local entries = {}
    for _, m in ipairs(device.map) do
      entries[#entries + 1] = string.format(
        '{"HIDKeyboardModifierMappingSrc":%d,"HIDKeyboardModifierMappingDst":%d}', m[1], m[2])
    end
    local mapping = '{"UserKeyMapping":[' .. table.concat(entries, ",") .. ']}'
    hs.task.new("/usr/bin/hidutil", nil,
      { "property", "--matching", device.matching, "--set", mapping }):start()
  end
end

applyHidMappings()

-- Mappings are lost when a keyboard is reconnected
usbWatcher = hs.usb.watcher.new(function(event)
  if event.eventType == "added" then hs.timer.doAfter(1, applyHidMappings) end
end):start()

hs.alert.show("Hammerspoon config loaded")
