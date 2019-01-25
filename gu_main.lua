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

-- Constants
local GU_NAME = "Garry Up!";
local GU_VERSION = " 0.2.190125";
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


function GarryUp_OnLoad()
	-- Register Slash commands
	SLASH_GarryUp1 = "/gup"
	SlashCmdList["GarryUp"] = GarryUp_SlashCommand;

	-- Resgister Events
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_BUFF_CHANGED);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_LOOT);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_ZONE_CHANGED);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_LOGIN);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_ACHIEVEMENT);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_MINIZONE_CHANGED);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_QUEST_COMPLETE);
	GarryUpCoreFrame:RegisterEvent(GU_EVENT_BAG_UPDATE);
	
	-- All done
	GarryUp_Print("v"..GU_VERSION.." loaded. (type /gup for options)", GU_COLOR_ADDON);	
end

function GarryUp_OnMainFrameLoad()
	--this is silly, this should be static XML....
	GarryUpFrameFishButton.icon:SetTexture(GU_TEXTURE_ID_FISHING);
	GarryUpFrameFishButton:SetScale(0.75);
	
	GarryUpFrameMountButton.icon:SetTexture(GU_TEXTURE_ID_MOUNT);
	GarryUpFrameMountButton:SetScale(0.75);
end

function GarryUp_OnMinerAdviserFrameLoad()
	GarryUp_InitItemButton(GarryUpMinerAdvisorFrameCoffeeButton, GU_ITEM_MINER_COFFEE);
	GarryUp_InitItemButton(GarryUpMinerAdvisorFramePickButton, GU_ITEM_PRESERVED_PICK);
end

function GarryUp_OnMiniFrameLoad()
	MiniFrameGarryUpButton.icon:SetTexture(GU_TEXTURE_ID_GARRYUP);
	MiniFrameGarryUpButton.icon:SetPoint("TOPLEFT", 0, 0);
end

