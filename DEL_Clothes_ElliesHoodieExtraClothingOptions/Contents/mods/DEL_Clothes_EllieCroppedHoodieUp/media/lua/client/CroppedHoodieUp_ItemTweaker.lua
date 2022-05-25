
if getActivatedMods():contains("ItemTweakerAPIExtraClothingAddon") then 
	require("ItemTweaker_ExtraClothingOptions");
else return end

local currentItem = "ElliesClothingShop.Hoodie_CroppedDown";	
local upHoodie = "DelranElliesCroppedHoodieUp.Hoodie_CroppedUp";	

ItemTweaker.AddOrReplaceClothingOption(currentItem, upHoodie, "UpHoodie");
ItemTweaker.AddOrReplaceClothingOption(upHoodie, currentItem, "DownHoodie");

TweakItem(currentItem, "clothingExtraSubmenu", "DownHoodie")
TweakItem(upHoodie, "clothingExtraSubmenu", "UpHoodie")