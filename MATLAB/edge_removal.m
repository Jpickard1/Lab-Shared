function [known_network, unknown_network] = edge_removal(network, method, percent_removed)
    if ~islogical(network)
        network = logical(network);
        disp('WARNING: Edge removal directory is set to work with undirected, unweighted graphs.')
    end
    switch method
        case 'R'
            [known_network, unknown_network] = edgeRemoval.random_removal(network, percent_removed);
        case 'SB'
            [known_network, unknown_network] = edgeRemoval.snowball_removal(network, percent_removed);
        case 'CE'
            [known_network, unknown_network] = edgeRemoval.cold_ends_removal(network, percent_removed);
        case 'RC'
            [known_network, unknown_network] = edgeRemoval.right_censoring_removal(network, percent_removed);
    end
end