if getActivatedMods():contains("ItemTweakerAPI") then
	require("ItemTweaker_Core");
else return end

require("ExtraClothingOptions")

local ClothingOptions = {}

local extraClothingStr = "ClothingItemExtra";
local extraOptionStr = "ClothingItemExtraOption";

local function CheckIfOptionExists(itemName, extraOptionClothingItem, extraOptionName)
	if not TweakItemData[itemName] then
		TweakItemData[itemName] = {};

		ClothingOptions[itemName] = ExtraClothingOptions:New()

		-- Unsuccessfully tried to avoid overriding items fields
		--[[
		local item = ScriptManager.instance:getItem(itemName);
		local extraOptionClothing = item:getClothingItemExtra();
		local extraOptionNames = item:getClothingItemExtraOption();

		if ( extraOptionClothing ~= nil and extraOptionNames ~= nil ) then

			print("DEBUG DELRAN HERE");

			print(extraOptionClothing[0]);
			print(extraOptionNames[0]);

			local baseExtraOptionClothing = "";

			for i, clothingOption in ipairs(extraOptionClothing) do
			  print (clothingOption);
			  baseExtraOptionClothing = baseExtraOptionClothing .. clothingOption .. ";";
			end

			local baseExtraOptionNames = "";

			for i, clothingOptionName in ipairs(extraOptionNames) do
			  print (clothingOptionName);
			  baseExtraOptionNames = baseExtraOptionNames .. clothingOptionName .. ";";
			end

			print(baseExtraOptionClothing);
			print(baseExtraOptionNames);

			TweakItemData[itemName][extraClothingStr] = baseExtraOptionClothing:sub(1, -2);
			TweakItemData[itemName][extraOptionStr] = baseExtraOptionNames:sub(1, -2);

		end

		]]
	end

	local itemClothingOptions = ClothingOptions[itemName]

	-- Don't do anything is the given option name is already in the set
	if itemClothingOptions:Contains(extraOptionName) then
		return true;
	end

	itemClothingOptions:Add(extraOptionName, extraOptionClothingItem)

	return false
end

local function SetTweakedData(itemName)
	local ItemData = TweakItemData[itemName];

	local tweakDatas = ClothingOptions[itemName]:ConvertToTweakData()

	ItemData[extraOptionStr] = tweakDatas["optionNames"];
	ItemData[extraClothingStr] = tweakDatas["clothingItems"];
end

function ItemTweaker.AddClothingOptionIfDoesntExists(itemName, extraOptionClothingItem, extraOptionName)

	if not CheckIfOptionExists(itemName, extraOptionClothingItem, extraOptionName) then
		SetTweakedData(itemName)
	end
end

function ItemTweaker.AddOrReplaceClothingOption(itemName, extraOptionClothingItem, extraOptionName)

	local entryExists = CheckIfOptionExists(itemName, extraOptionClothingItem, extraOptionName)

	local itemClothingOptions = ClothingOptions[itemName]

	if entryExists then
		itemClothingOptions:Remove(extraOptionName)
		itemClothingOptions:Add(extraOptionName, extraOptionClothingItem)
	end
	SetTweakedData(itemName)
end

function ItemTweaker.RemoveClothingOption(itemName, extraOptionName)
	ClothingOptions[itemName]:Remove(extraOptionName)
	SetTweakedData(itemName)
end

-- Dev functions
function ItemTweaker.GetClothingOption(itemName)
	return ClothingOptions[itemName]
end

--[[

This function is taking advantage of the fact that the DoParam() function of Project's Zomboid Item
class (used by the ItemTweakerAPI) can take multiple parameters separated by a semicolon for the fields
ClothingItemExtra and ClothingItemExtraOption.

This function is usefull to avoid overriding other mods that adds extra clothing option.

!!! Note that this will still override the fields that were set inside of the item's script

Usage is simple, just call the function with the name of the item to modify, the name of the linked
item and the name of the option
e.g.

	local currentItem = "Base.Hoodie_Down";
	ItemTweaker.AddClothingOptionIfDoesntExists(currentItem, "Base.Hoodie_Up", "UpHoodie")
	ItemTweaker.AddClothingOptionIfDoesntExists(currentItem, "Base.Hoodie_Tied", "TieAroundWaist")
]]

--------------- TESTS ----------------
--[[

ItemTweaker.AddOrReplaceClothingOption("Delran.HoodieUp", "Delran.HoodieTied", "TieOnWaist")
ItemTweaker.AddOrReplaceClothingOption("Delran.HoodieUp", "Should replace previous", "HoodieDown")
ItemTweaker.AddOrReplaceClothingOption("Delran.HoodieUp", "Delran.HoodieTroussed", "TroussHoodie")
ItemTweaker.AddOrReplaceClothingOption("Delran.HoodieUp", "MUST NOT APPEAR", "ToBeRemoved")
ItemTweaker.RemoveClothingOption("Delran.HoodieUp", "ToBeRemoved")
ClothingOptions["Delran.HoodieUp"]:Print()

ItemTweaker.AddClothingOptionIfDoesntExists("Delran.HoodieUp", "Should appear", "HoodieDown")
ItemTweaker.AddClothingOptionIfDoesntExists("Delran.HoodieUp", "MUST NOT APPEAR", "HoodieDown")
ItemTweaker.AddClothingOptionIfDoesntExists("Delran.HoodieUp", "Delran.HoodieTroussed", "TroussHoodie")
ClothingOptions["Delran.HoodieUp"]:Print()

ItemTweaker.AddClothingOptionIfDoesntExists("Delran.HoodieUp", "Delran.HoodieTied", "TieOnWaist")
ItemTweaker.AddClothingOptionIfDoesntExists("Delran.HoodieTied", "Delran.HoodieUp", "UpHoodie")
ClothingOptions["Delran.HoodieUp"]:Print()
ClothingOptions["Delran.HoodieTied"]:Print()
onGameBootFunc[1]()
]]
--------------- TESTS ----------------
