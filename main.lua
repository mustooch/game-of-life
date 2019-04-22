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
    CELL_COLOR = random_color()
    background = {
      -- for complementary colors
      1-CELL_COLOR[1],
      1-CELL_COLOR[2],
      1-CELL_COLOR[3]
      }
    
  elseif key == "r" then
    -- load random cells with "r"
    board = random_cells()
    auto = false -- disable auto
    
  elseif key == "n" then
    -- create new empty board with "n"
    board = create_cells()
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
