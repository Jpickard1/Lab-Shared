% Description: This function computes a similarity matrix between each
% vertex in a network. It accepts and adjacency matrix as well as a
% parameter for which similarity index should be used.
%
% Local Similarity Measures:
%  - AA: Adamic Adar
%  - CN: Common Neighbors
%  - HD: Hub Depressed
%  - HP: Hub Promoted
%  - JC: Jaccard
%  - LHN: Leicht-Holme-Newman
%  - PA: Preferential Attachment
%  - RS: Resource Allocation
%  - SA: Salton
%  - SO: Sorensen
% Global Similarity Measures:
%  - 'K': Katz
%  - 'ACT': Average Commute Time
%  - 'RWR': Random Walk with Restart
%
% References:
% Local indices: "Uncovering Missing Links with Cold Ends"
%    https://drive.google.com/file/d/1TsXGWMqqt5euCtxnEQBodo3FM74gyvzO/view
% Global indices: "Link prediction in complex networks: A survey"
%    https://drive.google.com/file/d/1ORRPl2rUiboOJ5FdYnaIvl3uk4lAT2Ff/view
function similarity=getSimilarity(adj, index)
    similarity = zeros(size(adj));
    for i=1:height(adj)
        for j=i+1:height(adj)
            % i_j_similarity = 0;
            switch index
                % Local similarity
                case 'AA'
                    i_j_similarity = similarity.local.adamicAdar_index(adj, i, j);
                case 'CN'
                    i_j_similarity = similarity.local.commonNeighbors_index(adj, i, j);
                case 'HD'
                    i_j_similarity = similarity.local.hubDepressed_index(adj, i, j);
                case 'HP'
                    i_j_similarity = similarity.local.hubPromoted_index(adj, i, j);
                case 'JC'
                    i_j_similarity = similarity.local.jaccard_index(adj, i, j);
                case 'LHN'
                    i_j_similarity = similarity.local.leichtHolmeNewman_index(adj, i, j);
                case 'PA'
                    i_j_similarity = similarity.local.preferentialAttachment(adj, i, j);
                case 'RS'
                    i_j_similarity = similarity.local.resourceAllocation(adj, i, j);
                case 'SA'
                    i_j_similarity = similarity.local.salton_index(adj, i, j);
                case 'SO'
                    i_j_similarity = similarity.local.sorensen_index(adj, i,j);
                % Global similarity
                case 'ACT'
                    i_j_similarity = similarity.global.averageCommuteTime_index(adj, i, j);
                case 'RWR'
                    i_j_similarity = similarity.global.randomWalkWithRestart_index(adj, i, j);
                case 'K'
                    similarity = similarity.global.katz_index(adj);
                    return
            end
            similarity(i, j) = i_j_similarity;
            similarity(j, i) = i_j_similarity;
        end
    end
end
