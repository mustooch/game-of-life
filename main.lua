-- Conway's Game Of Life remake

require("board")

-- love stuff:

WID = love.graphics.getWidth()
HEI = love.graphics.getHeight()

board = create_cells()

function love.load()
  
  love.graphics.setLineWidth(0)
  
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
    board = updated_board()
    
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
