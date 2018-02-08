-- snowflakes
-- by harrewarre

tmr=0
flakes={}

function _init()
 for f= 1,100 do
  flakes[f]=flake_ctor(random_pos(),random_pos(),1)
 end
end

function _update()
	tmr=tmr+1
	
	if(tmr==29) then
	 tmr=0
	end
	
 for fl in all(flakes) do
  fl.update()
 end
end

function _draw()
 cls()
 rectfill(0,0,127,127,1)
 for fl in all(flakes) do
  fl.draw()
 end
end

-- snowlfake

function flake_ctor(x,y,speed)
 local max_speed=1
 local flake={}
  
 flake.x=x
 flake.y=y
 
 flake.wave_cnt=0
 flake.wave_spd=random_between(5,10)
 
 flake.speed=rnd(max_speed)
 
 flake.update=function()
  if flake.speed < 0.25 then
  	flake.speed=rnd(max_speed)
  end
 
  flake.wave_cnt=flake.wave_cnt+flake.wave_spd
 
  flake.y=flake.y+flake.speed
  flake.x=flake.x+sin(flake.wave_cnt/500)
  
  if(flake.y > 127) then
  	sfx(0)
   flake.y=0
   flake.x=random_pos()
   flake.speed=rnd(max_speed)
   flake.wave_cnt=0
   flake.wave_spd=random_between(5,10)
  end
 end
 
 flake.draw=function()
  rectfill(flake.x,flake.y,flake.x+1,flake.y+1,7)
 end
  
 return flake
end

-- util

function random_pos()
 return flr(rnd(127))
end

function random_between(minval,maxval)
 return flr(rnd() * (maxval-minval+1))+minval
end