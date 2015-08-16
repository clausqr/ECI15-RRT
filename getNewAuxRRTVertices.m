
function new_vertices = getNewAuxRRTVertices(r0, r1, d, a)

c1 = (r1(1) - r0(1))/...
    norm((r1' - r0'));
s1 = (r1(2) - r0(2))/...
    norm((r1' - r0'));

n = length(a);
new_vertices = zeros(3, n);

for i = 1:n
    
    c2 = cosd(a(i));
    s2 = sind(a(i));
    
    v(1) = r0(1) +...
        (c1*c2-s1*s2)*d;
    
    v(2) = r0(2) +...
        (s1*c2+c1*s2)*d;
    
    v(3) = 0;
    % .1*atan2(new_vertex(2), new_vertex(1));
    
    new_vertices(:,i) = v';
end


