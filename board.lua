-- board stuff:

TILE = 12 -- fixed cell width,height
TILE_COLOR = {0, 0, 0} -- cell color
auto = false -- for auto cell updates

function create_cells()
  -- create the board with fixed w,h 
  
  local cells = {}
  for y = 1, HEI/TILE do
    cells[y] = {}
    for x = 1, WID/TILE do
      cells[y][x] = false
      -- init with false (dead cell)
    end
  end
  
  return cells
  
end

function draw_net()
  -- draw the net to the screen
  
  for i = 1, WID, TILE do
    -- horizontal lines
    love.graphics.line(i,0, i,WID)
  end
  for j = 1, HEI, TILE do
    -- vertical lines
    love.graphics.line(0,j, HEI,j)
  end
  
end

function draw_cells()
  -- draw the cells to the screen
  
  for y = 1, HEI/TILE do
    for x = 1, WID/TILE do
      if board[y][x] then -- if a cell is alive
        love.graphics.rectangle("fill", (x-1)*TILE,
          (y-1)*TILE, TILE, TILE)
      end
    end
  end
  
end

function neighbours(x, y)
  
  count = 0
  
  positions = {
    {-1,-1}, {0,-1}, {1,-1},
    {-1, 0},         {1, 0},
    {-1, 1}, {0, 1}, {1, 1}
  }
  
  -- check for neighbours
  for i, pos in ipairs(positions) do
    x_i = x+pos[1]
    y_i = y+pos[2]
    
    -- if not on an edge
    if x_i>=1 and y_i>=1
    and x_i <= WID/TILE
    and y_i <= HEI/TILE then
      if board[y_i][x_i] then
        count = count + 1
      end
    end
    
  end
  
  return count
  
end

function updated_board()
  -- create and kill new cells
  
  new = {}
  
  for y = 1, HEI/TILE do
    new[y] = {}
    for x = 1, HEI/TILE do
      
      --[[
      . if a cell has 2 or 3 neighbours it lives
      . else if it has fewer than 2 or more than 3 neighbours it dies
      --]]
      
      if neighbours(x, y) == 3 then
        new[y][x] = true
        
      elseif neighbours(x, y) == 2 and board[y][x] == true then
        new[y][x] = true
        
      else
        new[y][x] = false
      end
      
    end
  end
  
  -- return the new board
  return new
  
end
