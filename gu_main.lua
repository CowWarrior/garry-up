-- *****************************************************************************
-- *
-- *                            GarryUp! Main Module
-- *
-- * Created by: CowWarrior
-- * Created on: 2019-01-11
-- * Updated on: 2019-01-19
-- * 
-- * Tested on : WOW 8.1
-- *
-- *****************************************************************************


-- TODO: Split constants in a different file for readability
-- Constants
local GU_NAME = "Garry Up!";
local GU_VERSION = " 0.2.190119";
local GU_FRAME_W = 240;
local GU_FRAME_H = 140;
local GU_DEBUG = false;

-- Color Constants
local GU_COLOR_ADDON = "|cffff007f";
local GU_COLOR_END = "|r";
local GU_COLOR_RED = "|cffff0000";
local GU_COLOR_GREEN = "|cff00ff00";
local GU_COLOR_BLUE = "|cff0000ff";
local GU_COLOR_WHITE = "|cffffffff";
local GU_COLOR_BLACK = "|cff000000";
local GU_COLOR_PROGRESS_0 = "|cff7d7d7d"; --grey
local GU_COLOR_PROGRESS_25 = "|cff7d7d00"; --dark yellow
local GU_COLOR_PROGRESS_50 = "|cffffd100"; --brighter yellow
local GU_COLOR_PROGRESS_75 = "|cffffffff"; --white
local GU_COLOR_PROGRESS_100 = GU_COLOR_GREEN; --green

-- Chat Icons
local GU_TXTICO_CHECK = "!X!";
local GU_TXTICO_END = "|t";

-- Event Constants
local GU_EVENT_LOGIN = "PLAYER_LOGIN";
local GU_EVENT_LOOT = "CHAT_MSG_LOOT";
local GU_EVENT_BUFF_CHANGED = "UNIT_AURA";
local GU_EVENT_ZONE_CHANGED = "ZONE_CHANGED_NEW_AREA";
local GU_EVENT_ACHIEVEMENT = "ACHIEVEMENT_EARNED"

-- Buff Constants
local GU_BUFF_HOOK = "Bladebone Hook";
local GU_BUFF_BOBBER = "Oversized Bobber";
local GU_BUFF_SKULKER = "Jawless Skulker Bait";

-- Zone Constants
local GU_ZONE_GARRISON = "Lunarfall";
local GU_ZONE_SHADOWMOON = "Shadowmoon Valley";
local GU_ZONE_TALADOR = "Talador";
local GU_ZONE_NAGRAND = "Nagrand";
local GU_ZONE_ARAK = "Spires of Arak";
local GU_ZONE_GORGOND = "Gorgrond";
local GU_ZONE_FROSTFIRE = "Frostfire Ridge";
local GU_ZONE_DRAENOR_OCEAN = "Draenor Ocean"; --Not sure yet how I will handle this

-- Item Constants
local GU_ITEM_OVERSIZED_BOBBER = 136377;
local GU_ITEM_BLADEBONE_HOOK = 122742;

-- Texture constants
local GU_TEXTURE_ID_FISHING = 136245;
local GU_TEXTURE_ID_MOUNT = 975744; --631718;
local GU_TEXTURE_ID_GARRYUP = 1005027;

-- Sound Constants
local GU_SOUND_QUEST_LOG_ABANDON_QUEST = 846;

