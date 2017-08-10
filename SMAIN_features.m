%%% AOB - 1
clear all; close all
%%%%%%%%%%%%%%%%%
% -- Load Data --
%%%%%%%%%%%%%%%%%
[theta,names_string] = dataLoad(); %cell(NxT)(subject,trial)
[N,T] = size(theta); % Number of Subjects X Number of Trials
theta1 = theta{1,1};
d = size(theta{1,1},1);

%%%%%%%%%%%%%%%%%%%%
% -- Experimetnal info
%%%%%%%%%%%%%%%%%%%%
dt = 1/128; % IMU's sampling rate is 128 Hz


%%%%%%%%%%%%%%%%
% -- Sub Data --
%%%%%%%%%%%%%%%%

% % Average over trials
% %   %% To do this we need to align signals and have same size
% theta_avg = cell(1,N);
% for i = 1:N
%     [d,n] = size(theta{i,1});
%     running_sum = zeros(d,n);
%     for j=1:T
%         running_sum = running_sum + theta{i,j};
%     end
%     theta_avg{1,i} = running_sum/n;
%     clearvars running_sum
% end

%%%%%%%%%%%%%%%%%
% -- Visualize --
%%%%%%%%%%%%%%%%%

% Plot as is
delays = zeros(1,T-1);
which_Subject = 1;
which_Axis = 1;
figure
for i=1:T
    subplot(2,3,i)
    hold on
    for j=1:N
        plot(theta{j,i}(which_Axis,:),'linewidth',5)
    end
    legend(names_string{1},names_string{2},names_string{3},...
        names_string{4},names_string{5})
    
    if (i<T)
        delays(i) = finddelay(theta{which_Subject,i}(which_Axis,:), ...
            theta{which_Subject,i+1}(which_Axis,:));
    end
end

figure
hold on
plot(theta1(1,:))
plot(diff(theta1(1,:))/dt)

% Plot time evolution of curve
figure
hold on
for i=1:N
    plot3(theta{i,1}(1,:),theta{i,1}(2,:),theta{i,1}(3,:))
end

%plot(theta{1,1}(1,:),theta{1,1}(2,:));


%%%%%%%%%%%%%%%%%%%%%%%%
% -- Extract Features --
%%%%%%%%%%%%%%%%%%%%%%%%

% - L2 integral
vl2 = cell(N,1);
% - Derivatives
dtheta = cell(N,T);
vsobl2 = cell(N,1);
% - Others
vlu = cell(N,1);
vl1 = cell(N,1);
vtv = cell(N,1);
% - Merge
vfeat = cell(N,1);
vfeat_pca = cell(N,1);
vfeat_tSNE = cell(N,1);
%
figure
hold on
for i = 1:N
    vl2{i} = zeros(T,d);
    vsobl2{i} = zeros(T,d);
    vlu{i} = zeros(T,d);
    vl1{i} = zeros(T,d);
    vtv{i} = zeros(T,d);
    for j=1:T
        for jdim = 1:d
            % L2
            vl2{i}(j,jdim) = trapz(theta{i,j}(jdim,:).^2);
            % L1
            vl1{i}(j,jdim) = trapz(abs(theta{i,j}(jdim,:)));
            
            % Deriv
            dtheta{i,j}(jdim,:) = diff(theta{i,j}(jdim,:));
            vsobl2{i}(j,jdim) = trapz(dtheta{i,j}(jdim,:).^2);
            
            % Total Variation
            vtv{i}(j,jdim) = trapz(abs(dtheta{i,j}(jdim,:)));
            
            % Max
            vlu{i}(j,jdim) = max(abs(theta{i,j}(jdim,:)));
        end
    end
    % Merge
    vfeat{i} = [vl2{i}, vsobl2{i}, vlu{i},vtv{i},vl1{i}];
    
    % standardize?
    vfeat{i} = zscore(vfeat{i});
    
%     % PCA
%     subplot(2,1,1); hold on
%     [~,vfeat_pca{i}] = pca(vl2{i});
%     scatter(vfeat_pca{i}(:,1),vfeat_pca{i}(:,2),'fill')
    %t-SNE
%     subplot(2,1,2); hold on
    vfeat_tSNE{i} = tsne(vl2{i},'numdimensions',3);
    scatter3(vfeat_tSNE{i}(:,1),vfeat_tSNE{i}(:,2),vfeat_tSNE{i}(:,3),'linewidth',2);
end
legend(names_string{1},names_string{2},names_string{3},names_string{4},names_string{5})

% OK, so PCA doesn't reveal clustering (w.r.t L2 norm only). Let's keep the
% fight...

% tSNE seems to do well, but very unreliable, some times favors one subject
% sometimes another. Maybe with more features

% Try doing MDS with some similarity metric, maybe good old KME and SKM ;)
























%%%%%%%%%%%
% -- End --
%%%%%%%%%%%
