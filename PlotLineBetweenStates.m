function h = PlotLineBetweenStates(s1, s2, style)

    u = s1(1:2);
    v = s2(1:2);
    
    h = line([u(1) v(1)], [u(2) v(2)]);

