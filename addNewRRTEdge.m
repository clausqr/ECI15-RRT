function [g, new_edges, new_edge_n] = addNewRRTEdge(g,...
                                             edges,...
                                             new_edge_to_add)

new_edges = [edges rand(1)];

a = new_edge_to_add(1);
b = new_edge_to_add(2);

g.addEdge(a, b);
new_edge_n = size(new_edges,2);