-- Achievements constants
local GU_ACH_ANGLER_ID = 9462;
local GU_ACH_ANGLER_NAME = "Draenor Angler";
local GU_ACH_MONEY_ID = 9487;
local GU_ACH_MONEY_NAME = "Draenor Money"; --Got My Mind On My Draenor Money
local GU_ACH_MMOUNT_ID = 9526;
local GU_ACH_MMOUNT_NAME = "Master of Mounts"; -- Intro to Husbandry is the pre-requisite acheivement
local GU_ACH_RANKS_ID = 9129;
local GU_ACH_RANKS_NAME = "Filling the Ranks";
local GU_ACH_PETB_ID = 9463;
local GU_ACH_PETB_NAME = "Draenic Pet Battler";
local GU_ACH_SAVAGEH_ID = 9477;
local GU_ACH_SAVAGEH_NAME = "Savage Friends (horde)";
local GU_ACH_SAVAGEA_ID = 9478;
local GU_ACH_SAVAGEA_NAME = "Savage Friends (alliance)";
local GU_ACH_MTH_ID = 10348; --9726  --10348;
local GU_ACH_MTH_NAME = "Master Treasure Hunter";


-- QuestLines

--TODO: Convert into generic variable (constant) name and have Horde/Alliance specific data loaded into it OnLoad
--      if UnitFactionGroup("player") == "Alliance" then
local GU_QST_MOM_A = {}
GU_QST_MOM_A = {
	{ID = 37028, NAME = "Wolf Training: The Garn", DEPTH = 1},
	{ID = 37027, NAME = "Wolf Training: Orc Hunters", DEPTH = 2},
	{ID = 37026, NAME = "Wolf Training: Ironbore", DEPTH = 2},
	{ID = 37025, NAME = "Wolf Training: Darkwing Roc", DEPTH = 2},
	{ID = 37024, NAME = "Wolf Training: Moth of Wrath", DEPTH = 2},
	{ID = 37023, NAME = "Wolf Training: Darkwing Roc", DEPTH = 2},
	{ID = 37022, NAME = "Wolf Training: Cruel Ogres", DEPTH = 2},
	
	{ID = 37021, NAME = "Elkk Training: The Garn", DEPTH = 1},
	{ID = 37020, NAME = "Elkk Training: Orc Hunters", DEPTH = 2},
	{ID = 37019, NAME = "Elkk Training: Ironbore", DEPTH = 2},
	{ID = 37018, NAME = "Elkk Training: Thundercall", DEPTH = 2},
	{ID = 37017, NAME = "Elkk Training: Moth of Wrath", DEPTH = 2},
	{ID = 37016, NAME = "Elkk Training: Darkwing Roc", DEPTH = 2},
	{ID = 37015, NAME = "Elkk Training: Cruel Ogres", DEPTH = 2},
	
	{ID = 37013, NAME = "Riverbeast Training: The Garn", DEPTH = 1},
	{ID = 37012, NAME = "Riverbeast Training: Orc Hunters", DEPTH = 2},
	{ID = 37011, NAME = "Riverbeast Training: Ironbore", DEPTH = 2},
	{ID = 37010, NAME = "Riverbeast Training: Thundercall", DEPTH = 2},
	{ID = 37009, NAME = "Riverbeast Training: Moth of Wrath", DEPTH = 2},
	{ID = 37008, NAME = "Riverbeast Training: Darkwing Roc", DEPTH = 2},
	{ID = 37007, NAME = "Riverbeast Training: Cruel Ogres", DEPTH = 2},
	{ID = 37006, NAME = "Riverbeast Training: Bulbapore", DEPTH = 2},
	{ID = 37005, NAME = "Riverbeast Training: Gezz'ran", DEPTH = 2},

	{ID = 37004, NAME = "Boar Training: The Garn", DEPTH = 1},
	{ID = 37003, NAME = "Boar Training: Orc Hunters", DEPTH = 2},
	{ID = 37002, NAME = "Boar Training: Ironbore", DEPTH = 2},
	{ID = 37001, NAME = "Boar Training: Thundercall", DEPTH = 2},
	{ID = 37000, NAME = "Boar Training: Moth of Wrath", DEPTH = 2},
	{ID = 36999, NAME = "Boar Training: Darkwing Roc", DEPTH = 2},
	{ID = 36998, NAME = "Boar Training: Cruel Ogres", DEPTH = 2},
	{ID = 36997, NAME = "Boar Training: Bulbapore", DEPTH = 2},
	{ID = 36996, NAME = "Boar Training: Gezz'ran", DEPTH = 2},
	{ID = 36995, NAME = "Boar Training: Riplash", DEPTH = 2},
	
	{ID = 36982, NAME = "Talbuk Training: The Garn", DEPTH = 1},
	{ID = 36981, NAME = "Talbuk Training: Orc Hunters", DEPTH = 2},
	{ID = 36980, NAME = "Talbuk Training: Ironbore", DEPTH = 2},
	{ID = 36979, NAME = "Talbuk Training: Thundercall", DEPTH = 2},
	{ID = 36978, NAME = "Talbuk Training: Moth of Wrath", DEPTH = 2},
	{ID = 36977, NAME = "Talbuk Training: Darkwing Roc", DEPTH = 2},
	{ID = 36976, NAME = "Talbuk Training: Cruel Ogres", DEPTH = 2},
	{ID = 36975, NAME = "Talbuk Training: Bulbapore", DEPTH = 2},
	{ID = 36974, NAME = "Talbuk Training: Gezz'ran", DEPTH = 2},
	{ID = 36973, NAME = "Talbuk Training: Riplash", DEPTH = 2},
	{ID = 36972, NAME = "Talbuk Training: Rakkiri", DEPTH = 2},
	
	{ID = 36994, NAME = "Clefthoof Training: The Garn", DEPTH = 1},
	{ID = 36993, NAME = "Clefthoof Training: Orc Hunters", DEPTH = 2},
	{ID = 36992, NAME = "Clefthoof Training: Ironbore", DEPTH = 2},
	{ID = 36991, NAME = "Clefthoof Training: Thundercall", DEPTH = 2},
	{ID = 36990, NAME = "Clefthoof Training: Moth of Wrath", DEPTH = 2},
	{ID = 36989, NAME = "Clefthoof Training: Darkwing Roc", DEPTH = 2},
	{ID = 36988, NAME = "Clefthoof Training: Cruel Ogres", DEPTH = 2},
	{ID = 36987, NAME = "Clefthoof Training: Bulbapore", DEPTH = 2},
	{ID = 36986, NAME = "Clefthoof Training: Gezz'ran", DEPTH = 2},
	{ID = 36985, NAME = "Clefthoof Training: Riplash", DEPTH = 2},
	{ID = 36984, NAME = "Clefthoof Training: Rakkiri", DEPTH = 2},
	{ID = 36983, NAME = "Clefthoof Training: Great-Tusk", DEPTH = 2}
	
}

