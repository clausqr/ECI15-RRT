function [g, vertices, new_vertex_n] = addNewRRTVertex(g, vertices, new_vertex_to_add)

    vertices = [vertices new_vertex_to_add]; 
    new_vertex_n = size(vertices, 2);
    g.addVertex(new_vertex_n);

end
