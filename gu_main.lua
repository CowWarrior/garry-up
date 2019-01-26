local _, garryup = ...

-- *****************************************************************************
-- *
-- *                            GarryUp! Main Module
-- *
-- * Created by: CowWarrior
-- * Created on: 2019-01-11
-- * Updated on: 2019-01-25
-- * 
-- * Tested on : WOW 8.1
-- *
-- *****************************************************************************

-- Change log:
-- Now has full ist of achievements
-- Now shows achievements specific to your faction.
-- Now shows all achievements icons
-- Re-scoped data to use only one global vatiable

--Issues
-- Some text is wider than frames

-- TODO
-- Implement option frame
-- Implement option to show progress as percentage or progress bars
-- Implement option to hide completed quests / achievements 
-- Implement dynamic frame height
-- Implement links to achievements
-- Implement hide on combat option

-- re-scoping
GarryUp = garryup; -- Make local code available globally

-- Constants
local         NAME = "Garry Up!";
local GU_FRAME_W = 240;
local GU_FRAME_H = 140;
local GU_DEBUG = false;
local GU_DEBUG_LEVEL = 1;

-- Variables
local guHookWasActive = false;
local guBaitWasActive = false;
local guBobberWasActive = false;
local guCurrentZone = "";
local guAutoHideOnCombat = false;
local guAutoShowOnFish = false;
local guPlayerFaction = ""
local guFullyLoaded = false;


function GarryUp_OnLoad()
	-- Register Slash commands
	SLASH_GarryUp1 = "/gup"
	SlashCmdList["GarryUp"] = GarryUp_SlashCommand;

	-- Resgister Events
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_BUFF_CHANGED);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_LOOT);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_ZONE_CHANGED);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_LOGIN);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_ACHIEVEMENT);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_MINIZONE_CHANGED);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_QUEST_COMPLETE);
	GarryUpCoreFrame:RegisterEvent(GarryUpData.EVENT_BAG_UPDATE);
	
	-- All done
	GarryUp_Print("v"..GetAddOnMetadata("GarryUp","Version").." loaded. (type /gup for options)", GarryUpData.COLOR_ADDON);	
end

function GarryUp_OnMainFrameLoad()
	--this is silly, this should be static XML....
	GarryUpFrameFishButton.icon:SetTexture(GarryUpData.TEXTURE_ID_FISHING);
	GarryUpFrameFishButton:SetScale(0.75);
	
	GarryUpFrameMountButton.icon:SetTexture(GarryUpData.TEXTURE_ID_MOUNT);
	GarryUpFrameMountButton:SetScale(0.75);
end

function GarryUp_OnMinerAdviserFrameLoad()
	GarryUp_InitItemButton(GarryUpMinerAdvisorFrameCoffeeButton, GarryUpData.ITEM_MINER_COFFEE);
	GarryUp_InitItemButton(GarryUpMinerAdvisorFramePickButton, GarryUpData.ITEM_PRESERVED_PICK);
end

function GarryUp_OnMiniFrameLoad()
	MiniFrameGarryUpButton.icon:SetTexture(GarryUpData.TEXTURE_ID_GARRYUP);
	MiniFrameGarryUpButton.icon:SetPoint("TOPLEFT", 0, 0);
end

