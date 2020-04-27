-- globals
t=0
friction=0.75
max_speed=1

player={
 acc=0.5,
 x=16,
 y=16,
 dx=0,
 dy=0,
 frames={1,2,3,4},
 frame=1,
 flp=true,
 
 draw=function(self)
 	if self.dx != 0 or self.dy !=  0 then
			if t%6==0 then
			 self.frame=self.frame%#self.frames+1
 	 end
	 else
	  self.frame=1
	 end
	 spr(self.frame,self.x,self.y,1,1,self.flp)
 end,
 
 update=function(self)
  self.dx*=friction
  self.dy*=friction
  
  if btn(0) then
   self.dx-=self.acc
   self.flp=false
  end
  if btn(1) then 
   self.dx+=self.acc
   self.flp=true
  end
  if btn(2) then self.dy-=self.acc end
  if btn(3) then self.dy+=self.acc end
    
  self.dx=mid(-max_speed,self.dx,max_speed)	 
  self.dy=mid(-max_speed,self.dy,max_speed)
 	
 	local collisions=is_colliding(self.x,self.y,8,8,self.dx,self.dy)
 	if collisions.top or collisions.bottom then
   self.dy=0
 	end
 	if collisions.left or collisions.right then
   self.dx=0
 	end

 	self.x+=self.dx
 	self.y+=self.dy
 		
  if abs(self.dx)<0.05 then self.dx=0 end
  if abs(self.dy)<0.05 then self.dy=0 end
 end
}

-- main
function _init()
end

function _update60()
 t+=1
 player:update()
end

function _draw()
 cls(0)
 map()
 player:draw()
end

-- tools
function is_walkable(x,y)
 local tile=mget(x/8,y/8)
 return not fget(tile,0)
end

function is_colliding(x,y,w,h,dx,dy)
    local top=false
    local right=false
    local bottom=false
    local left=false


    if dx>0 then
        for i=0,7 do
            if not is_walkable(x+w,y+i) then
                right=true
            end
        end
    end

    if dx<0 then
        for i=0,7 do
            if not is_walkable(x-1,y+i) then
                left=true
            end
        end
    end

    if dy<0 then
        for i=0,7 do
            if not is_walkable(x+i,y-1) then
                top=true
            end
        end
    end

    if dy>0 then
        for i=0,7 do
            if not is_walkable(x+i,y+h) then
                bottom=true 
            end
        end
    end

    return {
        top=top,
        right=right,
        bottom=bottom,
        left=left
    }
end