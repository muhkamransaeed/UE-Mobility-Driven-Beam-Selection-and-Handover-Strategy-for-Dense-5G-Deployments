function [snr_log, active_gNB_log, active_beam_log] = calculateSNR(simTime, timeStep, gNBs, beamVecs, numBeams, uePath)
% EVALUATECHANNELSNR Computes best gNB/beam/SNR at each time step
% Inputs:
%   simTime     - total number of time steps
%   timeStep    - time step in milliseconds
%   ueSpeed     - speed of the UE (m/s)
%   uePos       - initial position of UE [2x1 vector]
%   gNBs        - [Nx2] matrix of gNB positions
%   beamVecs    - cell array of unit vectors for beams per gNB
%   numBeams    - number of beams per gNB
%
% Outputs:
%   snr_log         - best SNR at each time step
%   active_gNB_log  - index of best gNB at each time step
%   active_beam_log - index of best beam at each time step
%   uePath          - 2 x simTime matrix of UE positions

    num_gNBs = size(gNBs, 1);

    % Constants
    Pt_dBm = 23;             % Transmit power (dBm)
    NF_dB = 7;               % Noise figure
    BW = 100e6;              % Bandwidth (Hz)
    N0_dBm = -174 + 10*log10(BW);  % Noise power spectral density
    noiseFloor_dBm = N0_dBm + NF_dB;

    % Path loss parameters
    PL0 = 72;    % Reference path loss at 1m (dB) for mmWave
    n = 2.5;     % Path loss exponent

    % Initialize logs
    snr_log = zeros(1, simTime);
    active_gNB_log = zeros(1, simTime);
    active_beam_log = zeros(1, simTime);

    % Loop over each time step
    for t = 1:simTime
        uePos = uePath(:,t);  % Move in +x
        

        bestSNR = -Inf;
        bestBeam = 0;
        bestgNB = 0;

        for g = 1:num_gNBs
            delta = uePos - gNBs(g, :)';
            dist = norm(delta) + 1e-3;
            dirVec = delta / dist;

            for b = 1:numBeams
                beamVec = beamVecs{g}(:, b);
                angleCos = dot(beamVec, dirVec);
                angularGain_dB = 10 * log10(max(angleCos, 0.001));
                pathLoss_dB = PL0 + 10 * n * log10(dist);
                Pr_dBm = Pt_dBm + angularGain_dB - pathLoss_dB;
                SNR_dB = Pr_dBm - noiseFloor_dBm;

                if SNR_dB > bestSNR
                    bestSNR = SNR_dB;
                    bestgNB = g;
                    bestBeam = b;
                end
            end
        end

        snr_log(t) = bestSNR;
        active_gNB_log(t) = bestgNB;
        active_beam_log(t) = bestBeam;
    end

    fprintf('--- Channel Evaluation and SNR Estimation Complete ---\n');
end