function GarryUp_OnEvent(self, event, ...)
	if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
		GarryUp_Print("Event:"..event);
	end
	
	if event == GarryUpData.EVENT_LOOT then
		GarryUp_RefreshAngler();
	elseif event == GarryUpData.EVENT_BUFF_CHANGED then
		--Check for bait/hook for current zone
		
		if GU_DEBUG and GU_DEBUG_LEVEL > 2 then
			GarryUp_Print("BaitWasActive? "..GarryUp_BoolToString(guBaitWasActive));
			GarryUp_Print("HookWasActive? "..GarryUp_BoolToString(guHookWasActive));
			GarryUp_Print("BobberWasActive? "..GarryUp_BoolToString(guBobberWasActive));
			GarryUp_Print("Active buffs:\r"..GarryUp_EnumerateAllBuff());
		end		
		
		if GarryUp_CheckBuff(GarryUpData.BUFF_BOBBER) then
			-- we got bobber
			guBobberWasActive = true;
		elseif guBobberWasActive then
			-- we lost bobber
			PlaySound(GarryUpData.SOUND_QUEST_LOG_ABANDON_QUEST);
			guBobberWasActive = false;
			GarryUp_Print("You need to reapply your "..GarryUpData.BUFF_BOBBER.."!", GarryUpData.COLOR_RED);
		else
			-- bobber is off
		end
		-- update button state
		GarryUp_SetItemButtonActive(GarryUpAnglerFrameBobberButton, not guBobberWasActive)

		if GarryUp_CheckBuff(GarryUpData.BUFF_HOOK) then
			-- we got hook
			guHookWasActive = true;
		elseif guHookWasActive then
			-- we lost hook
			PlaySound(GarryUpData.SOUND_QUEST_LOG_ABANDON_QUEST);
			guHookWasActive = false;
			GarryUp_Print("You need to reapply your "..GarryUpData.BUFF_HOOK.."!", GarryUpData.COLOR_RED);
		else
			-- hook is off
		end
		
		if GarryUp_CheckBuff(GarryUp_GetBaitBuff(guCurrentZone)) then
			-- we got bait
			guBaitWasActive = true;
		elseif guBaitWasActive then
			-- we lost bait
			PlaySound(GarryUpData.SOUND_QUEST_LOG_ABANDON_QUEST);
			guBaitWasActive = false;
			GarryUp_Print("You need to reapply "..GarryUp_GetBaitBuff(guCurrentZone).."!", GarryUpData.COLOR_RED);
		else
			-- bait is off
		end
	elseif event == GarryUpData.EVENT_QUEST_COMPLETE then
		--Refresh
		GarryUp_RefreshMOM();
	elseif event == GarryUpData.EVENT_BAG_UPDATE then
		--Refresh Salvage
		--Already cought in refresh below. No need to refresh here
	elseif event == GarryUpData.EVENT_MINIZONE_CHANGED then
			if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
				GarryUp_Print("Subzone Changed: "..GetMinimapZoneText());
			end
			
			if GetMinimapZoneText() == GarryUpData.MINIZONE_GARRISON_MINE then
				GarryUp_ShowMinerAdvisor();
				GarryUp_Print("We recommend you consume [Miner's Coffee] and [Preserved Mining Pick].");
			else
				--Auto-hide miner advisor
				GarryUp_HideMinerAdvisor();
			end
	elseif event == GarryUpData.EVENT_ZONE_CHANGED then
		--Zone changed check for specific zone baits and fish to catch
		guCurrentZone = GetZoneText();
		
		if GU_DEBUG then
			GarryUp_Print("New zone: "..guCurrentZone);
		end
		
		GarryUp_RecommendAngler(guCurrentZone);
	elseif event == GarryUpData.EVENT_LOGIN then
		--Initial world data is now available
		
		-- Check buff initial state
		guCurrentZone = GetZoneText();
		guHookWasActive = GarryUp_CheckBuff(GarryUpData.BUFF_HOOK);
		guBobberWasActive = GarryUp_CheckBuff(GarryUpData.BUFF_BOBBER);
		--Bait info will be cought by the 'zone changed'
		
		--PLayer info
		guPlayerFaction = UnitFactionGroup("player");
		
		if GU_DEBUG then
			GarryUp_Print(GarryUpData.EVENT_LOGIN.." Current Zone: "..guCurrentZone);
			GarryUp_Print(GarryUpData.EVENT_LOGIN.." BobberWasActive? "..GarryUp_BoolToString(guBobberWasActive));
			GarryUp_Print(GarryUpData.EVENT_LOGIN.." HookWasActive? "..GarryUp_BoolToString(guHookWasActive));
		end	
	
		-- now, all data is available 
		guFullyLoaded = true;
	else
		if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
			GarryUp_Print("Unhandled event: "..event);
		end
	end

	-- Update Draenor data on any event
	GarryUp_RefreshDraenor();
		
end

function GarryUp_OnButtonFishClick()
	GarryUp_ShowAngler();
