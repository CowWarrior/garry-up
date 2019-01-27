local _, garryup = ...

-- *****************************************************************************
-- *
-- *                            GarryUp! Data
-- *
-- * Created by: CowWarrior
-- * Created on: 2019-01-19
-- * Updated on: 2019-01-26
-- * 
-- * Tested on : WOW 8.1
-- *
-- * This module holds the data and constants for the add-on.
-- *
-- *****************************************************************************

--TODO: Need to reduce the number of global variables.

--Global for GarryUp data
GarryUpData = {
	-- Color Constants
	COLOR_ADDON = "|cffff007f",
	COLOR_END = "|r",
	COLOR_RED = "|cffff0000",
	COLOR_YELLOW = "|cffffd100",
	COLOR_GREEN = "|cff00ff00",
	COLOR_BLUE = "|cff0000ff",
	COLOR_WHITE = "|cffffffff",
	COLOR_BLACK = "|cff000000",
	COLOR_GRAY = "|cff707070",
	COLOR_PROGRESS_0 = "|cff7d7d7d", --grey
	COLOR_PROGRESS_25 = "|cff7d7d00", --dark yellow
	COLOR_PROGRESS_50 = "|cffffd100", --brighter yellow
	COLOR_PROGRESS_75 = "|cffffffff", --white
	COLOR_PROGRESS_100 = "|cff00ff00", --green

	-- Chat Icons
	TXTICO_CHECK = "|T130653:0:2|t", --Interface\AchievementFrame\UI-Achievement-Criteria-Check
	TXTICO_END = ":0|t",
	TXTICO_START = "|T",

	-- Event Constants
	EVENT_LOGIN = "PLAYER_LOGIN",
	EVENT_LOOT = "CHAT_MSG_LOOT",
	EVENT_BUFF_CHANGED = "UNIT_AURA",
	EVENT_ZONE_CHANGED = "ZONE_CHANGED_NEW_AREA",
	EVENT_ACHIEVEMENT = "ACHIEVEMENT_EARNED",
	EVENT_MINIZONE_CHANGED = "ZONE_CHANGED",
	EVENT_QUEST_COMPLETE = "QUEST_TURNED_IN",
	EVENT_BAG_UPDATE = "BAG_UPDATE",
	EVENT_ADDON_LOADED = "ADDON_LOADED",
	EVENT_COMBAT_INITIATED = "PLAYER_REGEN_DISABLED", --Indirect but most reliable
	EVENT_COMBAT_ENDED = "PLAYER_REGEN_ENABLED",

	-- Buff Constants
	BUFF_HOOK = "Bladebone Hook",
	BUFF_BOBBER = "Oversized Bobber",
	BUFF_SKULKER = "Jawless Skulker Bait",

	-- Zone Constants
	ZONE_GARRISON = "Lunarfall",
	ZONE_SHADOWMOON = "Shadowmoon Valley",
	ZONE_TALADOR = "Talador",
	ZONE_NAGRAND = "Nagrand",
	ZONE_ARAK = "Spires of Arak",
	ZONE_GORGOND = "Gorgrond",
	ZONE_FROSTFIRE = "Frostfire Ridge",
	ZONE_DRAENOR_OCEAN = "Draenor Ocean", --Not sure yet how I will handle this
	MINIZONE_GARRISON_MINE = "Lunarfall Excavation",
	MINIZONE_SOUTH_SEA = "The South Sea",

	-- Item Constants
	ITEM_OVERSIZED_BOBBER = 136377,
	ITEM_BLADEBONE_HOOK = 122742,
	ITEM_MINER_COFFEE = 118897,
	ITEM_PRESERVED_PICK = 118903,

	-- Texture constants
	TEXTURE_ID_FISHING = 136245,
	TEXTURE_ID_MOUNT = 975744, --631718;
	TEXTURE_ID_GARRYUP = 1005027,

	-- Sound Constants
	SOUND_QUEST_LOG_ABANDON_QUEST = 846
}

GarryUpData["BuildingsLv3"] = {
	{AchId=9462, AchType="AchLine"},
	{AchId=9487, AchType="Gold"},
	{AchId=9526, AchType="QuestLine"},
	{AchId=9129},
	{AchId=9463},
	{AchId=9477, FactionGroup="Horde"},
	{AchId=9478, FactionGroup="Alliance"},
	{AchId=10348},
	{AchId=9468},
	{AchId=9406},
	{AchId=9565},
	{AchId=9495},
	{AchId=9523},
	{AchId=9497},
	{AchId=9527},
	{AchId=9454},
	{AchId=9453},
	{AchId=9429},
	{AchId=9703}
}

-- QuestLines
GarryUpData["QST_MOM"] = {AchId=9526};
GarryUpData.QST_MOM["Alliance"] = {
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

GarryUpData.QST_MOM["Horde"] = {
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



--Fishing constants (Draenor Angler)
GarryUpData["Angler"] = {
	{AchId = 9462, BaitId = 0, FishName = "anything, as long as you have a proper bait", Zone = GarryUpData.ZONE_GARRISON, Skip = true},
	{AchId = 9455, BaitId = 110291, FishName = "Fire Ammonite", Zone = GarryUpData.ZONE_FROSTFIRE},
	{AchId = 9456, BaitId = 110293, FishName = "Abyssal Gulper Eel", Zone = GarryUpData.ZONE_ARAK},
	{AchId = 9457, BaitId = 110294, FishName = "Blackwater Whiptail", Zone = GarryUpData.ZONE_TALADOR},
	{AchId = 9458, BaitId = 110290, FishName = "Blind Lake Sturgeon", Zone = GarryUpData.ZONE_SHADOWMOON},
	{AchId = 9459, BaitId = 110289, FishName = "Fat Sleepers", Zone = GarryUpData.ZONE_NAGRAND},
	{AchId = 9460, BaitId = 110274, FishName = "Jawless Skulker", Zone = GarryUpData.ZONE_GORGOND},
	{AchId = 9461, BaitId = 110292, FishName = "Sea Scorpion", Zone = GarryUpData.ZONE_DRAENOR_OCEAN}
}