local GU_QST_MOM_H = {}
GU_QST_MOM_H = {
	{ID = 37111, NAME = "Wolf Training: The Garn", DEPTH = 1},
	{ID = 37110, NAME = "Wolf Training: Orc Hunters", DEPTH = 2},
	{ID = 37109, NAME = "Wolf Training: Ironbore", DEPTH = 2},
	{ID = 37108, NAME = "Wolf Training: Darkwing Roc", DEPTH = 2},
	{ID = 37107, NAME = "Wolf Training: Moth of Wrath", DEPTH = 2},
	{ID = 37106, NAME = "Wolf Training: Darkwing Roc", DEPTH = 2},
	{ID = 37105, NAME = "Wolf Training: Cruel Ogres", DEPTH = 2},	
	
	{ID = 37069, NAME = "Elkk Training: The Garn", DEPTH = 1},
	{ID = 37068, NAME = "Elkk Training: Orc Hunters", DEPTH = 2},
	{ID = 37067, NAME = "Elkk Training: Ironbore", DEPTH = 2},
	{ID = 37066, NAME = "Elkk Training: Thundercall", DEPTH = 2},
	{ID = 37065, NAME = "Elkk Training: Moth of Wrath", DEPTH = 2},
	{ID = 37064, NAME = "Elkk Training: Darkwing Roc", DEPTH = 2},
	{ID = 37063, NAME = "Elkk Training: Cruel Ogres", DEPTH = 2},

	{ID = 37079, NAME = "Riverbeast Training: The Garn", DEPTH = 1},
	{ID = 37078, NAME = "Riverbeast Training: Orc Hunters", DEPTH = 2},
	{ID = 37077, NAME = "Riverbeast Training: Ironbore", DEPTH = 2},
	{ID = 37076, NAME = "Riverbeast Training: Thundercall", DEPTH = 2},
	{ID = 37075, NAME = "Riverbeast Training: Moth of Wrath", DEPTH = 2},
	{ID = 37074, NAME = "Riverbeast Training: Darkwing Roc", DEPTH = 2},
	{ID = 37073, NAME = "Riverbeast Training: Cruel Ogres", DEPTH = 2},
	{ID = 37072, NAME = "Riverbeast Training: Bulbapore", DEPTH = 2},
	{ID = 37071, NAME = "Riverbeast Training: Gezz'ran", DEPTH = 2},
	
	{ID = 37041, NAME = "Boar Training: The Garn", DEPTH = 1},
	{ID = 37040, NAME = "Boar Training: Orc Hunters", DEPTH = 2},
	{ID = 37039, NAME = "Boar Training: Ironbore", DEPTH = 2},
	{ID = 37038, NAME = "Boar Training: Thundercall", DEPTH = 2},
	{ID = 37037, NAME = "Boar Training: Moth of Wrath", DEPTH = 2},
	{ID = 37036, NAME = "Boar Training: Darkwing Roc", DEPTH = 2},
	{ID = 37035, NAME = "Boar Training: Cruel Ogres", DEPTH = 2},
	{ID = 37034, NAME = "Boar Training: Bulbapore", DEPTH = 2},
	{ID = 37033, NAME = "Boar Training: Gezz'ran", DEPTH = 2},
	{ID = 37032, NAME = "Boar Training: Riplash", DEPTH = 2},

	{ID = 37104, NAME = "Talbuk Training: The Garn", DEPTH = 1},
	{ID = 37103, NAME = "Talbuk Training: Orc Hunters", DEPTH = 2},
	{ID = 37102, NAME = "Talbuk Training: Ironbore", DEPTH = 2},
	{ID = 37101, NAME = "Talbuk Training: Thundercall", DEPTH = 2},
	{ID = 37100, NAME = "Talbuk Training: Moth of Wrath", DEPTH = 2},
	{ID = 37099, NAME = "Talbuk Training: Darkwing Roc", DEPTH = 2},
	{ID = 37098, NAME = "Talbuk Training: Cruel Ogres", DEPTH = 2},
	{ID = 37097, NAME = "Talbuk Training: Bulbapore", DEPTH = 2},
	{ID = 37096, NAME = "Talbuk Training: Gezz'ran", DEPTH = 2},
	{ID = 37095, NAME = "Talbuk Training: Riplash", DEPTH = 2},
	{ID = 37094, NAME = "Talbuk Training: Rakkiri", DEPTH = 2},
	
	{ID = 37059, NAME = "Clefthoof Training: The Garn", DEPTH = 1},
	{ID = 37058, NAME = "Clefthoof Training: Orc Hunters", DEPTH = 2},
	{ID = 37057, NAME = "Clefthoof Training: Ironbore", DEPTH = 2},
	{ID = 37056, NAME = "Clefthoof Training: Thundercall", DEPTH = 2},
	{ID = 37055, NAME = "Clefthoof Training: Moth of Wrath", DEPTH = 2},
	{ID = 37054, NAME = "Clefthoof Training: Darkwing Roc", DEPTH = 2},
	{ID = 37053, NAME = "Clefthoof Training: Cruel Ogres", DEPTH = 2},
	{ID = 37052, NAME = "Clefthoof Training: Bulbapore", DEPTH = 2},
	{ID = 37051, NAME = "Clefthoof Training: Gezz'ran", DEPTH = 2},
	{ID = 37050, NAME = "Clefthoof Training: Riplash", DEPTH = 2},
	{ID = 37049, NAME = "Clefthoof Training: Rakkiri", DEPTH = 2},
	{ID = 37048, NAME = "Clefthoof Training: Great-Tusk", DEPTH = 2}
}