end

function GarryUp_OnButtonMountClick()
	GarryUpMOMFrame:Show();
	GarryUp_RefreshMOM();
end

function GarryUp_OnButtonGarryUpClick()
	GarryUp_ShowMain();
end


function GarryUp_InitItemButton(buttonRef, itemID)
	local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID);
	
	if GU_DEBUG and GU_DEBUG_LEVEL > 2 then
		GarryUp_Print("Set button Icon itemID"..itemID.." name:"..name.." texture:"..icon);
	end
	
	buttonRef:SetAttribute("type", "item");
	buttonRef:SetAttribute("*item1", name);
	buttonRef:SetAttribute("itemid", itemID);
	buttonRef:SetText(name);
	buttonRef.icon:SetTexture(icon);
	buttonRef:SetAttribute("checkselfcast","1");
	buttonRef:SetAttribute("checkfocuscast","1");
	buttonRef:SetAttribute("enabled", true);
end

function GarryUp_SetItemButtonActive(buttonRef, active)
	buttonRef:SetAttribute("enabled", true);
end

function GarryUp_IsInDraenor(excludeGarrison)
	local ret = false;
	local zone = GetZoneText();
	
	--default value to false
	excludeGarrison = excludeGarrison or false;
	
	
	if zone then
		if (zone == GarryUpData.ZONE_GARRISON and excludeGarrison == false) or 
			zone == GarryUpData.ZONE_SHADOWMOON or
			zone == GarryUpData.ZONE_TALADOR or
			zone == GarryUpData.ZONE_NAGRAND or
			zone == GarryUpData.ZONE_ARAK or
			zone == GarryUpData.ZONE_GORGOND or
			zone == GarryUpData.ZONE_FROSTFIRE or
			zone == GarryUpData.ZONE_DRAENOR_OCEAN then
			
			ret = true;	
		end
	end

	return ret;
end

function GarryUp_Print(text, color)
	local chatText = GarryUpData.COLOR_ADDON..GetAddOnMetadata("GarryUp","Title").." - "..GarryUpData.COLOR_END;
	
	if color then
		chatText = chatText..color..text..GarryUpData.COLOR_END;
	else
		chatText = chatText..text;
	end
	
	print(chatText);
end

function GarryUp_BoolToString(boolValue)
	if boolValue then
		return "true";
	else
		return "false";
	end
end

function GarryUp_CheckBuff(buffName)
	local ret = false;
	local i=1;
	
	for i=1,40 do
		local name, icon, _, _, _, etime = UnitBuff("player",i)
		
		if name then
		  if name == buffName then
			--buff was found
			ret = true;
		  end
		end
	end
	
	return ret;
end

function GarryUp_EnumerateAllBuff()
	local ret = "";
	local i=1;
	
	for i=1,40 do
		local name, icon, _, _, _, etime = UnitBuff("player",i)
		
		if name then
			ret = ret..name.."\r";
		end
	end
	
	return ret;
end

function GarryUp_GetAchData(achID)
	local achTbl = { GetAchievementCriteriaInfo(achID,1) };
	return achTbl[4].."/"..achTbl[5];
end

function GarryUp_GetAchDataGold(achID)
	local achTbl = { GetAchievementCriteriaInfo(achID,1) };
	return math.floor(achTbl[4] / 10000) .."/".. math.floor(achTbl[5] / 10000);
end

function GarryUp_GetAchProgressColor(achID)
	local retColor = GarryUpData.COLOR_PROGRESS_0;
	local achTbl = { GetAchievementCriteriaInfo(achID,1) };
	local progress = math.floor(achTbl[4] / achTbl[5] * 100 + 0.5);
	
	if progress >= 100 then
		retColor = GarryUpData.COLOR_PROGRESS_100;
	elseif progress >= 75 then
		retColor = GarryUpData.COLOR_PROGRESS_75;
	elseif progress >= 50 then
		retColor = GarryUpData.COLOR_PROGRESS_50;
	elseif progress >= 25 then
		retColor = GarryUpData.COLOR_PROGRESS_25;
	end
		
	return retColor;
end


