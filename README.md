# UE-Mobility-Driven-Beam-Selection-and-Handover-Strategy-for-Dense-5G-Deployments

This project simulates a user equipment (UE) moving in a multi-base-station (gNB) environment with mmWave communication. The simulation dynamically evaluates beamforming, SNR, and handover logic based on the UE's position and movement.

## Project Objective
The goal is to:

Simulate a UE moving through a cellular environment

Track and select the best beam and gNB based on Signal-to-Noise Ratio (SNR)

Trigger beam switching or handover decisions dynamically

Visualize UE trajectory, SNR over time, serving gNB, and beam index evolution

## Key Features
Multiple gNBs and beamforming: Each gNB has a directional beam codebook (e.g., 16 beams).

### Dynamic UE path: UE follows a randomized path based on a given speed.

### SNR evaluation: Best gNB/beam is selected at every timestep based on received power.

### Beam switching and handover:

o Beam switch: within same gNB

o Handover: switch to a new gNB if SNR margin and time-to-trigger are satisfied

### Path loss and angular gain models

### Visualization of:

o SNR over time

o Active gNB over time

o Active beam index over time

o UE trajectory with annotated beam switch and handover events

## Output Plots
o UE trajectory with gNB locations, beam switch (🟢), and handover points (🔴)

## SNR variation over time with threshold line
![Beams Switching and Handover](Beam_Switches_Handover.png)
## Serving gNB index timeline
![Serving gNB](ServingBS.png)
## Use Cases
### Testbed for mmWave mobility simulations

### Analysis of beam management and handover strategies

### Useful in research on:

o 5G/6G mobility

o Beamforming optimization

o Low-latency handover algorithms

o Intelligent beam prediction