function GarryUp_OnEvent(self, event, ...)
	if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
		GarryUp_Print("Event:"..event);
	end
	
	if event == GU_EVENT_LOOT then
		GarryUp_RefreshAngler();
	elseif event == GU_EVENT_BUFF_CHANGED then
		--Check for bait/hook for current zone
		
		if GU_DEBUG and GU_DEBUG_LEVEL > 2 then
			GarryUp_Print("BaitWasActive? "..GarryUp_BoolToString(guBaitWasActive));
			GarryUp_Print("HookWasActive? "..GarryUp_BoolToString(guHookWasActive));
			GarryUp_Print("BobberWasActive? "..GarryUp_BoolToString(guBobberWasActive));
			GarryUp_Print("Active buffs:\r"..GarryUp_EnumerateAllBuff());
		end		
		
		if GarryUp_CheckBuff(GU_BUFF_BOBBER) then
			-- we got bobber
			guBobberWasActive = true;
		elseif guBobberWasActive then
			-- we lost bobber
			PlaySound(GU_SOUND_QUEST_LOG_ABANDON_QUEST);
			guBobberWasActive = false;
			GarryUp_Print("You need to reapply your "..GU_BUFF_BOBBER.."!", GU_COLOR_RED);
		else
			-- bobber is off
		end
		-- update button state
		GarryUp_SetItemButtonActive(GarryUpAnglerFrameBobberButton, not guBobberWasActive)

		if GarryUp_CheckBuff(GU_BUFF_HOOK) then
			-- we got hook
			guHookWasActive = true;
		elseif guHookWasActive then
			-- we lost hook
			PlaySound(GU_SOUND_QUEST_LOG_ABANDON_QUEST);
			guHookWasActive = false;
			GarryUp_Print("You need to reapply your "..GU_BUFF_HOOK.."!", GU_COLOR_RED);
		else
			-- hook is off
		end
		
		if GarryUp_CheckBuff(GarryUp_GetBaitBuff(guCurrentZone)) then
			-- we got bait
			guBaitWasActive = true;
		elseif guBaitWasActive then
			-- we lost bait
			PlaySound(GU_SOUND_QUEST_LOG_ABANDON_QUEST);
			guBaitWasActive = false;
			GarryUp_Print("You need to reapply "..GarryUp_GetBaitBuff(guCurrentZone).."!", GU_COLOR_RED);
		else
			-- bait is off
		end
	elseif event == GU_EVENT_QUEST_COMPLETE or event == GU_EVENT_BAG_UPDATE then
		--Refresh
		GarryUp_RefreshMOM();
	elseif event == GU_EVENT_MINIZONE_CHANGED then
			if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
				GarryUp_Print("Subzone Changed: "..GetMinimapZoneText());
			end
			
			if GetMinimapZoneText() == GU_MINIZONE_GARRISON_MINE then
				GarryUp_ShowMinerAdvisor();
				GarryUp_Print("We recommend you consume [Miner's Coffee] and [Preserved Mining Pick].");
			else
				--Auto-hide miner advisor
				GarryUp_HideMinerAdvisor();
			end
	elseif event == GU_EVENT_ZONE_CHANGED then
		--Zone changed check for specific zone baits and fish to catch
		guCurrentZone = GetZoneText();
		
		if GU_DEBUG then
			GarryUp_Print("New zone: "..guCurrentZone);
		end
		
		GarryUp_RecommendAngler(guCurrentZone);
	elseif event == GU_EVENT_LOGIN then
		--Initial world data is now available
		
		-- Check buff initial state
		guCurrentZone = GetZoneText();
		guHookWasActive = GarryUp_CheckBuff(GU_BUFF_HOOK);
		guBobberWasActive = GarryUp_CheckBuff(GU_BUFF_BOBBER);
		--Bait info will be cought by the 'zone changed'
		
		if GU_DEBUG then
			GarryUp_Print(GU_EVENT_LOGIN.." Current Zone: "..guCurrentZone);
			GarryUp_Print(GU_EVENT_LOGIN.." BobberWasActive? "..GarryUp_BoolToString(guBobberWasActive));
			GarryUp_Print(GU_EVENT_LOGIN.." HookWasActive? "..GarryUp_BoolToString(guHookWasActive));
		end	
	
		-- now that all data is available show frame
		--GarryUp_ShowAngler();
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
		if (zone == GU_ZONE_GARRISON and excludeGarrison == false) or 
			zone == GU_ZONE_SHADOWMOON or
			zone == GU_ZONE_TALADOR or
			zone == GU_ZONE_NAGRAND or
			zone == GU_ZONE_ARAK or
			zone == GU_ZONE_GORGOND or
			zone == GU_ZONE_FROSTFIRE or
			zone == GU_ZONE_DRAENOR_OCEAN then
			
			ret = true;	
		end
	end

	return ret;
end

function GarryUp_Print(text, color)
	local chatText = GU_COLOR_ADDON..GU_NAME.." - "..GU_COLOR_END;
	
	if color then
		chatText = chatText..color..text..GU_COLOR_END;
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
	local retColor = GU_COLOR_PROGRESS_0;
	local achTbl = { GetAchievementCriteriaInfo(achID,1) };
	local progress = math.floor(achTbl[4] / achTbl[5] * 100 + 0.5);
	
	if progress >= 100 then
		retColor = GU_COLOR_PROGRESS_100;
	elseif progress >= 75 then
		retColor = GU_COLOR_PROGRESS_75;
	elseif progress >= 50 then
		retColor = GU_COLOR_PROGRESS_50;
	elseif progress >= 25 then
		retColor = GU_COLOR_PROGRESS_25;
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
			outText = outText..GU_COLOR_PROGRESS_100..string.rep(" ", questLine[key].DEPTH*4)..questLine[key].NAME..GU_COLOR_END..GU_TXTICO_CHECK;
		else
			outText = outText..GU_COLOR_PROGRESS_0..string.rep(" ", questLine[key].DEPTH*4)..questLine[key].NAME..GU_COLOR_END;
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
			
			outText = outText..GU_TXTICO_START..icon..GU_TXTICO_END..GarryUp_GetAchProgressColor(id)..name;
			
			if completed then
				outText = outText.." "..GU_COLOR_END..GU_TXTICO_CHECK.."\r";
			else
				outText = outText.." ("..GarryUp_GetAchData(id)..")"..GU_COLOR_END.."\r";
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
	if GarryUp_IsInDraenor(true) then --and guCurrentZone ~= GU_ZONE_GARRISON then
		if GU_DEBUG and GU_DEBUG_LEVEL > 1 then
			GarryUp_Print("Draenor!");
		end
		
		for key, _ in ipairs(GarryUpData.Angler) do
			if GarryUpData.Angler[key].Zone == targetZone then
				GarryUp_Print("We recommend you fish for "..GU_COLOR_GREEN..GarryUpData.Angler[key].FishName..GU_COLOR_END.."!");
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
	GarryUpAnglerFrameText:SetText(GarryUp_GetAnglerDataBulkText());
	
	-- Hook
	GarryUp_InitItemButton(GarryUpAnglerFrameHookButton, GU_ITEM_BLADEBONE_HOOK);
	-- Bobber
	GarryUp_InitItemButton(GarryUpAnglerFrameBobberButton, GU_ITEM_OVERSIZED_BOBBER);
	-- Bait
	if GarryUp_IsInDraenor(true) then
		GarryUpAnglerFrameBaitButton:Show();
		GarryUp_InitItemButton(GarryUpAnglerFrameBaitButton, GarryUp_GetBait(guCurrentZone));
	else
		GarryUpAnglerFrameBaitButton:Hide();
	end
