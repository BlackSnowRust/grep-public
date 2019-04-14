--Notification panel
--Settings (Clienside only.)

local RepPanelSettings = {
  PanelLifeTime = 1.7, --How long will the panel last before fading out, in seconds. (The longer you make it the higher chance of it mixing in with the other panels.)
  PanelIconNT = "playermngr/flag.png", --Icon for neutral rep. Recommended 128x128 .png images for ALL icons.
  PanelIconBE = "playermngr/winged-heart.png", --Benefactor icon.
  PanelIconAN = "playermngr/human-skull.png", --Antagonist icon.
  PanelTextFont = "GModNotify", --The font you want to use. It is recommended to keep it as it is right now.
  PanelPopUpSound = "garrysmod/ui_return.wav" --The sound that plays when the panel pops up.
}

--The code
net.Receive( "RepClientStuff", function(attacker)

local NotifyPanelRep = vgui.Create( "DNotify" )
NotifyPanelRep:SetPos( 15, 15 )
NotifyPanelRep:SetSize( 150, 50 )
NotifyPanelRep:SetLife(RepPanelSettings.PanelLifeTime)

--The dock, color and transparency
local BGRep = vgui.Create( "DPanel", NotifyPanelRep )
BGRep:Dock( FILL )
BGRep:SetBackgroundColor( Color( 64, 64, 64, 150 ) )

--The reputation icon for the player, sizes, and background
local ImageRep = vgui.Create( "DImage", BGRep )
  if LocalPlayer():GetNWInt('RepAmount') == 0 then
    ImageRep:SetPos( 11, 3 )
    ImageRep:SetSize( 42, 42 )
    ImageRep:SetImage( RepPanelSettings.PanelIconNT )
  elseif LocalPlayer():GetNWInt('RepAmount') >= 0 then
    ImageRep:SetPos( 8, 3 )
    ImageRep:SetSize( 42, 42 )
    ImageRep:SetImage( RepPanelSettings.PanelIconBE )
  elseif LocalPlayer():GetNWInt('RepAmount') <= 0 then
    ImageRep:SetPos( 8, 3 )
    ImageRep:SetSize( 42, 42 )
    ImageRep:SetImage( RepPanelSettings.PanelIconAN )
  end
--The message, depending on your rep the color and text might change!
local LabelRep = vgui.Create( "DLabel", BGRep )
  LabelRep:SetPos( 57, 1.8 )
  LabelRep:SetSize( 110, 50 )
  if LocalPlayer():GetNWInt('RepAmount') == 0 then
      LabelRep:SetText('Neutral')
      LabelRep:SetTextColor( Color( 255, 255, 255 ) )
    elseif LocalPlayer():GetNWInt('RepAmount') >= 0 then
      LabelRep:SetTextColor( Color( 0, 150, 0 ) )
      LabelRep:SetText( 'Benefactor: '..LocalPlayer():GetNWInt('RepAmount') )
    elseif LocalPlayer():GetNWInt('RepAmount') <= 0 then
      LabelRep:SetText( 'Antagonist: '..LocalPlayer():GetNWInt('RepAmount') )
      LabelRep:SetTextColor( Color( 150, 0, 0 ) )
  end
LabelRep:SetFont( RepPanelSettings.PanelTextFont )
LabelRep:SetWrap( true )
surface.PlaySound( RepPanelSettings.PanelPopUpSound )
NotifyPanelRep:AddItem( BGRep )

end)

/*net.Receive( "RepClientDown", function(attacker)
-- Notification panel
local RepDownArrowNotif = vgui.Create( "DNotify" )
RepDownArrowNotif:SetPos( 168, 15 )
RepDownArrowNotif:SetSize( 50, 50 )

-- Gray background panel
local BackGroundDownArrow = vgui.Create( "DPanel", RepDownArrowNotif )
BackGroundDownArrow:Dock( FILL )
BackGroundDownArrow:SetBackgroundColor( Color( 64, 64, 64, 150 ) )

-- Image of Dr. Kleiner ( parented to background panel )
local DownArrowImage = vgui.Create( "DImage", BackGroundDownArrow )
DownArrowImage:SetPos( 5, 5 )
DownArrowImage:SetSize( 42, 42 )
DownArrowImage:SetImage( "playermngr/chevron-sign-down.png" )

RepDownArrowNotif:AddItem( BackGroundDownArrow )
end)*/

