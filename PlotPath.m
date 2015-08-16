function PlotPath(vertices, p)

p = cell2mat(p);

for i = 1:(length(p)-1)
    
   edge = getNewRRTEdge(p(i), p(i+1));
   
   PlotEdge(vertices, edge, 'Color', 'Red')

end