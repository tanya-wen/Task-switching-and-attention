%% save task order to .txt for MTurk
rand('seed', 0);

fileID = fopen('sequence_order.txt','w');
% generate 100 sequences
for i = 1:100
    % ntasks * ntasks matrix where row number corresponds to the previous
    % task number and column number the current task number. Matrix values
    % show the amount of each task transition left.
    test_mat = [
        2 2 1 1
        2 2 1 1
        1 1 2 2
        1 1 2 2];
    
    ntasks = 4;
    fragment = 0;
    clear temp
    while sum(sum(test_mat))>0 % while there are still numbers of task transitions left
        row = randi(ntasks); % start by chosing a random row
        while sum(test_mat(row,:))==0 % if row chosen is empty (vaules sum to 0) chose again
            row = randi(ntasks);
        end
        fragment = fragment + 1; % add 1 to the fragment count for each time new loop
        count = 0;
        while sum(test_mat(row,:))>0 % while there are transitions left from the previous task
            count = count + 1;
            col = randi(ntasks); % chose the column number
            while test_mat(row,col)==0 % If there aren't any transitions left between that row and coulmn then chose again
                col=randi(ntasks);
            end
            test_mat(row,col) = test_mat(row,col) - 1; % Take 1 away from the chosen transition value
            temp(fragment,count) = row; % add the previous task number to the temporary variable of run order fragments
            row = col; % make the current task number the previous task number
        end
        temp(fragment,count+1) = col; % after the fragment ends add the current task number to the end of the run order fragment
    end
    
    % Combine the run-order fragments such that numbers of each sequence-change
    % conditions aren't disrupted. By insterting them after the same number the
    % fragment begins and ends with
    seq_order = temp(1,:);
    seq_order = seq_order(seq_order~=0);
    count = 1;
    while size(temp,1)>count
        count = count + 1;
        lead = temp(count,1);
        point = datasample(find(seq_order==lead),1);
        insert = temp(count,2:end);
        insert = insert(insert~=0);
        seq_order = [seq_order(1:point) insert seq_order(point+1:end)];
    end
    
    variables.seq_order = seq_order;
    
    %dlmwrite(sprintf('/Users/tanyawen/Box/Home Folder tw260/Private/task switching and attention/javascript code/SequenceOrders/SequenceOrder%04d.txt',i),variables.seq_order);
    
    
    fprintf(fileID,'[');
    for j = 1:length(seq_order)
        if j < length(seq_order)
            fprintf(fileID,'%d, ',seq_order(j));
        else fprintf(fileID,'%d',seq_order(j));
        end
    end
    fprintf(fileID,'], \n');
    
end

fclose(fileID);