--Zone Specific Fishing constants
local GU_FISH_RECOMMEND = {};
local GU_FISH_BAIT_BUFF = {};
local GU_FISH_BAIT_ID = {};
local GU_FISH_ACH_ID = {};
local GU_FISH_ACH_NAME = {};

GU_FISH_RECOMMEND[GU_ZONE_TALADOR] = "Blackwater Whiptail";
GU_FISH_BAIT_BUFF[GU_ZONE_TALADOR] = "Blackwater Whiptail Bait";
GU_FISH_BAIT_ID[GU_ZONE_TALADOR] = 110294;
GU_FISH_ACH_ID[GU_ZONE_TALADOR] = 9457;
GU_FISH_ACH_NAME[GU_ZONE_TALADOR] = "Blackwater Whiptail Angler";

GU_FISH_RECOMMEND[GU_ZONE_SHADOWMOON] = "Blind Lake Sturgeon";
GU_FISH_BAIT_BUFF[GU_ZONE_SHADOWMOON] = "Blind Lake Sturgeon Bait";
GU_FISH_BAIT_ID[GU_ZONE_SHADOWMOON] = 110290;
GU_FISH_ACH_ID[GU_ZONE_SHADOWMOON] = 9458;
GU_FISH_ACH_NAME[GU_ZONE_SHADOWMOON] = "Blind Lake Sturgeon Angler";

