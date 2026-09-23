-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function ()
  hl.exec_cmd("awww-daemon &")
  -- SELECT 1 BAR
  -- hl.exec_cmd("qs -p .")
  hl.exec_cmd("waybar &")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Layan-cursors'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 36")
end)
