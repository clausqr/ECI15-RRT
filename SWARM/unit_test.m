% test SWARM
clear 
r = UAV
r.Init(r.getNewRandomState)
s = SWARM

s.AddUAV(r)
s.AddUAV(r)
s.AddUAV(r)
s.AddUAV(r)
s.AddUAV(r)

u = rand(10,1)

s.UpdateState(u)