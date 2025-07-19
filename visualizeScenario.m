function visualizeScenario(simTime, snr_log, snrThresh, active_gNB_log, active_beam_log, uePath, gNBs, beam_switch_events, handover_events)

    % Plot 1: SNR over time
    figure;
    plot(1:simTime, snr_log, 'LineWidth', 1.5);
    hold on;
    yline(snrThresh, '--r', 'SNR Threshold');
    xlabel('Time Step');
    ylabel('SNR (dB)');
    title('SNR over Time');
    grid on;

    % Plot 2: Active gNB over time
    figure;
    stairs(1:simTime, active_gNB_log, 'LineWidth', 1.5);
    xlabel('Time Step');
    ylabel('Active gNB');
    title('Serving gNB Index over Time');
    grid on;

    % Plot 3: UE trajectory with gNBs, beam switch and handover events
    figure;
    plot(uePath(1, :), uePath(2, :), 'b', 'LineWidth', 1.5);
    hold on;
    scatter(gNBs(:, 1), gNBs(:, 2), 100, 'ks', 'filled');

    % Dynamically label each gNB
    num_gNBs = size(gNBs, 1);
    for g = 1:num_gNBs
        text(gNBs(g, 1)+2, gNBs(g, 2)+2, sprintf('gNB%d', g));
    end

    % Mark beam switches
    scatter(uePath(1, beam_switch_events), uePath(2, beam_switch_events), ...
        60, 'go', 'filled', 'DisplayName', 'Beam Switch');

    % Mark handovers
    scatter(uePath(1, handover_events), uePath(2, handover_events), ...
        60, 'ro', 'filled', 'DisplayName', 'Handover');

    legend('UE Path', 'gNBs', 'Beam Switch', 'Handover');
    xlabel('x (m)');
    ylabel('y (m)');
    title('UE Trajectory with Beam Switches and Handovers');
    axis equal;
    grid on;

    % Plot 4: Active Beam Index over Time
    figure;
    stairs(1:simTime, active_beam_log, 'LineWidth', 1.5);
    xlabel('Time Step');
    ylabel('Beam Index');
    title('Serving Beam Index over Time');
    grid on;

end
