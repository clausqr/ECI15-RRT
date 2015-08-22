function h = PlotState(obj, state, style)
hold on
    %unused idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
    h = zeros(1, obj.UAVCount);
    for k=1:obj.UAVCount
        idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
        h(k) = obj.UAV(k).PlotState(state(idxs_states), style);
    end
end