L = 220e-6;
C = 470e-6;
R = 10;
D = 0.5;

Vg = 12;

converter = BoostConverter(L, C);
converter = converter.add_supply_voltage(Vg);
converter = converter.add_load(R);
converter = converter.set_duty_cycle(D);
converter.summary();

gain = converter.get_gain()