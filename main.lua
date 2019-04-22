-- Conway's Game Of Life remake

function love.load()
  
  math.randomseed(os.time())
  
  -- set the width of lines
  love.graphics.setLineWidth(0)
  
  WID = love.graphics.getWidth()
  HEI = love.graphics.getHeight()
  
  require("grid")
  
  -- create a new grid
  grid = create_cells()
  
end

function love.update(dt)
  
  -- automatically update the grid
  if auto then
    grid = updated_grid()
  end
  
end

function love.mousepressed(mx, my, btn)
  
  mx = math.ceil(mx/TILE)
  my = math.ceil(my/TILE)
  
  if btn == 1 then
    grid[my][mx] = not grid[my][mx]
  end
  
end

function love.keypressed(key)
  
  if key == "escape" then
    love.event.push("quit")
    
  elseif key == "space" then
    -- update grid once with "space"
    grid = updated_grid()
    
  elseif key == "r" then
    -- load random cells with "r"
    grid = random_cells()
    auto = false -- disable auto
    
  elseif key == "n" then
    -- create new empty grid with "n"
    grid = create_cells()
    auto = false -- disable auto
    
  elseif key == "tab" then
    -- switch on/off the auto update with "tab" key
    auto = not auto
    
  end
  
end

function love.draw()
  
  love.graphics.setBackgroundColor(background)
  draw_cells()
  draw_net()
  
end
