require("luaModsPath")

----------------------------------------------------------
--         Mocking the getActiveMods function           --
----------------------------------------------------------
local ActiveMods_Mock = {}

-- Mocked active mod container
function ActiveMods_Mock:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function ActiveMods_Mock:contains(_)
   return true
end

function getActivatedMods()
  return ActiveMods_Mock:new(nil)
end

----------------------------------------------------------
--               Mocking the Item Class                 --
----------------------------------------------------------
local Item_mock = {}

-- Mocked script manager instance
function Item_mock:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Item_mock:DoParam(_)
  return
end


----------------------------------------------------------
--             Mocking the Script Manager               --
----------------------------------------------------------
ScriptManager = {}

local ScriptManager_Mock = {}

-- Mocked script manager instance
function ScriptManager_Mock:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function ScriptManager_Mock:getItem(k)
  return Item_mock:new(nil)
end

ScriptManager.instance = ScriptManager_Mock:new(nil)



----------------------------------------------------------
--            Mocking the onGameBoot Event              --
----------------------------------------------------------

Events = {}

Events.OnGameBoot = {}

Events.OnGameBoot.MockedFunctions = {}

function Events.OnGameBoot.Add(func)
  table.insert(Events.OnGameBoot.MockedFunctions, func)
end
