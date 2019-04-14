--Player reputation system by BlackSnow
--The variables
--Note: The commented out attacker:ChatPrints() used to be debug messages to test sync between derma and the SetNWINt functions. These are now useless but feel free to re-enable!
--Note 2: For panel settings go to client/player_mngr_cl_rep.lua

local PlayerManager = {
  RepEnable = true, --Enable the reputation system?
  RepResetOnDeath = false, --Reset reputation on a players death? (Upcoming)
  RepPlayerKillAmount = -20, --The amount of reputation you get taken away when killing someone
  RepPlayerGoodGuyAmount = 5, --The amount of reputation you get when killing bandits or healing players, when your reputation is negative
  RepPlayerTrueGoodAmount = 15, --The amount of reputation you get when killing bandits or healing players, when your reputation neutral or good
  RepNotifSound = "garrysmod/ui_return.wav", --Sound path for notif
  RepEnableNPC = true, --Enable reputation drop/rise on NPC kills? (For performance sake RP etc servers should have this set to false)
  RepNPCKillGoodGuy = -50, --Amount you get when killing a good NPC
  RepNPCKillBadGuy = 10, --Amount you get when killing a baddie NPC
  RepEnableBanditSkin = true, --Does this enable bandit models on certain rep? (Upcoming)
  RepBanditSkinRep = -50, --How much rep is needed before you get the bandit skin. (Upcoming)
  RepBanditSkinPath = "models/player/arctic.mdl", --Model path for the bandit skin (Upcoming)
  RepEnableDebugCommands = false --Debug stuff
}

--The actual code

hook.Add( "PlayerDeath", "RepPlayerKill", function(victim, inflictor, attacker)
if PlayerManager.RepEnable == true then --Check if the rep system is enabled

  if attacker == victim then return end --If the victim is an npc or the attacker himself return.
  if attacker:IsNPC() then return end --This part only refers for player deaths by NPCs. Do NOT touch this.
  util.AddNetworkString('RepClientStuff') -- Highly important if you want the VGUI Derma part not to break!
  //util.AddNetworkString('RepClientDown')
  //util.AddNetworkString('RepClientUp')

if victim:GetNWInt('RepAmount') >= -1 then --check if the player has more then -1 rep
      attacker:SetNWInt( 'RepAmount', attacker:GetNWInt('RepAmount') + PlayerManager.RepPlayerKillAmount) --If the player kills a neutral player, their rep drops heavily
      timer.Create("RepMenuDelay", 1, 1, function()
        net.Start( "RepClientStuff" )
        //net.Start('RepClientDown')
        net.Send(attacker)
      end)
      //attacker:ChatPrint('You have gained '..PlayerManager.RepPlayerKillAmount.. ' rep! Your current rep is: '..attacker:GetNWInt("RepAmount"))
  elseif victim:GetNWInt('RepAmount') <= -1 && attacker:GetNWInt('RepAmount') >= -1 then --If the player kills a bandit player while they're a bandit himself, their rep rises slowly
      attacker:SetNWInt( 'RepAmount', attacker:GetNWInt('RepAmount') + PlayerManager.RepPlayerTrueGoodAmount)
      timer.Create("RepMenuDelay", 1, 1, function()
        net.Start( "RepClientStuff" )
        net.Send(attacker)
      end)
      //attacker:ChatPrint('You have gained +'..PlayerManager.RepPlayerTrueGoodAmount.. ' rep! Your current rep is: '..attacker:GetNWInt("RepAmount"))
  elseif victim:GetNWInt('RepAmount') <= -1 && attacker:GetNWInt('RepAmount') <= -1 then --If a neutral player kills a bandit, their rep rises heavily
      attacker:SetNWInt( 'RepAmount', attacker:GetNWInt('RepAmount') + PlayerManager.RepPlayerGoodGuyAmount)
      timer.Create("RepMenuDelay", 1, 1, function()
        net.Start( "RepClientStuff" )
        net.Send(attacker)
      end)
      //attacker:ChatPrint('You have gained +'..PlayerManager.RepPlayerGoodGuyAmount.. ' rep! Your current rep is: '..attacker:GetNWInt("RepAmount"))
  end
else return
end
end)

hook.Add("OnNPCKilled", "NPCKilledRep", function (npc, attacker, ent)
  if PlayerManager.RepEnable == true && PlayerManager.RepEnableNPC == true then
    if attacker:IsNPC() then return end
    print(attacker:GetNWInt('RepAmount'))
    util.AddNetworkString('RepClientStuff') -- Highly important if you want the VGUI Derma part not to break!
    //util.AddNetworkString('RepClientDown')
    //util.AddNetworkString('RepClientUp')

  if npc:Disposition(attacker) == D_HT then
    attacker:SetNWInt( 'RepAmount', attacker:GetNWInt('RepAmount') + PlayerManager.RepNPCKillBadGuy)
    //attacker:ChatPrint('You have gained +'..PlayerManager.RepNPCKillBadGuy.. ' rep! Your current rep is: '..attacker:GetNWInt("RepAmount"))
    timer.Create("RepMenuDelay", 1, 1, function()
      net.Start( "RepClientStuff" )
      net.Send(attacker)
    end)
  elseif npc:Disposition(attacker) == D_LI or npc:Disposition(attacker) == D_NU or npc:Disposition(attacker) == D_FR then
    attacker:SetNWInt( 'RepAmount', attacker:GetNWInt('RepAmount') + PlayerManager.RepNPCKillGoodGuy)
    //attacker:ChatPrint('You have gained '..PlayerManager.RepNPCKillGoodGuy.. ' rep! Your current rep is: '..attacker:GetNWInt("RepAmount"))
    timer.Create("RepMenuDelay", 1, 1, function()
      net.Start( "RepClientStuff" )
      //net.Start('RepClientDown')
      net.Send(attacker)
    end)
  end
  else return
  end
end)

if PlayerManager.RepEnableDebugCommands == true then
concommand.Add("resetrep", function(ply)
  ply:SetNWInt('RepAmount', 0)
  local String = table.ToString(PlayerManager.RepEnable, "Niggas on the moon", true)
  print(String)
end)

concommand.Add("giverepglobal", function(ply)
  for k, v in pairs(player.GetAll()) do
    v:SetNWInt('RepAmount', -500)
  end
end)
end

