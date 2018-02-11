-- aabb collision detection
-- by harrewarre

function _init()
 cls()
	
 collision="none"

 box_x=10
 box_y=10
 box_w=15
 box_h=15
 
 obst_x=40
 obst_y=40
 obst_w=55
 obst_h=25
end

function _update()
 box_control()
 
 collision="none"
 
 if box_check_collision(obst_x,obst_y,obst_w,obst_h) then
  if box_collides_left(obst_x,obst_y,obst_w,obst_h) then
   collision="from left"
   box_x=pbox_x
  end
  
  if box_collides_right(obst_x,obst_y,obst_w,obst_h) then
   collision="from right"
   box_x=pbox_x   
  end
  
  if box_collides_top(obst_x,obst_y,obst_w,obst_h) then
   collision="from top"
   box_y=pbox_y
  end
  
  if box_collides_bottom(obst_x,obst_y,obst_w,obst_h) then
   collision="from bottom"
   box_y=pbox_y
  end
 end
end

function _draw()
 cls()
 print(collision,2,2,11)
 rectfill(box_x,box_y,box_x+box_w,box_y+box_h,11)
 rectfill(obst_x,obst_y,obst_x+obst_w,obst_y+obst_h,8)
end

-- rudimentary control of box
function box_control()
 update_previous_coords()
	
 if btn(0) then
  box_x-=1
 end
 
 if btn(1) then
  box_x+=1
 end
 
 if btn(2) then
  box_y-=1
 end
 
 if btn(3) then
  box_y+=1
 end
end

-- basic collision detection

-- holds previous frame x/y of our box.
pbox_x=box_x
pbox_y=box_y

function update_previous_coords(x,y)
 pbox_x=box_x
 pbox_y=box_y 
end

function box_check_collision(tx,ty,tw,th)
 if box_x > tx+tw then return false end
 if box_x+box_w < tx then return false end
 if box_y > ty+th then return false end
 if box_y+box_h < ty then return false end
 return true
end

function box_collides_left(tx,ty,tw,th)
 return (pbox_x+box_w) < tx and (box_x+box_w) >= tx 
end

function box_collides_right(tx,ty,tw,th)
 return pbox_x > (tx+tw) and box_x <= (tx+tw)
end

function box_collides_top(tx,ty,tw,th)
 return (pbox_y+box_h) < ty and (box_y+box_h) >= ty
end

function box_collides_bottom(tx,ty,tw,th)
 return pbox_y > (ty+th) and box_y <= (ty+th)
end