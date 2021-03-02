function sendDiscord(name, message)
	local content = {
        {
        	["color"] = '16753920',
            ["author"] = {
		        ["name"] = 'gbmm Anticheat',
		        ["icon_url"] = 'https://i.imgur.com/DyWJLsx.png',
		    },
            ["title"] = "**Possible Modder**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "https://github.com/Swqppingg/gbmm-fivem-anticheat",
            }
        }
    }
  	PerformHttpRequest(Config.discordwebhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end

-- Check for blacklisted messages
if Config.blacklistedmessages then 
AddEventHandler('chatMessage', function(source, n, message)
	for k,n in pairs(Config.moddermsg) do
	  if string.match(message:lower(),n:lower()) then
	  local name = GetPlayerName(source)
	  local license, steam, discord = GetPlayerNeededIdentifiers(source)
	  DropPlayer(source, "🛡️ You have been automatically kicked for modding.")
	  CancelEvent()
		sendDiscord('gbmm Anticheat', '**User:** '..name..'\n**Reason:** Tried to say ```'..n..'```\n**License:** '.. license ..'\n**Steam:** '.. steam..'\n**Discord UID:** '.. discord ..'')
	  end
	end
  end)


	function GetPlayerNeededIdentifiers(player)
		local ids = GetPlayerIdentifiers(player)
		for i,theIdentifier in ipairs(ids) do
			if string.find(theIdentifier,"license:") or -1 > -1 then
				license = theIdentifier
			elseif string.find(theIdentifier,"steam:") or -1 > -1 then
				steam = theIdentifier
			elseif string.find(theIdentifier,"discord:") or -1 > -1 then
				discord = theIdentifier
			end
		end
		if not steam then
			steam = "steam: missing"
		end
		if not discord then
			discord = "discord: missing"
		end
		return license, steam, discord
	end


-- Check resource list 
	local validResourceList
	local function collectValidResourceList()
		validResourceList = {}
		for i = 0, GetNumResources() - 1 do
			validResourceList[GetResourceByFindIndex(i)] = true
		end
	end
	collectValidResourceList()
	if Config.StopUnauthorizedResources then
		AddEventHandler("onResourceListRefresh", collectValidResourceList)
		RegisterNetEvent("gbmm:checkresources")
		AddEventHandler("gbmm:checkresources", function(givenList)
			local source = source
			Wait(50)
			for _, resource in ipairs(givenList) do
				if not validResourceList[resource] then
					local license, steam, discord = GetPlayerNeededIdentifiers(source)
					local name = GetPlayerName(source)
					DropPlayer(source, "🛡️ You have been automatically kicked for modding.")
					sendDiscord('gbmm Anticheat', '**User:** '..name..'\n**Reason:**Unauthorized resources\n**License:** '.. license ..'\n**Steam:** '.. steam..'\n**Discord UID:** '.. discord ..'')
				end
			end
		end)
	end


	RegisterServerEvent('gbmm:NoclipFlag')
	AddEventHandler('gbmm:NoclipFlag', function(distance)
		if Config.antinoclip and not IsPlayerAceAllowed(source,"gbmmanticheat.bypass") then
			local license, steam, discord = GetPlayerNeededIdentifiers(source)
			local name = GetPlayerName(source)
			sendDiscord('gbmm Anticheat', '**User:** '..name..'\n**Reason:** Noclipping/Teleporting\n**License:** '.. license ..'\n**Steam:** '.. steam..'\n**Discord UID:** '.. discord ..'')
		end
	end)


if Config.blacklistedevents then 
for i=1, #Config.blacklistedevents, 1 do
  RegisterServerEvent(Config.blacklistedevents[i])
    AddEventHandler(Config.blacklistedevents[i], function()
	  local name = GetPlayerName(source)
	  local license, steam, discord = GetPlayerNeededIdentifiers(source)
      local _source = source
      DropPlayer(source, "Lua execution: "..Config.blacklistedevents[i],true)
      sendDiscord('gbmm Anticheat', '**User:** '..name..'\n**Reason:** LUA Execution: '..Config.blacklistedevents[i]..'\n**License:** '.. license ..'\n**Steam:** '.. steam..'\n**Discord UID:** '.. discord ..'')
    end)
end


AddEventHandler('explosionEvent', function(sender, ev)
    local sender = tonumber(sender)
    CancelEvent()
    if (sender ~= nil and sender > 0) then 
        CancelEvent()
    end
end)

AddEventHandler("clearPedTasksEvent", function(sender, data)
    if Config.AntiCancelAnimations = true then 
    CancelEvent()
    end 
    -- Stops other players kicking people out of cars
end)

AddEventHandler('removeWeaponEvent', function(sender, data)
    if Config.AntiRemoveOtherPlayersWeapons then 
        CancelEvent()
    end 
    -- Would only affect if you have scripts removing other people's weapons. (stops players removing other players weapons)
end)

AddEventHandler('giveWeaponEvent', function(sender, data)
    if Config.StopOtherPlayersGivingEachOtherWeapons then 
    CancelEvent()
    end 
    -- Stops other players giving people weapons (doesn't affect single people unless you have give weapons on menus and etc.)
end)


 
--ONESYNC ONLY -

 local stuntProps = {
     [`sr_prop_spec_tube_crn_05a`] = true,
     [`sr_prop_spec_tube_crn_30d_05a`] = true,
     [`sr_prop_spec_tube_l_05a`] = true,
     [`sr_prop_spec_tube_m_05a`] = true,
     [`sr_prop_spec_tube_xxs_05a`] = true,
     [`sr_prop_stunt_tube_crn_15d_05a`] = true,
     [`sr_prop_stunt_tube_crn_5d_05a`] = true,
     [`sr_prop_stunt_tube_xs_05a`] = true,
     [`sr_prop_special_bblock_lrg11`] = true,
     [`prop_beach_fire`] = true,
     [`sr_prop_special_bblock_lrg2`] = true,
     [`sr_prop_special_bblock_lrg3`] = true,
     [`sr_prop_special_bblock_mdm1`] = true,
     [`sr_prop_special_bblock_mdm2`] = true,
     [`sr_prop_special_bblock_mdm3`] = true,
     [`sr_prop_special_bblock_sml1`] = true,
     [`sr_prop_special_bblock_sml2`] = true,
     [`sr_prop_special_bblock_sml3`] = true,
     [`sr_prop_special_bblock_xl1`] = true,
     [`sr_prop_special_bblock_xl2`] = true,
     [`sr_prop_special_bblock_xl3`] = true,
     [`sr_prop_special_bblock_xl3_fixed`] = true,
     [`sr_prop_sr_target_1_01a`] = true,
     [`sr_prop_sr_target_2_04a`] = true,
     [`sr_prop_sr_target_3_03a`] = true,
     [`sr_prop_sr_target_5_01a`] = true,
     [`sr_prop_sr_target_large_01a`] = true,
     [`sr_prop_sr_target_long_01a`] = true,
     [`sr_prop_sr_target_small_01a`] = true,
     [`sr_prop_sr_target_small_02a`] = true,
     [`sr_prop_sr_target_small_03a`] = true,
     [`sr_prop_sr_target_small_04a`] = true,
     [`sr_prop_sr_target_small_05a`] = true,
     [`sr_prop_sr_target_small_06a`] = true,
     [`sr_prop_sr_target_small_07a`] = true,
     [`sr_prop_sr_target_trap_01a`] = true,
     [`sr_prop_sr_target_trap_02a`] = true,
     [`sr_prop_sr_track_block_01`] = true,
     [`sr_prop_sr_track_wall`] = true,
     [`sr_prop_sr_tube_end`] = true,
     [`sr_prop_sr_tube_wall`] = true,
     [`sr_prop_spec_target_b_01a`] = true,
     [`sr_prop_spec_target_m_01a`] = true,
     [`sr_prop_spec_target_s_01a`] = true,
     [`sr_prop_spec_tube_refill`] = true,
     [`sr_prop_track_refill`] = true,
     [`sr_prop_track_refill_t1`] = true,
     [`sr_prop_track_refill_t2`] = true,
     [`sr_mp_spec_races_ammu_sign`] = true,
     [`sr_mp_spec_races_blimp_sign`] = true,
     [`sr_mp_spec_races_ron_sign`] = true,
     [`sr_mp_spec_races_xero_sign`] = true,
     [`sr_prop_sr_start_line_02`] = true,
     [`sr_prop_track_straight_l_d15`] = true,
     [`sr_prop_track_straight_l_d30`] = true,
     [`sr_prop_track_straight_l_d45`] = true,
     [`sr_prop_track_straight_l_d5`] = true,
     [`sr_prop_track_straight_l_u15`] = true,
     [`sr_prop_track_straight_l_u30`] = true,
     [`sr_prop_track_straight_l_u45`] = true,
     [`sr_prop_track_straight_l_u5`] = true,
     [`sr_prop_spec_tube_crn_01a`] = true,
    [`sr_prop_spec_tube_crn_30d_01a`] = true,
    [`sr_prop_spec_tube_l_01a`] = true,
    [`sr_prop_spec_tube_m_01a`] = true,
    [`sr_prop_spec_tube_s_01a`] = true,
    [`sr_prop_spec_tube_xxs_01a`] = true,
    [`sr_prop_stunt_tube_crn_15d_01a`] = true,
    [`sr_prop_stunt_tube_crn_5d_01a`] = true,
    [`sr_prop_stunt_tube_crn2_01a`] = true,
    [`sr_prop_stunt_tube_xs_01a`] = true,
    [`sr_prop_spec_tube_crn_03a`] = true,
    [`sr_prop_spec_tube_crn_30d_03a`] = true,
    [`sr_prop_spec_tube_l_03a`] = true,
    [`sr_prop_spec_tube_m_03a`] = true,
    [`sr_prop_spec_tube_s_03a`] = true,
    [`sr_prop_spec_tube_xxs_03a`] = true,
    [`sr_prop_stunt_tube_crn_15d_03a`] = true,
    [`sr_prop_stunt_tube_crn_5d_03a`] = true,
    [`sr_prop_stunt_tube_crn2_03a`] = true,
    [`sr_prop_stunt_tube_xs_03a`] = true,
    [`sr_prop_spec_tube_crn_02a`] = true,
    [`sr_prop_spec_tube_crn_30d_02a`] = true,
    [`sr_prop_spec_tube_l_02a`] = true,
    [`sr_prop_spec_tube_m_02a`] = true,
    [`sr_prop_spec_tube_s_02a`] = true,
    [`sr_prop_spec_tube_xxs_02a`] = true,
    [`sr_prop_stunt_tube_crn_15d_02a`] = true,
    [`sr_prop_stunt_tube_crn_5d_02a`] = true,
    [`sr_prop_stunt_tube_crn2_02a`] = true,
    [`sr_prop_stunt_tube_xs_02a`] = true,
    [`sr_prop_spec_tube_crn_04a`] = true,
    [`sr_prop_spec_tube_crn_30d_04a`] = true,
    [`sr_prop_spec_tube_l_04a`] = true,
    [`sr_prop_spec_tube_m_04a`] = true,
    [`sr_prop_spec_tube_s_04a`] = true,
    [`sr_prop_spec_tube_xxs_04a`] = true,
    [`sr_prop_stunt_tube_crn_15d_04a`] = true,
    [`sr_prop_stunt_tube_crn_5d_04a`] = true,
    [`sr_prop_stunt_tube_crn2_04a`] = true,
    [`sr_prop_stunt_tube_xs_04a`] = true,
    [`stt_prop_race_tannoy`] = true,
    [`stt_prop_speakerstack_01a`] = true,
    [`stt_prop_flagpole_1c`] = true,
    [`stt_prop_flagpole_1e`] = true,
    [`stt_prop_flagpole_1d`] = true,
    [`stt_prop_flagpole_1f`] = true,
    [`stt_prop_flagpole_1a`] = true,
    [`stt_prop_flagpole_1b`] = true,
    [`stt_prop_flagpole_2a`] = true,
    [`stt_prop_flagpole_2b`] = true,
    [`stt_prop_flagpole_2c`] = true,
    [`stt_prop_flagpole_2d`] = true,
    [`stt_prop_flagpole_2e`] = true,
    [`stt_prop_flagpole_2f`] = true,
    [`stt_prop_corner_sign_01`] = true,
    [`stt_prop_corner_sign_02`] = true,
    [`stt_prop_corner_sign_03`] = true,
    [`stt_prop_corner_sign_04`] = true,
    [`stt_prop_corner_sign_05`] = true,
    [`stt_prop_corner_sign_06`] = true,
    [`stt_prop_corner_sign_07`] = true,
    [`stt_prop_corner_sign_08`] = true,
    [`stt_prop_corner_sign_09`] = true,
    [`stt_prop_corner_sign_10`] = true,
    [`stt_prop_corner_sign_11`] = true,
    [`stt_prop_corner_sign_12`] = true,
    [`stt_prop_corner_sign_13`] = true,
    [`stt_prop_corner_sign_14`] = true,
    [`stt_prop_hoop_constraction_01a`] = true,
    [`stt_prop_hoop_small_01`] = true,
    [`stt_prop_hoop_tyre_01a`] = true,
    [`stt_prop_race_gantry_01`] = true,
    [`stt_prop_race_start_line_01`] = true,
    [`stt_prop_race_start_line_01b`] = true,
    [`stt_prop_race_start_line_02`] = true,
    [`stt_prop_race_start_line_02b`] = true,
    [`stt_prop_race_start_line_03`] = true,
    [`stt_prop_race_start_line_03b`] = true,
    [`stt_prop_ramp_adj_flip_m`] = true,
    [`stt_prop_ramp_adj_flip_mb`] = true,
    [`stt_prop_ramp_adj_flip_s`] = true,
    [`stt_prop_ramp_adj_flip_sb`] = true,
    [`stt_prop_ramp_adj_hloop`] = true,
    [`stt_prop_ramp_adj_loop`] = true,
    [`stt_prop_ramp_jump_l`] = true,
    [`stt_prop_ramp_jump_m`] = true,
    [`stt_prop_ramp_jump_s`] = true,
    [`stt_prop_ramp_jump_xl`] = true,
    [`stt_prop_ramp_jump_xs`] = true,
    [`stt_prop_ramp_jump_xxl`] = true,
    [`stt_prop_ramp_multi_loop_rb`] = true,
    [`stt_prop_ramp_spiral_l`] = true,
    [`stt_prop_ramp_spiral_l_l`] = true,
    [`stt_prop_ramp_spiral_l_m`] = true,
    [`stt_prop_ramp_spiral_l_s`] = true,
    [`stt_prop_ramp_spiral_l_xxl`] = true,
    [`stt_prop_ramp_spiral_m`] = true,
    [`stt_prop_ramp_spiral_s`] = true,
    [`stt_prop_ramp_spiral_xxl`] = true,
    [`stt_prop_sign_circuit_01`] = true,
    [`stt_prop_sign_circuit_02`] = true,
    [`stt_prop_sign_circuit_03`] = true,
    [`stt_prop_sign_circuit_04`] = true,
    [`stt_prop_sign_circuit_05`] = true,
    [`stt_prop_sign_circuit_06`] = true,
    [`stt_prop_sign_circuit_07`] = true,
    [`stt_prop_sign_circuit_08`] = true,
    [`stt_prop_sign_circuit_09`] = true,
    [`stt_prop_sign_circuit_10`] = true,
    [`stt_prop_sign_circuit_11`] = true,
    [`stt_prop_sign_circuit_11b`] = true,
    [`stt_prop_sign_circuit_12`] = true,
    [`stt_prop_sign_circuit_13`] = true,
    [`stt_prop_sign_circuit_13b`] = true,
    [`stt_prop_sign_circuit_14`] = true,
    [`stt_prop_sign_circuit_14b`] = true,
    [`stt_prop_sign_circuit_15`] = true,
    [`stt_prop_slow_down`] = true,
    [`stt_prop_startline_gantry`] = true,
    [`stt_prop_stunt_bblock_huge_01`] = true,
    [`stt_prop_stunt_bblock_huge_02`] = true,
    [`stt_prop_stunt_bblock_huge_03`] = true,
    [`stt_prop_stunt_bblock_huge_04`] = true,
    [`stt_prop_stunt_bblock_huge_05`] = true,
    [`stt_prop_stunt_bblock_hump_01`] = true,
    [`stt_prop_stunt_bblock_hump_02`] = true,
    [`stt_prop_stunt_bblock_lrg1`] = true,
    [`stt_prop_stunt_bblock_lrg2`] = true,
    [`stt_prop_stunt_bblock_lrg3`] = true,
    [`stt_prop_stunt_bblock_mdm1`] = true,
    [`stt_prop_stunt_bblock_mdm2`] = true,
    [`stt_prop_stunt_bblock_mdm3`] = true,
    [`stt_prop_stunt_bblock_qp`] = true,
    [`stt_prop_stunt_bblock_qp2`] = true,
    [`stt_prop_stunt_bblock_qp3`] = true,
    [`stt_prop_stunt_bblock_sml1`] = true,
    [`stt_prop_stunt_bblock_sml2`] = true,
    [`stt_prop_stunt_bblock_sml3`] = true,
    [`stt_prop_stunt_bblock_xl1`] = true,
    [`stt_prop_stunt_bblock_xl2`] = true,
    [`stt_prop_stunt_bblock_xl3`] = true,
    [`stt_prop_stunt_bowling_ball`] = true,
    [`stt_prop_stunt_bowling_pin`] = true,
    [`stt_prop_stunt_bowlpin_stand`] = true,
    [`stt_prop_stunt_domino`] = true,
    [`stt_prop_stunt_jump15`] = true,
    [`stt_prop_stunt_jump30`] = true,
    [`stt_prop_stunt_jump45`] = true,
    [`stt_prop_stunt_jump_l`] = true,
    [`stt_prop_stunt_jump_lb`] = true,
    [`stt_prop_stunt_jump_loop`] = true,
    [`stt_prop_stunt_jump_m`] = true,
    [`stt_prop_stunt_jump_mb`] = true,
    [`stt_prop_stunt_jump_s`] = true,
    [`stt_prop_stunt_jump_sb`] = true,
    [`stt_prop_stunt_landing_zone_01`] = true,
    [`stt_prop_stunt_ramp`] = true,
    [`stt_prop_stunt_soccer_ball`] = true,
    [`stt_prop_stunt_soccer_goal`] = true,
    [`stt_prop_stunt_soccer_lball`] = true,
    [`stt_prop_stunt_soccer_sball`] = true,
    [`stt_prop_stunt_target`] = true,
    [`stt_prop_stunt_target_small`] = true,
    [`stt_prop_stunt_track_bumps`] = true,
    [`stt_prop_stunt_track_cutout`] = true,
    [`stt_prop_stunt_track_dwlink`] = true,
    [`stt_prop_stunt_track_dwlink_02`] = true,
    [`stt_prop_stunt_track_dwsh15`] = true,
    [`stt_prop_stunt_track_dwshort`] = true,
    [`stt_prop_stunt_track_dwslope15`] = true,
    [`stt_prop_stunt_track_dwslope30`] = true,
    [`stt_prop_stunt_track_dwslope45`] = true,
    [`stt_prop_stunt_track_dwturn`] = true,
    [`stt_prop_stunt_track_dwuturn`] = true,
    [`stt_prop_stunt_track_exshort`] = true,
    [`stt_prop_stunt_track_fork`] = true,
    [`stt_prop_stunt_track_funlng`] = true,
    [`stt_prop_stunt_track_funnel`] = true,
    [`stt_prop_stunt_track_hill`] = true,
    [`stt_prop_stunt_track_hill2`] = true,
    [`stt_prop_stunt_track_jump`] = true,
    [`stt_prop_stunt_track_link`] = true,
    [`stt_prop_stunt_track_otake`] = true,
    [`stt_prop_stunt_track_sh15`] = true,
    [`stt_prop_stunt_track_sh30`] = true,
    [`stt_prop_stunt_track_sh45`] = true,
    [`stt_prop_stunt_track_sh45_a`] = true,
    [`stt_prop_stunt_track_short`] = true,
    [`stt_prop_stunt_track_slope15`] = true,
    [`stt_prop_stunt_track_slope30`] = true,
    [`stt_prop_stunt_track_slope45`] = true,
    [`stt_prop_stunt_track_start`] = true,
    [`stt_prop_stunt_track_start_02`] = true,
    [`stt_prop_stunt_track_straight`] = true,
    [`stt_prop_stunt_track_straightice`] = true,
    [`stt_prop_stunt_track_st_01`] = true,
    [`stt_prop_stunt_track_st_02`] = true,
    [`stt_prop_stunt_track_turn`] = true,
    [`stt_prop_stunt_track_turnice`] = true,
    [`stt_prop_stunt_track_uturn`] = true,
    [`stt_prop_stunt_tube_crn`] = true,
    [`stt_prop_stunt_tube_crn2`] = true,
    [`stt_prop_stunt_tube_crn_15d`] = true,
    [`stt_prop_stunt_tube_crn_30d`] = true,
    [`stt_prop_stunt_tube_crn_5d`] = true,
    [`stt_prop_stunt_tube_cross`] = true,
    [`stt_prop_stunt_tube_end`] = true,
    [`stt_prop_stunt_tube_ent`] = true,
    [`stt_prop_stunt_tube_fn_01`] = true,
    [`stt_prop_stunt_tube_fn_02`] = true,
    [`stt_prop_stunt_tube_fn_03`] = true,
    [`stt_prop_stunt_tube_fn_04`] = true,
    [`stt_prop_stunt_tube_fn_05`] = true,
    [`stt_prop_stunt_tube_fork`] = true,
    [`stt_prop_stunt_tube_gap_01`] = true,
    [`stt_prop_stunt_tube_gap_02`] = true,
    [`stt_prop_stunt_tube_gap_03`] = true,
    [`stt_prop_stunt_tube_hg`] = true,
    [`stt_prop_stunt_tube_jmp`] = true,
    [`stt_prop_stunt_tube_jmp2`] = true,
    [`stt_prop_stunt_tube_l`] = true,
    [`stt_prop_stunt_tube_m`] = true,
    [`stt_prop_stunt_tube_qg`] = true,
    [`stt_prop_stunt_tube_s`] = true,
    [`stt_prop_stunt_tube_speed`] = true,
    [`stt_prop_stunt_tube_speeda`] = true,
    [`stt_prop_stunt_tube_speedb`] = true,
    [`stt_prop_stunt_tube_xs`] = true,
    [`stt_prop_stunt_tube_xxs`] = true,
    [`stt_prop_stunt_wideramp`] = true,
    [`stt_prop_track_bend2_bar_l`] = true,
    [`stt_prop_track_bend2_bar_l_b`] = true,
    [`stt_prop_track_bend2_l`] = true,
    [`stt_prop_track_bend2_l_b`] = true,
    [`stt_prop_track_bend_15d`] = true,
    [`stt_prop_track_bend_15d_bar`] = true,
    [`stt_prop_track_bend_180d`] = true,
    [`stt_prop_track_bend_180d_bar`] = true,
    [`stt_prop_track_bend_30d`] = true,
    [`stt_prop_track_bend_30d_bar`] = true,
    [`stt_prop_track_bend_5d`] = true,
    [`stt_prop_track_bend_5d_bar`] = true,
    [`stt_prop_track_bend_bar_l`] = true,
    [`stt_prop_track_bend_bar_l_b`] = true,
    [`stt_prop_track_bend_bar_m`] = true,
    [`stt_prop_track_bend_l`] = true,
    [`stt_prop_track_bend_l_b`] = true,
    [`stt_prop_track_bend_m`] = true,
    [`stt_prop_track_block_01`] = true,
    [`stt_prop_track_block_02`] = true,
    [`stt_prop_track_block_03`] = true,
    [`stt_prop_track_chicane_l`] = true,
    [`stt_prop_track_chicane_l_02`] = true,
    [`stt_prop_track_chicane_r`] = true,
    [`stt_prop_track_chicane_r_02`] = true,
    [`stt_prop_track_cross`] = true,
    [`stt_prop_track_cross_bar`] = true,
    [`stt_prop_track_fork`] = true,
    [`stt_prop_track_fork_bar`] = true,
    [`stt_prop_track_funnel`] = true,
    [`stt_prop_track_funnel_ads_01a`] = true,
    [`stt_prop_track_funnel_ads_01b`] = true,
    [`stt_prop_track_funnel_ads_01c`] = true,
    [`stt_prop_track_jump_01a`] = true,
    [`stt_prop_track_jump_01b`] = true,
    [`stt_prop_track_jump_01c`] = true,
    [`stt_prop_track_jump_02a`] = true,
    [`stt_prop_track_jump_02b`] = true,
    [`stt_prop_track_jump_02c`] = true,
    [`stt_prop_track_link`] = true,
    [`stt_prop_track_slowdown`] = true,
    [`stt_prop_track_slowdown_t1`] = true,
    [`stt_prop_track_slowdown_t2`] = true,
    [`stt_prop_track_speedup`] = true,
    [`stt_prop_track_speedup_t1`] = true,
    [`stt_prop_track_speedup_t2`] = true,
    [`stt_prop_track_start`] = true,
    [`stt_prop_track_start_02`] = true,
    [`stt_prop_track_stop_sign`] = true,
    [`stt_prop_track_straight_bar_l`] = true,
    [`stt_prop_track_straight_bar_m`] = true,
    [`stt_prop_track_straight_bar_s`] = true,
    [`stt_prop_track_straight_l`] = true,
    [`stt_prop_track_straight_lm`] = true,
    [`stt_prop_track_straight_lm_bar`] = true,
    [`stt_prop_track_straight_m`] = true,
    [`stt_prop_track_straight_s`] = true,
    [`stt_prop_track_tube_01`] = true,
    [`stt_prop_track_tube_02`] = true,
    [`stt_prop_tyre_wall_01`] = true,
    [`stt_prop_tyre_wall_010`] = true,
    [`stt_prop_tyre_wall_011`] = true,
    [`stt_prop_tyre_wall_012`] = true,
    [`stt_prop_tyre_wall_013`] = true,
    [`stt_prop_tyre_wall_014`] = true,
    [`stt_prop_tyre_wall_015`] = true,
    [`stt_prop_tyre_wall_02`] = true,
    [`stt_prop_tyre_wall_03`] = true,
    [`stt_prop_tyre_wall_04`] = true,
    [`stt_prop_tyre_wall_05`] = true,
    [`stt_prop_tyre_wall_06`] = true,
    [`stt_prop_tyre_wall_07`] = true,
    [`stt_prop_tyre_wall_08`] = true,
    [`stt_prop_tyre_wall_09`] = true,
    [`stt_prop_tyre_wall_0l010`] = true,
    [`stt_prop_tyre_wall_0l012`] = true,
    [`stt_prop_tyre_wall_0l013`] = true,
    [`stt_prop_tyre_wall_0l014`] = true,
    [`stt_prop_tyre_wall_0l015`] = true,
    [`stt_prop_tyre_wall_0l018`] = true,
    [`stt_prop_tyre_wall_0l019`] = true,
    [`stt_prop_tyre_wall_0l020`] = true,
    [`stt_prop_tyre_wall_0l04`] = true,
    [`stt_prop_tyre_wall_0l05`] = true,
    [`stt_prop_tyre_wall_0l06`] = true,
    [`stt_prop_tyre_wall_0l07`] = true,
    [`stt_prop_tyre_wall_0l08`] = true,
    [`stt_prop_tyre_wall_0l1`] = true,
    [`stt_prop_tyre_wall_0l16`] = true,
    [`stt_prop_tyre_wall_0l17`] = true,
    [`stt_prop_tyre_wall_0l2`] = true,
    [`stt_prop_tyre_wall_0l3`] = true,
    [`stt_prop_tyre_wall_0r010`] = true,
    [`stt_prop_tyre_wall_0r011`] = true,
    [`stt_prop_tyre_wall_0r012`] = true,
    [`stt_prop_tyre_wall_0r013`] = true,
    [`stt_prop_tyre_wall_0r014`] = true,
    [`stt_prop_tyre_wall_0r015`] = true,
    [`stt_prop_tyre_wall_0r016`] = true,
    [`stt_prop_tyre_wall_0r017`] = true,
    [`stt_prop_tyre_wall_0r018`] = true,
    [`stt_prop_tyre_wall_0r019`] = true,
    [`stt_prop_tyre_wall_0r04`] = true,
    [`stt_prop_tyre_wall_0r05`] = true,
    [`stt_prop_tyre_wall_0r06`] = true,
    [`stt_prop_tyre_wall_0r07`] = true,
    [`stt_prop_tyre_wall_0r08`] = true,
    [`stt_prop_tyre_wall_0r09`] = true,
    [`stt_prop_tyre_wall_0r1`] = true,
    [`stt_prop_tyre_wall_0r2`] = true,
    [`stt_prop_tyre_wall_0r3`] = true,
    [`stt_prop_wallride_01`] = true,
    [`stt_prop_wallride_01b`] = true,
    [`stt_prop_wallride_02`] = true,
    [`stt_prop_wallride_02b`] = true,
    [`stt_prop_wallride_04`] = true,
    [`stt_prop_wallride_05`] = true,
    [`stt_prop_wallride_05b`] = true,
    [`stt_prop_wallride_45l`] = true,
    [`stt_prop_wallride_45la`] = true,
    [`stt_prop_wallride_45r`] = true,
    [`stt_prop_wallride_45ra`] = true,
    [`stt_prop_wallride_90l`] = true,
    [`stt_prop_wallride_90lb`] = true,
    [`stt_prop_wallride_90r`] = true,
    [`stt_prop_wallride_90rb`] = true,
    [`prop_air_trailer_4a`] = true,
    [`prop_air_trailer_4b`] = true,
    [`prop_air_trailer_4c`] = true,
    [`prop_air_watertank1`] = true,
    [`prop_air_watertank2`] = true
}     


if Config.onesync then
AddEventHandler('entityCreating', function(entity)
     if stuntProps[GetEntityModel(entity)] then
     	CancelEvent()
         local owner = NetworkGetEntityOwner(entity)
         local name = GetPlayerName(owner)
         local license, steam, discord = GetPlayerNeededIdentifiers(source)
         DropPlayer(owner, "ANTICHEAT: Spawning props")
         sendDiscord('gbmm Anticheat', '**User:** '..name..'\n**Reason:** Possibly spawning props\n**License:** '.. license ..'\n**Steam:** '.. steam..'\n**Discord UID:** '.. discord ..'')
     end
 end)

 local BlacklistVehicles = { `HYDRA`, `TUG`, `CARGOPLANE`, `LAZER`, `JET`, `BUZZARD`, `BLIMP`, `BLIMP2`, `BLIMP3`, `DUMP`, `TANKER2` }

 if Config.onesync then
 AddEventHandler("entityCreated", function(entity)
     if entity and DoesEntityExist(entity) then
     	local eowner = NetworkGetEntityOwner(entity)
     	--local name = GetPlayerName(eowner)
     	local license, steam, discord = GetPlayerNeededIdentifiers(eowner)
         for _, vehicle in ipairs(BlacklistVehicles) do
             if GetEntityModel(entity) == vehicle then
                 Citizen.InvokeNative(0xFAA3D236, entity) -- DeleteEntity
                 --DropPlayer(eowner, "ANTICHEAT: Spawning blacklisted vehicles")
                 --local isKnown, isKnownCount = WarnPlayer(eowner, "Spawning blacklisted vehicles")
                 sendDiscord('gbmm Anticheat', '**User:** '..GetPlayerName(eowner)..'\n**Reason:** Spawning blacklisted vehicles\n**License:** '.. license ..'\n**Steam:** '.. steam..'\n**Discord UID:** '.. discord ..'')
             end
         end
     end
 end)

 if Config.onesync then
 AddEventHandler("entityCreated", function(entity)
     local blacklistedPed = "s_m_y_swat_01"
     local entityModel = GetEntityModel(entity)
     if entityModel == GetHashKey(blacklistedPed) then
         local entityOwner = NetworkGetEntityOwner(entity)
         DeleteEntity(entity)
         DropPlayer(entityOwner, "ANTICHEAT: Spawning peds")
     end
 end)





-- Version Check
Citizen.CreateThread(
	function()
		local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
		if vRaw and Config.versionCheck then
			local v = json.decode(vRaw)
			PerformHttpRequest(
				'https://raw.githubusercontent.com/Swqppingg/gbmm-fivem-anticheat/main/version.json',
				function(code, res, headers)
					if code == 200 then
						local rv = json.decode(res)
						if rv.version ~= v.version then
							print(
								([[^1
-------------------------------------------------------
gbmm Anticheat
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
^0]]):format(
									rv.version,
									rv.changelog
								)
							)
						end
					else
						print('^gbmm Anticheat was unable to check version^0')
					end
				end,
				'GET'
			)
		end
	end
)