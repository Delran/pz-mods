require("Mock")
require("ItemTweaker_ExtraClothingOptions")

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
-- Temprorary test file until a proper testing environement is set

Tests = {}

Tests.TestClothingOptionsAddedWithItemTweakerBeforeUsingTheAddonStillAppear = function()
  local targetItem = "Delran.HoodieUp"

  -- Test clothing options added using original API still appear when using the addon
  print("---------- CLOTHING OPTION ADDED WITH ITEM TWEAKER BEFORE USING THE ADDON ARE KEPT ------------\n")


  TweakItem(targetItem, "ClothingItemExtra", "MUSTAPPEAR");
  TweakItem(targetItem, "ClothingItemExtraOption", "MUSTAPPEAR");

  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTied", "TieOnWaist")
  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTied", "KILL")

  local test = ItemTweaker.GetClothingOption(targetItem)


  Events.OnGameBoot.MockedFunctions[1]()

  if test:Contains("MUSTAPPEAR") then
    print("\n ---> SUCCESS")
    print("-----------------------------------------------------------------------------------------------")
  end
end

Tests.TestAddOrReplaceClothingOptions = function()
  local targetItem = "Delran.HoodieUp"

  -- Test clothing options added using original API still appear when using the addon
  print("-------------------- CLOTHING OPTION ARE ADDED AND REPLACED AS THEY SHOULD ---------------------\n")

  ItemTweaker.AddOrReplaceClothingOption(targetItem, "MUST NOT APPEAR", "HoodieDown")
  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTied", "TieOnWaist")
  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Should replace previous", "HoodieDown")
  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTroussed", "TroussHoodie")

  Events.OnGameBoot.MockedFunctions[1]()

  local success = TweakItemData[targetItem]["ClothingItemExtraOption"] == "TieOnWaist;HoodieDown;TroussHoodie"

  if success then
    print("\n---> SUCCESS")
    print("-----------------------------------------------------------------------------------------------")
  end
end

Tests.TestOptionAddedWithOldTweakerAPIBetweenCallsShouldStillAppear = function()
  local targetItem = "Delran.HoodieUp"

  print("---- CLOTHING OPTION THAT ARE ADDED WITH THE OLD API BETWEEN CALLS SHOULD BE ADDED -----------\n")

  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTied", "TieOnWaist")

  TweakItem(targetItem, "ClothingItemExtraOption", "MUST NOT BE OVERRIDEN")
  TweakItem(targetItem, "ClothingItemExtra", "MUST NOT BE OVERRIDEN")

  ItemTweaker.AddOrReplaceClothingOption(targetItem, "Delran.HoodieTroussed", "TroussHoodie")

  Events.OnGameBoot.MockedFunctions[1]()

  local success = (TweakItemData[targetItem]["ClothingItemExtraOption"] ==
    "TieOnWaist;MUST NOT BE OVERRIDEN;TroussHoodie")

  if success then
    print("\n---> SUCCESS")
    print("-----------------------------------------------------------------------------------------------")
  end
end

-- Tests.TestClothingOptionsAddedWithItemTweakerBeforeUsingTheAddonStillAppear()
-- Tests.TestAddOrReplaceClothingOptions()
Tests.TestOptionAddedWithOldTweakerAPIBetweenCallsShouldStillAppear()

--------------- TESTS ----------------
--[[

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
