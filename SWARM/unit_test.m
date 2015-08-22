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

x = s.getNewRandomState
y = s.getNewRandomState

u = s.InverseKinematicsFcn(x, y);

s.UpdateState(u)

s.ControlsShuffle(u)

s.PlotState(x, '*r')
s.PlotState(y, 'ob')

s.PlotStateTransition(x, y)
for k = 1:10
x = s.State;    
y = s.getNewRandomState

u = s.InverseKinematicsFcn(x, y);
s.UpdateState(u)
s.PlotStateTransition(x, s.State);
s.PlotState(s.State, 'xk')
pause(1)
end

