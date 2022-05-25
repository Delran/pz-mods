require('Mock')

local activeMods = getActivatedMods()

if activeMods:contains("ItemTweakerAPIExtraClothingAddon") then
	require("ItemTweaker_ExtraClothingOptions");
else return end

local tiedHoodie = "DelranElliesCroppedHoodieTied.Hoodie_CroppedTied";
local currentItem = "ElliesClothingShop.Hoodie_CroppedDown";

ItemTweaker.AddOrReplaceClothingOption(currentItem, tiedHoodie, "TieOnWaist");
ItemTweaker.AddOrReplaceClothingOption(tiedHoodie, currentItem, "DownHoodie");

TweakItem(tiedHoodie, "clothingExtraSubmenu", "UpHoodie")
