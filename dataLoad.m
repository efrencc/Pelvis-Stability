function[theta,names_string] = dataLoad()

string_1 = 'imu_25-Mar-2017.mat';
load(string_1)

names_string = {'Jill','Luby','Rob','Elius','Wei'};

N = size(data.Jill.data.combo_1.trial,2);

theta = cell(length(names_string),N);

for i=1:N
    theta{1,i}(1,:) = data.Jill.data.combo_1.trial(i).sensor_frame.kalman_angle.X;
    theta{1,i}(2,:) = data.Jill.data.combo_1.trial(i).sensor_frame.kalman_angle.Y;
    theta{1,i}(3,:) = data.Jill.data.combo_1.trial(i).sensor_frame.kalman_angle.Z;
end

for i=1:N
    theta{2,i}(1,:) = data.Luby.data.combo_1.trial(i).sensor_frame.kalman_angle.X;
    theta{2,i}(2,:) = data.Luby.data.combo_1.trial(i).sensor_frame.kalman_angle.Y;
    theta{2,i}(3,:) = data.Luby.data.combo_1.trial(i).sensor_frame.kalman_angle.Z;
end

for i=1:N
    theta{3,i}(1,:) = data.Rob.data.combo_1.trial(i).sensor_frame.kalman_angle.X;
    theta{3,i}(2,:) = data.Rob.data.combo_1.trial(i).sensor_frame.kalman_angle.Y;
    theta{3,i}(3,:) = data.Rob.data.combo_1.trial(i).sensor_frame.kalman_angle.Z;
end

for i=1:N
    theta{4,i}(1,:) = data.Elius.data.combo_1.trial(i).sensor_frame.kalman_angle.X;
    theta{4,i}(2,:) = data.Elius.data.combo_1.trial(i).sensor_frame.kalman_angle.Y;
    theta{4,i}(3,:) = data.Elius.data.combo_1.trial(i).sensor_frame.kalman_angle.Z;
end

for i=1:N
theta{5,i}(1,:) = data.Wei.data.combo_1.trial(i).sensor_frame.kalman_angle.X;
theta{5,i}(2,:) = data.Wei.data.combo_1.trial(i).sensor_frame.kalman_angle.Y;
theta{5,i}(3,:) = data.Wei.data.combo_1.trial(i).sensor_frame.kalman_angle.Z;
end



end