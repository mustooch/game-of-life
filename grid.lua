-- grid stuff:

TILE = 6 -- fixed cell width,height
auto = false -- for auto cell updates
ADD = 25 -- add this value everywhere to 
--          make it look like the board is infinite
--          or cells would block on the edges

function random_color()
  -- returns random RGB color
  rand = {math.random(), math.random(), math.random()}
  return rand
end

background = {000/255, 153/255, 255/255}
CELL_COLOR = {255/255, 255/255, 102/255}

function create_cells()
  -- create the grid with fixed w,h 
  
  local cells = {}
  for y = -ADD, HEI/TILE+ADD do
    cells[y] = {}
    for x = -ADD, WID/TILE+ADD do
      cells[y][x] = false -- init with false (dead cell)
    end
  end 
  
  return cells
  
end

function random_cells()
  -- create the grid with fixed w,h 
  
  local cells = {}
  for y = -ADD, HEI/TILE+ADD do
    cells[y] = {}
    for x = -ADD, WID/TILE+ADD do
      -- load cells randomly
      cells[y][x] = (math.random(1,2)==1 and true or false)
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
  
  -- set drawing color to the cell color
  love.graphics.setColor(CELL_COLOR)
  
  for y = 1, HEI/TILE do
    for x = 1, WID/TILE do
      if grid[y][x] then -- if a cell is alive
        love.graphics.rectangle("fill", (x-1)*TILE,
          (y-1)*TILE, TILE, TILE)
      end
    end
  end
  
  -- reset drawing color
  love.graphics.setColor(1, 1, 1)
  
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
    if x_i>=-ADD and y_i>=-ADD
    and x_i <= WID/TILE+ADD
    and y_i <= HEI/TILE+ADD then
      
      if grid[y_i][x_i] then
        count = count + 1 -- count living cell
      end
      
    end
    
  end
  
  return count
  
end

function updated_grid()
  -- create and kill new cells
  
  new = {}
  
  for y = -ADD, HEI/TILE+ADD do
    new[y] = {}
    for x = -ADD, HEI/TILE+ADD do
      
      --[[
      . if a cell has 2 or 3 neighbours it lives
      . else if it has fewer than 2 or more than 3 neighbours it dies
      --]]
      
      if neighbours(x, y) == 3 then
        new[y][x] = true
        
      elseif neighbours(x, y) == 2 and grid[y][x] == true then
        new[y][x] = true
        
      else
        new[y][x] = false
      end
      
    end
  end
  
  -- return the new grid
  return new
  
end