GU_FISH_RECOMMEND[GU_ZONE_NAGRAND] = "Fat Sleepers";
GU_FISH_BAIT_BUFF[GU_ZONE_NAGRAND] = "Fat Sleeper Bait";
GU_FISH_BAIT_ID[GU_ZONE_NAGRAND] = 110289;
GU_FISH_ACH_ID[GU_ZONE_NAGRAND] = 9459;
GU_FISH_ACH_NAME[GU_ZONE_NAGRAND] = "Fat Sleeper Angler";

GU_FISH_RECOMMEND[GU_ZONE_ARAK] = "Abyssal Gulper Eel";
GU_FISH_BAIT_BUFF[GU_ZONE_ARAK] = "Abyssal Gulper Eel Bait";
GU_FISH_BAIT_ID[GU_ZONE_ARAK] = 110293;
GU_FISH_ACH_ID[GU_ZONE_ARAK] = 9456;
GU_FISH_ACH_NAME[GU_ZONE_ARAK] = "Abyssal Gulper Angler";

GU_FISH_RECOMMEND[GU_ZONE_GORGOND] = "Jawless Skulker";
GU_FISH_BAIT_BUFF[GU_ZONE_GORGOND] = "Jawless Skulker Bait";
GU_FISH_BAIT_ID[GU_ZONE_GORGOND] = 110274;
GU_FISH_ACH_ID[GU_ZONE_GORGOND] = 9460;
GU_FISH_ACH_NAME[GU_ZONE_GORGOND] = "Jawless Skulker Angler";

GU_FISH_RECOMMEND[GU_ZONE_FROSTFIRE] = "Fire Ammonite";
GU_FISH_BAIT_BUFF[GU_ZONE_FROSTFIRE] = "Fire Ammonite Bait";
GU_FISH_BAIT_ID[GU_ZONE_FROSTFIRE] = 110291;
GU_FISH_ACH_ID[GU_ZONE_FROSTFIRE] = 9455;
GU_FISH_ACH_NAME[GU_ZONE_FROSTFIRE] = "Fire Ammonite Angler";