/*local RepDownArrowNotif = vgui.Create( "DNotify" )
RepDownArrowNotif:SetPos( 168, 15 )
RepDownArrowNotif:SetSize( 50, 50 )

-- Gray background panel
local BackGroundDownArrow = vgui.Create( "DPanel", RepDownArrowNotif )
BackGroundDownArrow:Dock( FILL )
BackGroundDownArrow:SetBackgroundColor( Color( 64, 64, 64, 150 ) )

-- Image of Dr. Kleiner ( parented to background panel )
local DownArrowImage = vgui.Create( "DImage", BackGroundDownArrow )
DownArrowImage:SetPos( 5, 5 )
DownArrowImage:SetSize( 42, 42 )
DownArrowImage:SetImage( "playermngr/up-chevron-button.png" )

RepDownArrowNotif:AddItem( BackGroundDownArrow )*/

--console command for checking your current rep
--everything is basically the same as above, except the fade time is 5 seconds.
concommand.Add("checkrep", function(ply, cmd, arg)

  local NotifyPanelRep = vgui.Create( "DNotify" )
  NotifyPanelRep:SetPos( 15, 15 )
  NotifyPanelRep:SetSize( 150, 50 )
  NotifyPanelRep:SetLife(RepPanelSettings.PanelLifeTime)
  
  --The dock, color and transparency
  local BGRep = vgui.Create( "DPanel", NotifyPanelRep )
  BGRep:Dock( FILL )
  BGRep:SetBackgroundColor( Color( 64, 64, 64, 150 ) )
  
  --The reputation icon for the player, sizes, and background
  local ImageRep = vgui.Create( "DImage", BGRep )
    if LocalPlayer():GetNWInt('RepAmount') == 0 then
      ImageRep:SetPos( 11, 3 )
      ImageRep:SetSize( 42, 42 )
      ImageRep:SetImage( RepPanelSettings.PanelIconNT )
    elseif LocalPlayer():GetNWInt('RepAmount') >= 0 then
      ImageRep:SetPos( 8, 3 )
      ImageRep:SetSize( 42, 42 )
      ImageRep:SetImage( RepPanelSettings.PanelIconBE )
    elseif LocalPlayer():GetNWInt('RepAmount') <= 0 then
      ImageRep:SetPos( 8, 3 )
      ImageRep:SetSize( 42, 42 )
      ImageRep:SetImage( RepPanelSettings.PanelIconAN )
    end
  --The message, depending on your rep the color and text might change!
  local LabelRep = vgui.Create( "DLabel", BGRep )
    LabelRep:SetPos( 57, 1.8 )
    LabelRep:SetSize( 110, 50 )
    if LocalPlayer():GetNWInt('RepAmount') == 0 then
        LabelRep:SetText( 'Neutral' )
        LabelRep:SetTextColor( Color( 255, 255, 255 ) )
      elseif LocalPlayer():GetNWInt('RepAmount') >= 0 then
        LabelRep:SetTextColor( Color( 0, 150, 0 ) )
        LabelRep:SetText( 'Benefactor: '..LocalPlayer():GetNWInt('RepAmount') )
      elseif LocalPlayer():GetNWInt('RepAmount') <= 0 then
        LabelRep:SetText( 'Antagonist: '..LocalPlayer():GetNWInt('RepAmount') )
        LabelRep:SetTextColor( Color( 150, 0, 0 ) )
    end
  LabelRep:SetFont( RepPanelSettings.PanelTextFont )
  LabelRep:SetWrap( true )
  surface.PlaySound( RepPanelSettings.PanelPopUpSound )
  NotifyPanelRep:AddItem( BGRep )
end)