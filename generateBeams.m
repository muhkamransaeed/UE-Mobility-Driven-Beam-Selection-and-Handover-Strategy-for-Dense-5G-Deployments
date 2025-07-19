function [beamDirs, beamVecs] = generateBeams(num_gNBs, numBeams)
    % Define beam directions for each gNB 
    beamDirs = cell(num_gNBs, 1);  % angles in degrees

    for g = 1:num_gNBs
        % Define beam center angles for each beam in the ±180° sector
        beamDirs{g} = linspace(-180, 180, numBeams);
    end

    % For each beam, define its unit direction vector (cos/sin)
    beamVecs = cell(num_gNBs, 1);  % unit vectors [x; y]
    for g = 1:num_gNBs
        angles = deg2rad(beamDirs{g});
        beamVecs{g} = [cos(angles); sin(angles)];
    end

    fprintf('--- Beam Codebooks Generated for %d gNBs ---\n', num_gNBs);
end