GU_FISH_RECOMMEND[GU_ZONE_DRAENOR_OCEAN] = "Sea Scorpion";
GU_FISH_BAIT_BUFF[GU_ZONE_DRAENOR_OCEAN] = "Sea Scorpion Bait";
GU_FISH_BAIT_ID[GU_ZONE_DRAENOR_OCEAN] = 110292;
GU_FISH_ACH_ID[GU_ZONE_DRAENOR_OCEAN] = 9461;
GU_FISH_ACH_NAME[GU_ZONE_DRAENOR_OCEAN] = "Sea Scorpion Angler";

GU_FISH_RECOMMEND[GU_ZONE_GARRISON] = "anything, as long as you have a proper bait";
GU_FISH_BAIT_BUFF[GU_ZONE_GARRISON] = "Any Bait";
GU_FISH_BAIT_ID[GU_ZONE_GARRISON] = 0;
GU_FISH_ACH_ID[GU_ZONE_GARRISON] = 9462;
GU_FISH_ACH_NAME[GU_ZONE_GARRISON] = "Draenor Angler";


-- Variables
local guHookWasActive = false;
local guBaitWasActive = false;
local guBobberWasActive = false;
local guCurrentZone = "";


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

function GarryUp_OnMiniFrameLoad()
	MiniFrameGarryUpButton.icon:SetTexture(GU_TEXTURE_ID_GARRYUP);
	MiniFrameGarryUpButton.icon:SetPoint("TOPLEFT", 0, 0);
end

function GarryUp_OnEvent(self, event, ...)
	if GU_DEBUG then
		GarryUp_Print("Event:"..event);
	end
	
	if event == GU_EVENT_LOOT then
		GarryUp_RefreshAngler();
	elseif event == GU_EVENT_BUFF_CHANGED then
		--Check for bait/hook for current zone
		
		if GU_DEBUG then
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
		
		if GarryUp_CheckBuff(GU_FISH_BAIT_BUFF[guCurrentZone]) then
			-- we got bait
			guBaitWasActive = true;
		elseif guBaitWasActive then
			-- we lost bait
			PlaySound(GU_SOUND_QUEST_LOG_ABANDON_QUEST);
			guBaitWasActive = false;
			GarryUp_Print("You need to reapply "..GU_FISH_BAIT_BUFF[guCurrentZone].."!", GU_COLOR_RED);
		else
			-- bait is off
		end
	elseif event == GU_EVENT_ZONE_CHANGED then
		--Zone changed check for specific zone baits and fish to catch
		guCurrentZone = GetZoneText();
		
		if GU_DEBUG then
			GarryUp_Print("New zone: "..guCurrentZone);
		end
		
		--check if we're in a zone first (otherwise it crashes when stoning)
		if GarryUp_IsInDraenor() and guCurrentZone ~= GU_ZONE_GARRISON then
			if GU_DEBUG then
				GarryUp_Print("Draenor!");
			end
			
			GarryUp_Print("We recommend you fish for "..GU_COLOR_GREEN..GU_FISH_RECOMMEND[guCurrentZone]..GU_COLOR_END.."!");
			GarryUpAnglerFrameBaitButton:Show();
			GarryUp_InitItemButton(GarryUpAnglerFrameBaitButton, GU_FISH_BAIT_ID[guCurrentZone]);
		else
			if GU_DEBUG then
				GarryUp_Print("Not in Draenor...");
			end
			-- We're not in Draenor anymore!
			GarryUpAnglerFrameBaitButton:Hide();
		end
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
	end

	-- Update Draenor data on any event
	GarryUp_RefreshDraenor();
		
end

function GarryUp_OnButtonFishClick()
	GarryUp_ShowAngler();
end

function GarryUp_OnButtonMountClick()
	GarryUpMOMFrame:Show();
	GarryUpMOMFrameScrollText:SetText(GarryUp_GetMOMDataBulkText());
	
	-- local kids = { GarryUpMOMFrameScroll:GetChildren() };

	-- for _, child in ipairs(kids) do
		-- print(child:GetName());
	-- end
