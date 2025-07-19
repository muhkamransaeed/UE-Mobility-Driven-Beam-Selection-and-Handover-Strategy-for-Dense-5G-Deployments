% Step 1: Setup simulation parameters
clear; clc; close all;

% Simulation time
timeStep = 1;   % in ms

% Parameters
ueSpeed = 3;             % m/s
uePos = [50; 0];          % Initial position (x, y)
simTime = 500;           % Simulation duration

% SNR threshold for beam switching or handover
snrThresh = 0;  % dB


% Base station locations
gNBs = [0, 0;     % gNB 1 at origin
        100, 0;
        50, 25];  % gNB 2 at 100m along x-axis
num_gNBs = size(gNBs, 1);

% Number of beams per gNB
numBeams = 16;


% Constants
Pt_dBm = 23;             % Transmit power (dBm)
NF_dB = 7;               % Noise figure
BW = 100e6;              % Bandwidth (Hz)
N0_dBm = -174 + 10*log10(BW);  % Noise power spectral density
noiseFloor_dBm = N0_dBm + NF_dB;

% Path loss parameters (simplified)
PL0 = 72;    % Reference path loss at 1m (dB) for mmWave
n = 2.5;     % Path loss exponent



% Generate UE path
uePath = generateUEPath(ueSpeed, uePos, simTime);

[beamDirs, beamVecs] = generateBeams(num_gNBs, numBeams);


[snr_log, active_gNB_log, active_beam_log] = calculateSNR(simTime, timeStep, gNBs, beamVecs, numBeams, uePath);

[active_gNB_log, active_beam_log, handover_events, beam_switch_events] = handoverLogic(snr_log, active_gNB_log, active_beam_log, uePath, gNBs, beamVecs, Pt_dBm, PL0, n, noiseFloor_dBm, simTime);

visualizeScenario(simTime, snr_log, snrThresh, active_gNB_log, active_beam_log, uePath, gNBs, beam_switch_events, handover_events);