function GarryUp_GetQuestLineData(questLine)
	local questCount = 0;
	local questCompletedCount = 0;

	for key, value in ipairs(questLine) do
		questCount = questCount + 1;
		
		if IsQuestFlaggedCompleted(questLine[key].ID) then
			questCompletedCount = questCompletedCount + 1;
		end
	end

	return questCompletedCount.."/"..questCount;
end

function GarryUp_GetQuestLineBulkText(questLine)
	local outText = "";

	for key, value in ipairs(questLine) do
		if IsQuestFlaggedCompleted(questLine[key].ID) then
			outText = outText..GarryUpData.COLOR_PROGRESS_100..string.rep(" ", questLine[key].DEPTH*4)..questLine[key].NAME..GarryUpData.COLOR_END..GarryUpData.TXTICO_CHECK;
		else
			outText = outText..GarryUpData.COLOR_PROGRESS_0..string.rep(" ", questLine[key].DEPTH*4)..questLine[key].NAME..GarryUpData.COLOR_END;
		end
		
		outText = outText.."\n";
	end

	return outText;
end

function GarryUp_GetAnglerDataBulkText()
	local outText = "";
	
	for key, _ in ipairs(GarryUpData.Angler) do
		if not GarryUpData.Angler[key].Skip then
			local id, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(GarryUpData.Angler[key].AchId);
			
			outText = outText..GarryUpData.TXTICO_START..icon..GarryUpData.TXTICO_END..GarryUp_GetAchProgressColor(id)..name;
			
			if completed then
				outText = outText.." "..GarryUpData.COLOR_END..GarryUpData.TXTICO_CHECK.."\r";
			else
				outText = outText.." ("..GarryUp_GetAchData(id)..")"..GarryUpData.COLOR_END.."\r";
			end	
		end
	end
	
	return outText;
end

function GarryUp_GetAnglerData()
	local completeCount, totalCount = 0, 0;
	
	for key, _ in ipairs(GarryUpData.Angler) do
		if not GarryUpData.Angler[key].Skip then
			local id, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(GarryUpData.Angler[key].AchId);
			
			totalCount = totalCount + 1;
			
			if completed then
				completeCount = completeCount + 1;
			end	
		end
	end
	
	return completeCount.."/"..totalCount;
end

function GarryUp_RecommendAngler(targetZone)
	--check if we're in a zone first (otherwise it crashes when stoning)
	if GarryUp_IsInDraenor(true) then 
		if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
			GarryUp_Print("Draenor!");
		end
		
		for key, _ in ipairs(GarryUpData.Angler) do
			if GarryUpData.Angler[key].Zone == targetZone then
				GarryUp_Print("We recommend you fish for "..GarryUpData.COLOR_GREEN..GarryUpData.Angler[key].FishName..GarryUpData.COLOR_END.."!");
				GarryUpAnglerFrameBaitButton:Show();
				GarryUp_InitItemButton(GarryUpAnglerFrameBaitButton, GarryUpData.Angler[key].BaitId);
			end
		end			
	else
		if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
			GarryUp_Print("Not in Draenor...");
		end
		-- We're not in Draenor anymore!
		GarryUpAnglerFrameBaitButton:Hide();
	end
end

function GarryUp_GetBaitBuff(targetZone)
	local baitId = GarryUp_GetBait(targetZone);	
	
	if baitId then
		--The buff is equal to the item name in this case
		return GetItemInfo(baitId);
	end
	
	return nil;
end

function GarryUp_GetBait(targetZone)
	--check if we're in a zone first (there are no baits outside Draenor)
	if GarryUp_IsInDraenor(true) then
		for key, _ in ipairs(GarryUpData.Angler) do
			if GarryUpData.Angler[key].Zone == targetZone then
				return GarryUpData.Angler[key].BaitId;
			end
		end			
	end
	
	--no bait found
	return nil;
end

function GarryUp_ShowAngler()
	GarryUpAnglerFrame:Show();
	GarryUp_RefreshAngler();
end

