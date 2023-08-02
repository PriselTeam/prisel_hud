/*
 * -------------------------
 * • Fichier: cl_s-prisel-hud.lua
 * • Projet: client
 * • Création : Monday, 10th July 2023 2:48:08 am
 * • Auteur : Ekali
 * • Modification : Monday, 10th July 2023 12:20:43 pm
 * • Destiné à Prisel.fr en V3
 * -------------------------
 */

PriselHUD = PriselHUD or {}
PriselHUD.ActiveLogo = true

local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["DarkRP_HUD"] = true,
    ["DarkRP_Hungermod"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudCrosshair"] = true
}

local function drawText(text, font, x, y, color, alignX, alignY)
    draw.SimpleText(text, font, x, y, color, alignX, alignY)
end


hook.Add( "HUDDrawTargetID", "PriselV3:HideName", function()
	return false
end)

hook.Add("HUDShouldDraw", "S:Prisel:HUD:Hook:HUDShouldDraw", function(name)
    if (hide[name]) then
        return false
    end
end)

local lerps = {}
local drawDistPl = 100
lerps.heal = 0
lerps.armor = 0
lerps.money = 0
lerps.hunger = 0
lerps.alpha = 0
lerps.start = CurTime()
lerps.animE = 0
local spd = FrameTime() * 7

