function PlotPath(States, Controls)


for i = 1:(length(States)-1)

   UAV.PlotStateTransition(States(:,i), States(:,i+1), Controls(:,i), 'Red', 3);
   
end