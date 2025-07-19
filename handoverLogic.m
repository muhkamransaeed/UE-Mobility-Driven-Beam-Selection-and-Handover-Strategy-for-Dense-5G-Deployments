function [active_gNB_log, active_beam_log, handover_events, beam_switch_events] = handoverLogic(snr_log, active_gNB_log, active_beam_log, uePath, gNBs, beamVecs, Pt_dBm, PL0, n, noiseFloor_dBm, simTime)

% Constants
handover_hysteresis = 3;     % dB above current SNR to trigger handover
handover_ttt = 3;            % time-to-trigger (slots)
handover_timer = 0;          % countdown

% Initialize serving gNB and beam (first time step)
current_gNB = active_gNB_log(1);
current_beam = active_beam_log(1);

% Logs
handover_events = [];
beam_switch_events = [];

% Step through each time step for handover decision
for t = 2:simTime
    prev_gNB = current_gNB;
    prev_beam = current_beam;

    % Current SNR from current gNB and beam
    delta = uePath(:, t) - gNBs(current_gNB, :)';
    dist = norm(delta) + 1e-3;
    dirVec = delta / dist;
    beamVec = beamVecs{current_gNB}(:, current_beam);
    angleCos = dot(beamVec, dirVec);
    angularGain_dB = 10 * log10(max(angleCos, 0.001));
    pathLoss_dB = PL0 + 10 * n * log10(dist);
    currPr_dBm = Pt_dBm + angularGain_dB - pathLoss_dB;
    currSNR_dB = currPr_dBm - noiseFloor_dBm;

    % Best gNB/beam from logs
    bestSNR = snr_log(t);
    best_gNB = active_gNB_log(t);
    best_beam = active_beam_log(t);

    % Decision 1: Beam switch within same gNB
    if best_gNB == current_gNB && best_beam ~= current_beam
        current_beam = best_beam;
        beam_switch_events = [beam_switch_events, t];
    end

    % Decision 2: Handover to new gNB
    if best_gNB ~= current_gNB && bestSNR > (currSNR_dB + handover_hysteresis)
        if handover_timer >= handover_ttt
            current_gNB = best_gNB;
            current_beam = best_beam;
            handover_events = [handover_events, t];
            handover_timer = 0;
        else
            handover_timer = handover_timer + 1;
        end
    else
        handover_timer = 0;
    end

    % Update logs
    active_gNB_log(t) = current_gNB;
    active_beam_log(t) = current_beam;
end

fprintf('--- Handover and Beam Switching Decisions Applied ---\n');
fprintf('Total Beam Switches: %d\n', numel(beam_switch_events));
fprintf('Total Handovers:     %d\n', numel(handover_events));

end