hook.Add("HUDPaint", "S:Prisel:HUD:Hook:HUDPaint", function()
	local localPlayer = LocalPlayer()

	if not localPlayer:Alive() then
			return
	end

	if not IsValid(localPlayer) then
			return
	end
	
	spd = FrameTime() * 7
	lerps.heal = Lerp(spd, lerps.heal, localPlayer:Health())
	lerps.armor = Lerp(spd, lerps.armor, localPlayer:Armor())
	lerps.money = Lerp(spd, lerps.money, localPlayer:getDarkRPVar("money") or 0)
	lerps.hunger = Lerp(spd, lerps.hunger, localPlayer:getDarkRPVar("Energy") or 0)

	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.02, DarkRP.ScrH - 30, DarkRP.ScrW * 0.1, DarkRP.ScrH * 0.02, 	DarkRP.Config.Colors["Main"])
  	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.02, DarkRP.ScrH - (30) * 2, DarkRP.ScrW * 0.1, DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Main"])
  	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.02, DarkRP.ScrH - (30) * 3, DarkRP.ScrW * 0.1, DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Main"])
  	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.02, DarkRP.ScrH - 30, math.Clamp(lerps.armor * 2, 0, DarkRP.ScrW * 0.1), DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Blue"])
  	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.02, DarkRP.ScrH - (30) * 2, math.Clamp(lerps.hunger * 2, 0, DarkRP.ScrW * 0.1), DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Green"])
  	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.02, DarkRP.ScrH - (30) * 3, math.Clamp(lerps.heal * 2, 0, DarkRP.ScrW * 0.1), DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Red"])
	draw.SimpleText(math.Round(lerps.armor), DarkRP.Library.Font(6, 0, "Montserrat Bold"), DarkRP.ScrW * 0.02 + DarkRP.ScrW * 0.1 /2, DarkRP.ScrH - 30 + DarkRP.ScrH * 0.02 /2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(lerps.hunger, DarkRP.Library.Font(6, 0, "Montserrat Bold"), DarkRP.ScrW * 0.02 + DarkRP.ScrW * 0.1 /2, DarkRP.ScrH - 30 *2 + DarkRP.ScrH * 0.02 /2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(math.Round(lerps.heal), DarkRP.Library.Font(6, 0, "Montserrat Bold"), DarkRP.ScrW * 0.02 + DarkRP.ScrW * 0.1 /2, DarkRP.ScrH - 30 *3 + DarkRP.ScrH * 0.02 /2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/mcoeur"))
	surface.DrawTexturedRect(DarkRP.ScrW * 0.0045, DarkRP.ScrH - 30 * 3 - DarkRP.ScrW * 0.012/10.5, DarkRP.ScrW * 0.014, DarkRP.ScrW * 0.014)
	surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/food"))
	surface.DrawTexturedRect(DarkRP.ScrW * 0.0045, DarkRP.ScrH - 30 * 2 - DarkRP.ScrW * 0.012/10.5, DarkRP.ScrW * 0.014, DarkRP.ScrW * 0.014)
	surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/sshield"))
	surface.DrawTexturedRect(DarkRP.ScrW * 0.0045, DarkRP.ScrH - 30 - DarkRP.ScrW * 0.012/10.5, DarkRP.ScrW * 0.014, DarkRP.ScrW * 0.014)


	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.88, DarkRP.ScrH - 30, DarkRP.ScrW * 0.1, DarkRP.ScrH * 0.02, 	DarkRP.Config.Colors["Main"])
	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.88, DarkRP.ScrH - (30) * 2, DarkRP.ScrW * 0.1, DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Main"])
	draw.RoundedBox(DarkRP.Config.RoundedBoxValue, DarkRP.ScrW * 0.88, DarkRP.ScrH - (30) * 3, DarkRP.ScrW * 0.1, DarkRP.ScrH * 0.02, DarkRP.Config.Colors["Main"])
	draw.SimpleText("PRISEL.FR", DarkRP.Library.Font(6, 0, "Montserrat Bold"), DarkRP.ScrW * 0.88 + DarkRP.ScrW * 0.1 /2, DarkRP.ScrH - 30 + DarkRP.ScrH * 0.02 /2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(DarkRP.formatMoney(math.Round(lerps.money)), DarkRP.Library.Font(6, 0, "Montserrat Bold"), DarkRP.ScrW * 0.88 + DarkRP.ScrW * 0.1 /2, DarkRP.ScrH - 30 *2 + DarkRP.ScrH * 0.02 /2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(LocalPlayer():Nick(), DarkRP.Library.Font(6, 0, "Montserrat Bold"), DarkRP.ScrW * 0.88 + DarkRP.ScrW * 0.1 /2, DarkRP.ScrH - 30 *3 + DarkRP.ScrH * 0.02 /2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/dollards"))
	surface.DrawTexturedRect(DarkRP.ScrW * 0.983, DarkRP.ScrH - 30 * 2 - DarkRP.ScrW * 0.012/10.5, DarkRP.ScrW * 0.014, DarkRP.ScrW * 0.014)
	surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/used"))
	surface.DrawTexturedRect(DarkRP.ScrW * 0.983, DarkRP.ScrH - 30 * 3 - DarkRP.ScrW * 0.012/10.5, DarkRP.ScrW * 0.014, DarkRP.ScrW * 0.014)
	surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/pllogo"))
	surface.DrawTexturedRect(DarkRP.ScrW * 0.983, DarkRP.ScrH - 30 - DarkRP.ScrW * 0.012/10.5, DarkRP.ScrW * 0.014, DarkRP.ScrW * 0.014)

	if PriselHUD.ActiveLogo then
		DarkRP.Library.DrawMaterialSwing(DarkRP.Library.FetchCDN("prisel_main/prisel_logo_bleu"), DarkRP.ScrW * 0.027, DarkRP.ScrW * 0.027, (624/8)-DarkRP.ScrW/DarkRP.ScrW, (439/8)-DarkRP.ScrH/DarkRP.ScrH, 8, 3)
	end

	local trace = localPlayer:GetEyeTrace()
	local ent = trace.Entity

	if IsValid(ent) and ent:IsPlayer() and not ent:GetNoDraw() and ent ~= localPlayer and ent:Alive() and ent:GetPos():DistToSqr(localPlayer:GetPos()) <= 8000 then
		surface.SetDrawColor(color_white)
		surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_hud/interact_e"))
		surface.DrawTexturedRect(DarkRP.ScrW / 2 - 30, DarkRP.ScrH / 2 - 30, 60, 60)
		draw.SimpleText("INTERAGIR", DarkRP.Library.Font(7, 0, "Montserrat Bold"), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)

local cacheVector = Vector(0, 0, 80)

local function NameAboveTheHead()
  if not IsValid(LocalPlayer()) then return end
  local p = LocalPlayer()

  surface.SetFont(DarkRP.Library.Font(8))
  
  local ang = p:EyeAngles()
  ang:RotateAroundAxis(ang:Up(), -90)
  ang:RotateAroundAxis(ang:Forward(), 90)
  ang:RotateAroundAxis(ang:Right(), 0)

  if p:HasAdminMode() then return end

  for k,v in ipairs(ents.FindInSphere(p:GetPos(), 100)) do
	if not IsValid(v) or not v:IsPlayer() then continue end
	if v:GetNoDraw() then continue end
	if (v == p) then 
		continue 
	end

	local newUser = false


	if (v:GetUTimeTotalTime() or 0)/60 < 125 then
		newUser = true
	end 

    cam.Start3D2D(v:GetPos()+cacheVector, ang, 0.1);
        draw.SimpleTextOutlined(v:Name(), DarkRP.Library.Font(12, 0, "Montserrat Bold"), 0, 40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, DarkRP.Config.Colors["Secondary"])
		if newUser then
			draw.SimpleTextOutlined("Nouveau Joueur", DarkRP.Library.Font(8, 0, "Montserrat Bold"), 0, 75, DarkRP.Config.Colors["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, DarkRP.Config.Colors["Secondary"])
		end
	cam.End3D2D()
  end

end

hook.Add("PostDrawTranslucentRenderables", "PriselV3::HUD::ShowNameAboveHead", NameAboveTheHead)


local DrawDistance = 250
local doorInfo = {}
local function computeFadeAlpha( time, dur, sa, ea, start )
	time = time - (start or 0)

	if time < 0 then return sa end	
	if time > dur then return ea end

	return sa + ((math.sin( (time / dur) * (math.pi / 2) )^2) * (ea - sa))
end

local function colorMulAlpha( col, mul )
	return Color( col.r, col.g, col.b, col.a * mul )
end

local function isDoor( door )
	if door.isDoor and door.isKeysOwnable then
		return door:isDoor() and door:isKeysOwnable()
	end
end

local function isOwnable( door )
	if door.getKeysNonOwnable then
		return door:getKeysNonOwnable() != true
	end
end

local function getTitle( door )
	if door.getKeysTitle then
		return door:getKeysTitle()
	end
end

local function getOwner( door )
	if door.getDoorOwner then
		local owner = door:getDoorOwner()

		if IsValid( owner ) then
			return owner
		end
	end
end

local function getCoowners( door )
	local owner = getOwner( door )
	local coents = {}

	if door.isKeysOwnedBy then
		for _, ply in pairs( player.GetAll() ) do
			if door:isKeysOwnedBy( ply ) and ply != owner then
				table.insert( coents, ply )
			end
		end
	end

	return coents
end

local function isAllowedToCoown( door, ply )
	if door.isKeysAllowedToOwn and door.isKeysOwnedBy then
		return door:isKeysAllowedToOwn( ply ) and !door:isKeysOwnedBy( ply )
	end
end

local function getAllowedGroupNames( door )
	local ret = {}

	if door.getKeysDoorGroup and door:getKeysDoorGroup() then
		table.insert( ret, door:getKeysDoorGroup() )
	elseif door.getKeysDoorTeams then
		for tid in pairs( door:getKeysDoorTeams() or {} ) do
			local tname = team.GetName( tid )

			if tname then
				table.insert( ret, tname )
			end
		end
	end

	return ret
end


hook.Add( "HUDDrawDoorData", "sh_doordisplay_hudoverride", function( door )
	if isDoor( door ) and isOwnable( door ) then
		if #getAllowedGroupNames( door ) < 1 then
			if !getOwner( door ) then
                surface.SetDrawColor(color_white)
                surface.SetMaterial( DarkRP.Library.FetchCDN("prisel_hud/interact_e") )
                surface.DrawTexturedRect( DarkRP.ScrW / 2 - 30, DarkRP.ScrH / 2 - 30, 60, 60 )
                draw.SimpleTextOutlined("F2 POUR INTERAGIR", DarkRP.Library.Font(7, 0, "Montserrat Bold"), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, DarkRP.Config.Colors["Secondary"])

            elseif isAllowedToCoown( door, LocalPlayer() ) then
                surface.SetDrawColor(color_white)
                surface.SetMaterial( DarkRP.Library.FetchCDN("prisel_hud/interact_e") )
                surface.DrawTexturedRect( DarkRP.ScrW / 2 - 30, DarkRP.ScrH / 2 - 30, 60, 60 )
                draw.SimpleTextOutlined("F2 POUR INTERAGIR", DarkRP.Library.Font(7, 0, "Montserrat Bold"), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, DarkRP.Config.Colors["Secondary"])
            end
		end

		return true
	end
end )

hook.Add( "PostDrawTranslucentRenderables", "sh_doordisplay_drawdisplay", function()
	for _, door in pairs( ents.GetAll() ) do
		if !isDoor( door ) or !isOwnable( door ) then continue end

		local dinfo = doorInfo[door]

		if !dinfo then
			dinfo = {
				coownCollapsed = true
			}

			local dimens = door:OBBMaxs() - door:OBBMins()
			local center = door:OBBCenter()
			local min, j 

			for i=1, 3 do
				if !min or dimens[i] <= min then
					j = i
					min = dimens[i]
				end
			end

			local norm = Vector()
			norm[j] = 1

			local lang = Angle( 0, norm:Angle().y + 90, 90 )

			if door:GetClass() == "prop_door_rotating" then
				dinfo.lpos = Vector( center.x, center.y, 30 ) + lang:Up() * (min / 6)
			else
				dinfo.lpos = center + Vector( 0, 0, 20 ) + lang:Up() * ((min / 2) - 0.1)
			end
			
			dinfo.lang = lang

			doorInfo[door] = dinfo
		end

		local dist = door:GetPos():Distance( LocalPlayer():GetShootPos() )

		if dist <= DrawDistance then
			dinfo.viewStart = dinfo.viewStart or CurTime()

			local title = getTitle( door )
			local owner = getOwner( door )
			local coowners = getCoowners( door ) or {}
			local allowedgroups = getAllowedGroupNames( door )

			local lpos, lang = Vector(), Angle()
			lpos:Set( dinfo.lpos )
			lang:Set( dinfo.lang )

			local ang = door:LocalToWorldAngles( lang )
			local dot = ang:Up():Dot( 
				LocalPlayer():GetShootPos() - door:WorldSpaceCenter()
			)

			if dot < 0 then
				lang:RotateAroundAxis( lang:Right(), 180 )

				lpos = lpos - (2 * lpos * -lang:Up())
				ang = door:LocalToWorldAngles( lang )
			end

			local pos = door:LocalToWorld( lpos )
			local scale = 0.14

			local vst = dinfo.viewStart
			local ct = CurTime()

			cam.Start3D2D( pos, ang, scale )
				local admul = math.cos( (dist / DrawDistance) * (math.pi / 2) )^2
				local amul = computeFadeAlpha( ct, 0.98, 0, 1, vst ) * admul

				if #allowedgroups < 1 then
					draw.SimpleTextOutlined(
						owner and (title or "Acheté") or "LIBRE",
						DarkRP.Library.Font(15, 0, "Montserrat Bold"),
						0, 10,
						colorMulAlpha( color_white, amul ),
						TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM,
						1, colorMulAlpha( color_black, amul )
					)

					if owner then
						amul = computeFadeAlpha( ct, 0.75, 0, 1, vst + 0.35 ) * admul

						draw.SimpleTextOutlined(
							owner:Nick(),
							DarkRP.Library.Font(12, 0, "Montserrat Bold"),
							0, 50,
							colorMulAlpha( color_white, amul ),
							TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM,
							1, colorMulAlpha( color_black, amul )
						)

						if #coowners > 0 then
							if !dinfo.coownCollapsed then
								local conames = {}

								for i=1, #coowners do
									table.insert( conames, coowners[i]:Nick() )
								end

								table.sort( conames )

								for i=1, #conames do
									amul = computeFadeAlpha( ct, 0.75, 0, 1, dinfo.coownExpandStart + 0.2*i ) * admul

									draw.SimpleTextOutlined(
										conames[i],
										DarkRP.Library.Font(12, 0, "Montserrat Bold"),
										0, 60 + 25*i,
										colorMulAlpha( color_white, amul ),
										TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM,
										1, colorMulAlpha( color_black, amul )
									)
								end
							else
								amul = computeFadeAlpha( ct, 1, 0, 1, vst + 1.0 ) * admul

								local whitpos = util.IntersectRayWithPlane( 
									LocalPlayer():GetShootPos(), LocalPlayer():GetAimVector(),
									pos, ang:Up()
								)
								local cy = 0
								local cactive = false

								if whitpos and LocalPlayer():GetEyeTrace().Entity == door then
									local hitpos = door:WorldToLocal( whitpos ) - lpos

									cy = -hitpos.z / scale
									cactive = true
								end

								if (ct - vst) >= 2 and cactive and cy >= 80 and cy <= 80 + 25 then
									dinfo.coownExpandRequestStart = dinfo.coownExpandRequestStart or CurTime()

									if CurTime() - dinfo.coownExpandRequestStart >= 0.75 then
										dinfo.coownCollapsed = false
										dinfo.coownExpandStart = CurTime()
										dinfo.coownExpandRequestStart = nil
									end

									amul = computeFadeAlpha( ct, 0.75, 1, 0, dinfo.coownExpandRequestStart ) * admul --fade out
								else
									dinfo.coownExpandRequestStart = nil
								end

								draw.SimpleTextOutlined(
									"+ " .. #coowners .. " personne(s)",
									DarkRP.Library.Font(12, 0, "Montserrat Bold"),
									0, 80,
									colorMulAlpha( color_white, amul ),
									TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM,
									1, colorMulAlpha( color_black, amul )
								)
							end
						end
					end
				else
					for i=1, #allowedgroups do
						amul = computeFadeAlpha( ct, 0.75, 0, 1, vst + 0.2*i ) * admul

						draw.SimpleTextOutlined(
							allowedgroups[i],
							DarkRP.Library.Font(12, 0, "Montserrat Bold"),
							0, 50 + 30*(i-1),
							colorMulAlpha( color_white, amul ),
							TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM,
							1, colorMulAlpha( color_black, amul )
						)
					end
				end
			cam.End3D2D()
		else
			dinfo.viewStart = nil
			dinfo.coownCollapsed = true
		end
	end
end)