end

function GarryUp_GetDraenorDataBulkText()
	local outText = "";
	
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_ANGLER_ID)..GU_ACH_ANGLER_NAME.." "..GarryUp_GetAnglerData()..GU_COLOR_END.."\r";
	--outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MMOUNT_ID)..GU_ACH_MMOUNT_NAME.." "..GarryUp_GetAchData(GU_ACH_MMOUNT_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MMOUNT_ID)..GetAchievementLink(GU_ACH_MMOUNT_ID).." "..GarryUp_GetQuestLineData(GU_QST_MOM_A)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_RANKS_ID)..GU_ACH_RANKS_NAME.." "..GarryUp_GetAchData(GU_ACH_RANKS_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_PETB_ID)..GU_ACH_PETB_NAME.." "..GarryUp_GetAchData(GU_ACH_PETB_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MONEY_ID)..GU_ACH_MONEY_NAME.." "..GarryUp_GetAchDataGold(GU_ACH_MONEY_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MTH_ID)..GU_ACH_MTH_NAME.." "..GarryUp_GetAchData(GU_ACH_MTH_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_SALVAGING_ID)..GU_ACH_SALVAGING_NAME.." "..GarryUp_GetAchData(GU_ACH_SALVAGING_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_TRAPPER_ID)..GU_ACH_TRAPPER_NAME.." "..GarryUp_GetAchData(GU_ACH_TRAPPER_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_SAVAGEA_ID)..GU_ACH_SAVAGEA_NAME.." "..GarryUp_GetAchData(GU_ACH_SAVAGEA_ID)..GU_COLOR_END.."\r";



	return outText;
end

function GarryUp_RefreshMOM()
	GarryUpMOMFrameScrollText:SetText(GarryUp_GetMOMDataBulkText());
end

function GarryUp_GetMOMDataBulkText()
	local outText = "";
	
	local _, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(GU_ACH_MMOUNT_ID);
	
	if GU_DEBUG and GU_DEBUG_LEVEL > 2 then
		GarryUp_Print("MOM Icon: name:"..name.." texture:"..icon);
	end
	
	outText = GU_TXTICO_START .. icon .. GU_TXTICO_END..GetAchievementLink(GU_ACH_MMOUNT_ID).. "\n\n";
	
	outText = outText..GarryUp_GetQuestLineBulkText(GU_QST_MOM_A);
	
	return outText;
end

function GarryUp_ShowMain()
	GarryUpFrame:Show();
	GarryUp_RefreshDraenor();
end

function GarryUp_RefreshDraenor()
	GarryUpFrameText:SetText(GarryUp_GetDraenorDataBulkText());
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
		GarryUp_Print("Debugging "..GU_COLOR_GREEN.."Enabled"..GU_COLOR_END.." (Level: "..GU_DEBUG_LEVEL..")");
	else
		GarryUp_Print("Debugging "..GU_COLOR_RED.."Disabled"..GU_COLOR_END);
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

