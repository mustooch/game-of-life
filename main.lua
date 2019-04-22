-- Conway's Game Of Life remake

function love.load()
  
  math.randomseed(os.time())
  
  -- set the width of lines
  love.graphics.setLineWidth(0)
  
  WID = love.graphics.getWidth()
  HEI = love.graphics.getHeight()
  
  require("board")
  
  -- create a new board
  board = create_cells()
  
end

function love.update(dt)
  
  -- automatically update the board
  if auto then
    board = updated_board()
  end
  
end

function love.mousepressed(mx, my, btn)
  
  mx = math.ceil(mx/TILE)
  my = math.ceil(my/TILE)
  
  if btn == 1 then
    board[my][mx] = not board[my][mx]
  end
  
end

function love.keypressed(key)
  
  if key == "escape" then
    love.event.push("quit")
    
  elseif key == "space" then
    -- update board once with "space"
    board = updated_board()
    -- set random cell color for a cool effect
    CELL_COLOR = {math.random(), math.random(), math.random()}
    
  elseif key == "r" then
    -- create a new board with "r"
    board = create_cells()
    auto = false -- disable auto
    
  elseif key == "tab" then
    -- switch on/off the auto update with "tab" key
    auto = not auto
    
  end
  
end

function love.draw()
  
  love.graphics.setBackgroundColor(0.5, 1, 1)
  draw_net()
  draw_cells()
  
end