end

function GarryUp_OnButtonGarryUpClick()
	GarryUp_ShowMain();
end


function GarryUp_InitItemButton(buttonRef, itemID)
	local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID);
	
	if GU_DEBUG then
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

function GarryUp_IsInDraenor()
	local ret = false;
	local zone = GetZoneText();
	
	if zone then
		if zone == GU_ZONE_GARRISON or 
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
	
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_DRAENOR_OCEAN])..GU_FISH_ACH_NAME[GU_ZONE_DRAENOR_OCEAN]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_DRAENOR_OCEAN])..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_NAGRAND])..GU_FISH_ACH_NAME[GU_ZONE_NAGRAND]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_NAGRAND])..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_TALADOR])..GU_FISH_ACH_NAME[GU_ZONE_TALADOR]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_TALADOR])..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_FROSTFIRE])..GU_FISH_ACH_NAME[GU_ZONE_FROSTFIRE]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_FROSTFIRE])..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_GORGOND])..GU_FISH_ACH_NAME[GU_ZONE_GORGOND]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_GORGOND])..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_SHADOWMOON])..GU_FISH_ACH_NAME[GU_ZONE_SHADOWMOON]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_SHADOWMOON])..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_FISH_ACH_ID[GU_ZONE_ARAK])..GU_FISH_ACH_NAME[GU_ZONE_ARAK]..": "..GarryUp_GetAchData(GU_FISH_ACH_ID[GU_ZONE_ARAK])..GU_COLOR_END.."\r";
	
	return outText;
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
	if GarryUp_IsInDraenor() then
		GarryUpAnglerFrameBaitButton:Show();
		GarryUp_InitItemButton(GarryUpAnglerFrameBaitButton, GU_FISH_BAIT_ID[guCurrentZone]);
	else
		GarryUpAnglerFrameBaitButton:Hide();
	end
end

function GarryUp_GetDraenorDataBulkText()
	local outText = "";
	
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_ANGLER_ID)..GU_ACH_ANGLER_NAME.." "..GarryUp_GetAchData(GU_ACH_ANGLER_ID)..GU_COLOR_END.."\r";
	--outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MMOUNT_ID)..GU_ACH_MMOUNT_NAME.." "..GarryUp_GetAchData(GU_ACH_MMOUNT_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MMOUNT_ID)..GU_ACH_MMOUNT_NAME.." "..GarryUp_GetQuestLineData(GU_QST_MOM_A)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_RANKS_ID)..GU_ACH_RANKS_NAME.." "..GarryUp_GetAchData(GU_ACH_RANKS_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_PETB_ID)..GU_ACH_PETB_NAME.." "..GarryUp_GetAchData(GU_ACH_PETB_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MONEY_ID)..GU_ACH_MONEY_NAME.." "..GarryUp_GetAchDataGold(GU_ACH_MONEY_ID)..GU_COLOR_END.."\r";
	outText = outText..GarryUp_GetAchProgressColor(GU_ACH_MTH_ID)..GU_ACH_MTH_NAME.." "..GarryUp_GetAchDataGold(GU_ACH_MTH_ID)..GU_COLOR_END.."\r";

	return outText;
end

function GarryUp_GetMOMDataBulkText()
	local outText = "";
	
	local _, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(GU_ACH_MMOUNT_ID);
	
	outText = "|T" .. icon .. ":0|t " .. name.. "\n\n";
	
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
	
	GarryUp_Print(helpText);
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
		GU_DEBUG = not GU_DEBUG;
		GarryUp_Print("Debugging enabled: "..GarryUp_BoolToString(GU_DEBUG));
	else
		GarryUp_Print("Unknown Command '"..args.."'.");
		GarryUp_PrintHelp();
	end
end


