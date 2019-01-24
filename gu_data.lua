-- *****************************************************************************
-- *
-- *                            GarryUp! Data
-- *
-- * Created by: CowWarrior
-- * Created on: 2019-01-19
-- * Updated on: 2019-01-19
-- * 
-- * Tested on : WOW 8.1
-- *
-- *****************************************************************************

--TODO: Need to reduce the number of global variables.

-- Color Constants
GU_COLOR_ADDON = "|cffff007f";
GU_COLOR_END = "|r";
GU_COLOR_RED = "|cffff0000";
GU_COLOR_GREEN = "|cff00ff00";
GU_COLOR_BLUE = "|cff0000ff";
GU_COLOR_WHITE = "|cffffffff";
GU_COLOR_BLACK = "|cff000000";
GU_COLOR_PROGRESS_0 = "|cff7d7d7d"; --grey
GU_COLOR_PROGRESS_25 = "|cff7d7d00"; --dark yellow
GU_COLOR_PROGRESS_50 = "|cffffd100"; --brighter yellow
GU_COLOR_PROGRESS_75 = "|cffffffff"; --white
GU_COLOR_PROGRESS_100 = GU_COLOR_GREEN; --green

-- Chat Icons
GU_TXTICO_CHECK = "|T130653:0:2|t"; --Interface\AchievementFrame\UI-Achievement-Criteria-Check
GU_TXTICO_END = ":0|t";
GU_TXTICO_START = "|T";

-- Event Constants
GU_EVENT_LOGIN = "PLAYER_LOGIN";
GU_EVENT_LOOT = "CHAT_MSG_LOOT";
GU_EVENT_BUFF_CHANGED = "UNIT_AURA";
GU_EVENT_ZONE_CHANGED = "ZONE_CHANGED_NEW_AREA";
GU_EVENT_ACHIEVEMENT = "ACHIEVEMENT_EARNED"
GU_EVENT_MINIZONE_CHANGED = "ZONE_CHANGED";
GU_EVENT_QUEST_COMPLETE = "QUEST_TURNED_IN";
GU_EVENT_BAG_UPDATE = "BAG_UPDATE";

-- Buff Constants
GU_BUFF_HOOK = "Bladebone Hook";
GU_BUFF_BOBBER = "Oversized Bobber";
GU_BUFF_SKULKER = "Jawless Skulker Bait";

-- Zone Constants
GU_ZONE_GARRISON = "Lunarfall";
GU_ZONE_SHADOWMOON = "Shadowmoon Valley";
GU_ZONE_TALADOR = "Talador";
GU_ZONE_NAGRAND = "Nagrand";
GU_ZONE_ARAK = "Spires of Arak";
GU_ZONE_GORGOND = "Gorgrond";
GU_ZONE_FROSTFIRE = "Frostfire Ridge";
GU_ZONE_DRAENOR_OCEAN = "Draenor Ocean"; --Not sure yet how I will handle this
GU_MINIZONE_GARRISON_MINE = "Lunarfall Excavation";
GU_MINIZONE_SOUTH_SEA = "The South Sea";

-- Item Constants
GU_ITEM_OVERSIZED_BOBBER = 136377;
GU_ITEM_BLADEBONE_HOOK = 122742;

-- Texture constants
GU_TEXTURE_ID_FISHING = 136245;
GU_TEXTURE_ID_MOUNT = 975744; --631718;
GU_TEXTURE_ID_GARRYUP = 1005027;

-- Sound Constants
GU_SOUND_QUEST_LOG_ABANDON_QUEST = 846;

-- Achievements constants
GU_ACH_ANGLER_ID = 9462;
GU_ACH_ANGLER_NAME = "Draenor Angler";
GU_ACH_MONEY_ID = 9487;
GU_ACH_MONEY_NAME = "Draenor Money"; --Got My Mind On My Draenor Money
GU_ACH_MMOUNT_ID = 9526;
GU_ACH_MMOUNT_NAME = "Master of Mounts"; -- Intro to Husbandry is the pre-requisite acheivement
GU_ACH_RANKS_ID = 9129;
GU_ACH_RANKS_NAME = "Filling the Ranks";
GU_ACH_PETB_ID = 9463;
GU_ACH_PETB_NAME = "Draenic Pet Battler";
GU_ACH_SAVAGEH_ID = 9477;
GU_ACH_SAVAGEH_NAME = "Savage Friends (horde)";
GU_ACH_SAVAGEA_ID = 9478;
GU_ACH_SAVAGEA_NAME = "Savage Friends (alliance)";
GU_ACH_MTH_ID = 10348; --9726  --10348;
GU_ACH_MTH_NAME = "Master Treasure Hunter";

GU_ACH_SALVAGING_ID = 9468;
GU_ACH_SALVAGING_NAME = "Salvaging Pays Off";
GU_ACH_TRAPPER_ID = 9565;
GU_ACH_TRAPPER_NAME = "Master Trapper";


-- QuestLines

--TODO: Convert into generic variable (constant) name and have Horde/Alliance specific data loaded into it OnLoad
--      if UnitFactionGroup("player") == "Alliance" then
GU_QST_MOM_A = {}
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

GU_QST_MOM_H = {}
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
GU_FISH_RECOMMEND = {};
GU_FISH_BAIT_BUFF = {};
GU_FISH_BAIT_ID = {};
GU_FISH_ACH_ID = {};
GU_FISH_ACH_NAME = {};

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

