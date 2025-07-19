function uePath = generateUEPath(ueSpeed, uePos, simTime)
%GENERATEUEPATH Generates a random walk path for the user equipment (UE).
%
% Inputs:
%   ueSpeed - scalar value, speed of UE in meters/second
%   uePos   - initial position of UE as a 2-element column vector [x; y]
%   simTime - total number of time steps to simulate
%
% Output:
%   uePath  - 2 x simTime matrix containing the UE position at each time step

    uePath = zeros(2, simTime);  % Preallocate path array
    uePath(:, 1) = uePos;        % Set initial position

    for t = 2:simTime
        angle = 2 * pi * rand();  % Random direction [0, 2π]
        dx = ueSpeed * cos(angle);
        dy = ueSpeed * sin(angle);
        uePath(:, t) = uePath(:, t-1) + [dx; dy];
    end
end