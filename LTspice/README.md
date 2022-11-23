## Steps to Run the Simulation

1. Install [LTspice](https://www.analog.com/en/design-center/design-tools-and-calculators/ltspice-simulator.html).
1. Save this folder in your computer;
1. Open `boost_converter.asc` on LTspice;
1. Click on Run (running figure on the top toolbar);

## Troubleshooting

1. If simulation fails, check if component `X1` is linked to the correct files:
    - Right click on `X1` and try to open the linked Symbol and Schematic.
    - If it doesn't open the correct files, try to add a new `PID_controller` to the schematic: `Component > Top Directory > PID_controller`.