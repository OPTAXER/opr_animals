-- List of animal models to spawn
local animalModels = {
  "a_c_cow", -- cow
  "a_c_boar", -- wild boar
  "a_c_chimp", -- chimpanzee
  "a_c_pig", -- pig
}

-- Coordinates where animals will spawn
local spawnCoords = {
  {x = 1501.357, y = 1678.099, z = 111.58},
  {x = 200.0, y = -200.0, z = 20.0},
  {x = 300.0, y = -300.0, z = 20.0},
}

-- Spawn a random animal at each set of coordinates
Citizen.CreateThread(function()
  while true do
    for _, coords in ipairs(spawnCoords) do
      local model = animalModels[math.random(1, #animalModels)]
      RequestModel(model)
      while not HasModelLoaded(model) do
        Citizen.Wait(0)
      end
      local animal = CreatePed(28, model, coords.x, coords.y, coords.z, 0.0, true, false)
      SetPedRandomProps(animal)
      SetPedDefaultComponentVariation(animal)
      SetModelAsNoLongerNeeded(model)
    end
    Citizen.Wait(600000) -- wait 10 minutes before respawning animals
  end
end)
