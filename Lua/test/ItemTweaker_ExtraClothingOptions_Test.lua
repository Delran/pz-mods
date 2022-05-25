require("Mock")
require("ItemTweaker_ExtraClothingOptions")


function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
-- Temprorary test file until a proper testing environement is set

local targetItem = "Delran.HoodieUp"

-- Test clothing options added using original API still appear when using the addon

TweakItem(targetItem, "ClothingItemExtra", "Delran.DeadHoodie");
TweakItem(targetItem, "ClothingItemExtraOption", "ThisOptionMustNotBeOverriden");

ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTied", "TieOnWaist")
ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTied", "KILL")

local test = ItemTweaker.GetClothingOption(targetItem)
print(test:Contains("KILL"))
print(tablelength(test.Options))

Events.OnGameBoot.MockedFunctions[1]()
--------------- TESTS ----------------
--[[

ItemTweaker.AddOrReplaceClothingOption("Delran.HoodieUp", "MUST NOT APPEAR", "HoodieDown")
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
