clear; clc; close all;

% Parameters
num_points = 20;       % Grid size (20x20)
total_nodes = num_points * num_points;
num_removed = 250;     % Number of points to remove
num_graphs = 5;        % Number of graphs to generate

% Start and End Nodes
start_node = [1, 1];
end_node = [20, 20];

% Generate 5 graphs with feasible paths
generated_graphs = 0;  % Counter for generated graphs

while generated_graphs < num_graphs
    % Step 1: Generate all points
    [X, Y] = meshgrid(1:num_points, 1:num_points);
    all_points = [X(:), Y(:)];
    
    % Exclude start and end nodes from removal
    remaining_points = setdiff(all_points, [start_node; end_node], 'rows');
    
    % Randomly remove points
    rng('shuffle');  

    % Ensure randomness
    indices = randperm(size(remaining_points, 1), num_removed);
    removed_points = remaining_points(indices, :);
    
    % Remaining nodes after removal
    nodes = setdiff(all_points, removed_points, 'rows');
    
    % Check if start and end nodes are present
    if ~ismember(start_node, nodes, 'rows') || ~ismember(end_node, nodes, 'rows')
        continue;  % Restart if start or end node is missing
    end
    
    % Step 2: Build the graph
    num_nodes = size(nodes, 1);
    
    % Create a mapping from coordinates to indices
    node_indices = containers.Map;
    for i = 1:num_nodes
        key = mat2str(nodes(i, :));
        node_indices(key) = i;
    end
    
    % Initialize adjacency list
    adj_list = cell(num_nodes, 1);
    
    for i = 1:num_nodes
        current_node = nodes(i, :);
        % Potential neighbors (within 1 unit in x and y)
        neighbors = current_node + [-1, -1; -1, 0; -1, 1; ...
                                    0, -1;        0, 1; ...
                                    1, -1;  1, 0;  1, 1];
        % Keep neighbors within grid boundaries
        valid_idx = neighbors(:,1) >= 1 & neighbors(:,1) <= num_points & ...
                    neighbors(:,2) >= 1 & neighbors(:,2) <= num_points;
        neighbors = neighbors(valid_idx, :);
        % Exclude removed points
        [is_member, loc] = ismember(neighbors, nodes, 'rows');
        neighbors = neighbors(is_member, :);
        neighbor_indices = loc(is_member);
        % Calculate distances (Euclidean distance)
        distances = sqrt(sum((neighbors - current_node).^2, 2));
        % Store in adjacency list
        adj_list{i} = [neighbor_indices, distances];
    end
    
    % Get indices for start and end nodes
    start_key = mat2str(start_node);
    end_key = mat2str(end_node);
    start_idx = node_indices(start_key);
    end_idx = node_indices(end_key);
    
    % Step 3: Implement Dijkstra's Algorithm using MATLAB arrays
    distances = inf(num_nodes, 1);  % Initialize distances to infinity
    previous = zeros(num_nodes, 1); % Store the previous node for path reconstruction
    distances(start_idx) = 0;       % Distance to start node is 0
    visited = false(num_nodes, 1);  % Track visited nodes
    
    % Initialize queue with the start node
    queue = [start_idx, 0];  % Each element is [node_index, distance]
    
    while ~isempty(queue)
        % Sort queue based on distance (2nd column) and pop the smallest
        [~, idx] = min(queue(:, 2));
        current = queue(idx, :);
        queue(idx, :) = [];  % Remove the current node from the queue
        u = current(1);      % Current node index
        u_dist = current(2); % Current node distance
        
        if visited(u)
            continue;  % Skip if node has been visited
        end
        visited(u) = true;
        
        if u == end_idx
            break;  % Shortest path to end node found
        end
        
        % Process each neighbor of the current node
        neighbors = adj_list{u};
        for n = 1:size(neighbors, 1)
            v = neighbors(n, 1);  % Neighbor node index
            if visited(v)
                continue;  % Skip if neighbor has been visited
            end
            alt = distances(u) + neighbors(n, 2);  % Alternative path distance
            if alt < distances(v)
                distances(v) = alt;  % Update shortest distance
                previous(v) = u;     % Update path
                queue = [queue; v, alt];  % Add neighbor to the queue
            end
        end
    end
    
    % Step 4: Retrieve the least cost path
    if distances(end_idx) == inf
        continue;  % No path found, regenerate the graph
    else
        % Reconstruct path
        path = end_idx;
        while path(1) ~= start_idx
            path = [previous(path(1)); path];
        end
        % Convert indices to coordinates
        path_coords = nodes(path, :);
        
        % Step 5: Plot the graph and the least cost path
        figure;
        hold on;
        % Plot removed nodes
        plot(removed_points(:,1), removed_points(:,2), 'ro', 'MarkerSize', 5, 'DisplayName', 'Removed Nodes');
        % Plot remaining nodes
        plot(nodes(:,1), nodes(:,2), 'go', 'MarkerSize', 5, 'DisplayName', 'Remaining Nodes');
        % Plot least cost path
        plot(path_coords(:,1), path_coords(:,2), 'b-', 'LineWidth', 2, 'DisplayName', 'Least Cost Path');
        % Mark start and end nodes
        plot(start_node(1), start_node(2), 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'y', 'DisplayName', 'Start Node');
        plot(end_node(1), end_node(2), 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'c', 'DisplayName', 'End Node');
        title(sprintf('Graph %d: Least Cost Path from (1,1) to (20,20)', generated_graphs + 1));
        xlabel('X-axis');
        ylabel('Y-axis');
        legend('Location', 'bestoutside');
        grid on;
        axis equal;
        hold off;
        
        % Increment the counter
        generated_graphs = generated_graphs + 1;
    end
end
