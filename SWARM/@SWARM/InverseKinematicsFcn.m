function u = InverseKinematicsFcn(obj, x, y)
% INVERSEKINEMATICS Inverse Dynamics (or Kinematics) function,
%   calls the function for each of the Swarm members   
        

n = obj.UAVCount;
u = 0*obj.State;
for k = 1:n
    
    idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
    idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
    u(idxs_states) = obj.UAV(k).InverseKinematicsFcn(...
        x(idxs_states),...
        y(idxs_inputs));

end
end