function GarryUp_RefreshAngler()
	if guFullyLoaded then
		GarryUpAnglerFrameText:SetText(GarryUp_GetAnglerDataBulkText());
		
		-- Hook
		GarryUp_InitItemButton(GarryUpAnglerFrameHookButton, GarryUpData.ITEM_BLADEBONE_HOOK);
		-- Bobber
		GarryUp_InitItemButton(GarryUpAnglerFrameBobberButton, GarryUpData.ITEM_OVERSIZED_BOBBER);
		-- Bait
		if GarryUp_IsInDraenor(true) then
			GarryUpAnglerFrameBaitButton:Show();
			GarryUp_InitItemButton(GarryUpAnglerFrameBaitButton, GarryUp_GetBait(guCurrentZone));
		else
			GarryUpAnglerFrameBaitButton:Hide();
		end
	end
end

function GarryUp_GetDraenorDataBulkText()
	local outText = "";
	
	for key, _ in ipairs(GarryUpData.BuildingsLv3) do
	
		-- Only show matching faction or faction neutral achievements
		if (not GarryUpData.BuildingsLv3[key].FactionGroup) or (GarryUpData.BuildingsLv3[key].FactionGroup == guPlayerFaction) then
	
			local id, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(GarryUpData.BuildingsLv3[key].AchId);			
			
			--TODO: Very ugly hack, need to fix this properly
			if GarryUpData.BuildingsLv3[key].AchType == "Gold" then
				outText = outText..GarryUpData.TXTICO_START..icon..GarryUpData.TXTICO_END.." "..GarryUp_GetAchProgressColor(id).."Draenor Money";
			else
				outText = outText..GarryUpData.TXTICO_START..icon..GarryUpData.TXTICO_END.." "..GarryUp_GetAchProgressColor(id)..name;
			end
						
			if completed then
				--this is complete. no need to show progress
				outText = outText.." "..GarryUpData.COLOR_END..GarryUpData.TXTICO_CHECK.."\r";
			else
				--Show specific progress
				if GarryUpData.BuildingsLv3[key].AchType == "AchLine" then
					-- Achievement Line
					--Note: lazy way of doing things, there should be a table to hold achievement lines
					outText = outText.." ("..GarryUp_GetAnglerData()..")"..GarryUpData.COLOR_END.."\r";					
				elseif GarryUpData.BuildingsLv3[key].AchType == "QuestLine" then
					-- Quest Line
					--Note: lazy way of doing things, there should be a table to hold quest lines 					
					outText = outText.." ("..GarryUp_GetQuestLineData(GarryUpData.QST_MOM[guPlayerFaction])..")"..GarryUpData.COLOR_END.."\r";
				elseif GarryUpData.BuildingsLv3[key].AchType == "Gold" then
					-- Gold
					outText = outText.." ("..GarryUp_GetAchDataGold(GarryUpData.BuildingsLv3[key].AchId)..")"..GarryUpData.COLOR_END.."\r";
				else
					-- Standard
					outText = outText.." ("..GarryUp_GetAchData(GarryUpData.BuildingsLv3[key].AchId)..")"..GarryUpData.COLOR_END.."\r";
				end
			end
			
		end
	end

	return outText;
end

function GarryUp_RefreshMOM()
	if guFullyLoaded then
		GarryUpMOMFrameScrollText:SetText(GarryUp_GetMOMDataBulkText());
	end
end

function GarryUp_GetMOMDataBulkText()
	local outText = "";
	
	local _, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(GarryUpData.QST_MOM.AchId);
	
	if GU_DEBUG and GU_DEBUG_LEVEL > 2 then
		GarryUp_Print("MOM Icon: name:"..name.." texture:"..icon);
		GarryUp_Print("Player Faction:"..guPlayerFaction);
	end
	
	outText = GarryUpData.TXTICO_START .. icon .. GarryUpData.TXTICO_END..GetAchievementLink(GarryUpData.QST_MOM.AchId).. "\n\n";
	
	outText = outText..GarryUp_GetQuestLineBulkText(GarryUpData.QST_MOM[guPlayerFaction]);
	
	return outText;
end

function GarryUp_ShowMain()
	GarryUpFrame:Show();
	GarryUp_RefreshDraenor();
end

