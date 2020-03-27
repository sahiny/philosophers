function [newNodes, new_id_cell2id_node, adj, rc_found] = find_rainbow_cycles_centralized(varargin)
% finds all rainbow cycles and creates a "merged" node for each rainbow
%
% Input:
%   Nodes: {node1, node2, ...}
%       node: instance of class node
%           .id_cell = [id_cell1; id_cell2; ...]
%           .children_id_node{color} = [id_cell, id_cell2 , ...]
%           .children_id_cell{color} = [id_cell, id_cell2 , ...]
%
% Outputs:
%   newNodes: {newNode1, newNode2, ...}
%   where each node is either a node from the original Nodes, or a merged Node 
% 
%

% run
% .id_nodes
% .nodes
% .all_id_cells
% .colors
% .colors_left

%% inputs
Nodes = varargin{1};
Paths = varargin{2};
id_cell2id_node = varargin{3};
adj = varargin{4};
%% Outputs
newNodes = {};
new_id_cell2id_node = cell(size(id_cell2id_node));
rc_found = false;

% find rainbow cycles
RC_runs = {};
numNodes = length(Nodes);
num_colors = length(Paths); % num_agents

for n = 1:numNodes
    % start a breadth-first search tree
    mynode = Nodes{n};
    my_run.id_nodes = mynode.id;
%     my_run.nodes = my_node;
    my_run.all_id_cells = mynode.id_cell;
    my_run.colors_left = 1:length(Paths);
    my_run.colors = [];
    open_list = {my_run};
    numNodes_n = length(newNodes);
    while ~isempty(open_list)
        % pick the first run from the open list
        run2explore = open_list{1}; open_list(1) = [];
        node2explore = Nodes{run2explore.id_nodes(end)};
        % expand tree for each color that is not already used
        for mm = 1:length(run2explore.colors_left)
            mycolor = run2explore.colors_left(mm);
            % find children that is accessed with this color
            children_color = node2explore.children_id_node{mycolor}; 
            for i = 1:length(children_color)
                child_node = Nodes{children_color(i)};
                % if shared, check for cycles
                if child_node.id == run2explore.id_nodes(1)
                    % cycle found
                    cycle_run = run2explore;
                    cycle_run.id_nodes = [run2explore.id_nodes; child_node.id];
                    cycle_run.colors = [run2explore.colors; mycolor];
                    %% should I check if this run is found before??
                    add_flag = true;
                    for r = 1:length(RC_runs)
                        my_run = RC_runs{r};
                        %% should I care about colors of the run?
                        if length(intersect(unique(cycle_run.id_nodes), unique(my_run.id_nodes))) == length(unique(my_run.id_nodes)) %...
                        %&& length(intersect(new_run.colors, run_o.colors)) == length(new_run.colors)
                            add_flag = false;
                            break
                        end
                    end
                    if add_flag
                        % add to RC
                        RC_runs{end+1} = cycle_run;
                    end
                    
                elseif ~isempty(find(run2explore.id_nodes == child_node.id, 1 ))
                    1; % not a simple cycle, ignore
                else
                    % add to open_list
                    new_run = run2explore;
                    new_run.all_id_cells = unique([run2explore.all_id_cells; child_node.id_cell]);
                    new_run.id_nodes = [run2explore.id_nodes; child_node.id];
                    new_run.colors = [run2explore.colors; mycolor];
                    new_run.colors_left = setdiff(run2explore.colors_left, mycolor);
                    % check before adding
                    add_flag = true;
                    for o = 1:length(open_list)
                        run_o = open_list{o};
                        %% should I care about colors of the run?
                        if length(intersect(unique(new_run.id_nodes), unique(run_o.id_nodes))) == length(unique(run_o.id_nodes)) ...
                           && length(intersect(new_run.colors, run_o.colors)) == length(new_run.colors)
                            add_flag = false;
                            break
                        end
                    end
                    if add_flag
                        open_list{end+1} = new_run; 
                    end
                end
            end            
        end
    end

end


%% check if any RC found
if ~isempty(RC_runs)
    rc_found = true;
end
%% merge intersecting nodes
i = 1;
while i <= length(RC_runs)-1
    rci = RC_runs{i};
    is_merged = false;
    j = i+1;
    while j <= length(RC_runs)
        rcj = RC_runs{j};
        j = j+1;
        if any(intersect(rci.all_id_cells, rcj.all_id_cells))
            j = j-1;
            rci.all_id_cells = unique([rci.all_id_cells;rcj.all_id_cells]);
            rci.id_nodes = unique([rci.id_nodes; rcj.id_nodes]);
            RC_runs{i} = rci;
            RC_runs(j) = [];
            is_merged = true;
        end        
    end  
    if ~is_merged
        i = i+1;
    end
end

%% create merged nodes
nodes_used = zeros(1, length(Nodes));
% create a node for each RC
for i = 1:length(RC_runs)
    rc = RC_runs{i};
    id_cell = rc.all_id_cells;
    rc_node = node(id_cell, [], [], [], num_colors);
    rc_node.id = length(newNodes)+1;
    rc_node.children_id_node = cell(1, num_colors);
    rc_node.children_id_cell = cell(1, num_colors);
    rc_node.id = i;
    newNodes{end+1} = rc_node;
    for c = 1:length(id_cell)
        new_id_cell2id_node{id_cell(c)} = unique([new_id_cell2id_node{id_cell(c)}; i]);
    end
    % mark the states merged as used
    nodes_used(unique(rc.id_nodes)) = 1;     
end

%% add rest of the nodes
for i = 1:length(nodes_used)
    if ~nodes_used(i)
        mynode = Nodes{i};
        mynode.id = length(newNodes)+1;
        mynode.children_id_node = cell(1, num_colors);
        mynode.children_id_cell = cell(1, num_colors);
        newNodes{end+1} = mynode; 
        for c = 1:length(mynode.id_cell)
            new_id_cell2id_node{mynode.id_cell(c)} = unique([new_id_cell2id_node{mynode.id_cell(c)}; mynode.id]);
        end
    end
end

%% add edges
for i = 1:length(newNodes)
    mynode = newNodes{i};
    for j = 1:length(mynode.id_cell)
        id_cell = mynode.id_cell(j);
        for my_color = 1:length(Paths)
            children = adj{id_cell, my_color};
            for c = 1:length(children)
                mynode.children_id_node{my_color} = unique([mynode.children_id_node{my_color}; new_id_cell2id_node{children(c)}]);
                mynode.children_id_cell{my_color} = unique([mynode.children_id_cell{my_color}; children(c)]);
                % remove self edges
                mynode.children_id_node{my_color} = setdiff(mynode.children_id_node{my_color}, mynode.id);                
            end
        end
    end
end
1;