function GarryUp_RefreshDraenor()
	if guFullyLoaded then
		GarryUpFrameText:SetText(GarryUp_GetDraenorDataBulkText());
	end
end

function GarryUp_ShowMinerAdvisor()
	--Texture to use for portrait: 95893
	SetPortraitTexture(GarryUpMinerAdvisorFrame.portrait, "player")
	GarryUpMinerAdvisorFrame:Show();
end

function GarryUp_HideMinerAdvisor()
	GarryUpMinerAdvisorFrame:Hide();
end

function GarryUp_ResetWindow()
	GarryUpAnglerFrame:SetClampedToScreen(true);
	GarryUpAnglerFrame:SetWidth(GU_FRAME_W);
	GarryUpAnglerFrame:SetHeight(GU_FRAME_H);
	GarryUpAnglerFrame:SetPoint("TOPLEFT", 100, 0);
	GarryUpAnglerFrame:SetClampedToScreen(false);
	GarryUpAnglerFrame:Show();
	
	GarryUpFrame:SetClampedToScreen(true);
	GarryUpFrame:SetWidth(GU_FRAME_W);
	GarryUpFrame:SetHeight(GU_FRAME_H);
	GarryUpFrame:SetPoint("TOPLEFT", 0, 0);
	GarryUpFrame:SetClampedToScreen(false);
	GarryUpFrame:Show();
end

function GarryUp_PrintHelp()
	local helpText = "List of valid commands:\r"
	helpText = helpText.."/gup reset: Resets the window position to TOP LEFT.\r";
	helpText = helpText.."/gup show: Shows the window.\r";
	helpText = helpText.."/gup hide: Hides the window.\r";
	helpText = helpText.."/gup fish: Prints the fish you need to catch.\r";
	helpText = helpText.."/gup draenor: Prints the acheivements you need to get.\r";
	
	helpText = helpText.."/gup debug: Toggle debugging.\r";
	helpText = helpText.."/gup debug+: Increase debugging level. (give more details)\r";
	helpText = helpText.."/gup debug+: Decrease debugging level. (give less details)\r";
	
	GarryUp_Print(helpText);
end

function GarryUp_ToggleDebug()
	GU_DEBUG = not GU_DEBUG;
	
	if GU_DEBUG then
		GarryUp_Print("Debugging "..GarryUpData.COLOR_GREEN.."Enabled"..GarryUpData.COLOR_END.." (Level: "..GarryUpData.DEBUG_LEVEL..")");
	else
		GarryUp_Print("Debugging "..GarryUpData.COLOR_RED.."Disabled"..GarryUpData.COLOR_END);
	end
end

function GarryUp_ChangeDebugLevel(levelDelta)
	GU_DEBUG_LEVEL =  GU_DEBUG_LEVEL + levelDelta;
	
	if GU_DEBUG_LEVEL > 5 then
		GU_DEBUG_LEVEL = 5;
	elseif GU_DEBUG_LEVEL < 0 then
		GU_DEBUG_LEVEL = 0;
	end
	
	GarryUp_Print("Debugging Level set to: "..GU_DEBUG_LEVEL);
end

function GarryUp_SlashCommand(args, editbox)
    
	if args == "show" then
		GarryUpFrame:Show();
		GarryUp_ShowAngler()
	elseif args == "hide" then
		GarryUpAnglerFrame:Hide();
	elseif args == "fish" then
		GarryUp_Print(GarryUp_GetAnglerDataBulkText());
	elseif args == "draenor" then
		GarryUp_Print(GarryUp_GetDraenorDataBulkText());
	elseif args == "reset" then
		GarryUp_ResetWindow();
		GarryUp_Print("Frame position reset.")
	elseif args == "help" or args == "?" then
		GarryUp_PrintHelp();
	elseif args == "debug" then
		GarryUp_ToggleDebug();
	elseif args == "debug+" then
		GarryUp_ChangeDebugLevel(1);		
	elseif args == "debug-" then
		GarryUp_ChangeDebugLevel(-1);
	else
		GarryUp_Print("Unknown Command '"..args.."'.");
		GarryUp_PrintHelp();
	end
end

