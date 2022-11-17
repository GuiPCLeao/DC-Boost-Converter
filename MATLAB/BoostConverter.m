classdef BoostConverter
    %   Defines a boost converter given its elements
    
    properties (Access = private)
        L           % inductance in H
        RL          % inductor resistance in Ohm
        C           % capacitance
        VD          % diode foward voltage
        RD          % diode foward resistance
        Ron         % MOSFET ON resistance
        
        D           % MOSFET switching duty-cycle
        R           % converter load
        Vg          % input DC voltage
        V_hat       % desired output DC voltage
        
        has_supply  % boolean that defines if converter has supply
                    % voltage connected on the input port
    end
    
    %% Public Methods:
    methods
        function obj = BoostConverter(L, C, VD, RL, RD, Ron)
            %   Creates a boost converter with given components values
            
            if nargin > 7
                error('myfuns:BoostConverter:TooManyInputs', ...
                    'requires at most 4 optional inputs');
            end
            
            % Fill in unset optional values.
            switch nargin
                case 2
                    VD = 0;
                    RL = 0;
                    RD = 0;
                    Ron = 0;
                case 3
                    RL = 0;
                    RD = 0;
                    Ron = 0;
                case 4
                    RD = 0;
                    Ron = 0;
                case 5
                    Ron = 0;
            end
            obj.L = L;
            obj.RL = RL;
            obj.C = C;
            obj.VD = VD;
            obj.RD = RD;
            obj.Ron = Ron;
            
            obj.D = 0;
            obj.R = Inf;
            obj.Vg = Inf;
            obj.V_hat = Inf;
            
            obj.has_supply = false;
        end
        
        function obj = summary(obj)
            %   Print the summary of the converter
            fprintf('      L         C        VD        RL        RD       Ron |        Vg         D         R\n');
            fprintf('=========================================================================================\n');
            fprintf('%0.1d%10.1d%10.1d%10.1d%10.1d%10.1d |%10.1d%10.1d%10.1d\n', obj.L, obj.C, obj.VD, obj.RL, obj.RD, obj.Ron, obj.Vg, obj.D, obj.R);
        end
        
        function obj = add_supply_voltage(obj, Vg)
            %   Add a supply voltage on the input port of the converter
            
            if nargin > 2
                error('myfuns:add_supply_voltage:TooManyInputs', ...
                    'requires no optional inputs');
            end
            obj.has_supply = true;
            obj.Vg = Vg;
        end
        
        function obj = add_load(obj, R)
            %   Add a load on the output port of the converter
            
            if nargin > 2
                error('myfuns:add_load:TooManyInputs', ...
                    'requires no optional inputs');
            end
            obj.R = R;
        end
        
        function obj = set_desired_output(obj, V_hat)
            %   Set the desired DC voltage for the converter. Used by the
            %   PID controller
            if nargin > 2
                error('myfuns:set_desired_output:TooManyInputs', ...
                    'requires no optional inputs');
            end
            obj.V_hat = V_hat;
        end
        
        function obj = set_duty_cycle(obj, D)
            %   Set the duty cycle os the switching MOSFET
            
            if nargin > 2
                error('myfuns:set_duty_cycle:TooManyInputs', ...
                    'requires no optional inputs');
            end
            obj.D = D;
        end
        
        function gain = get_gain(obj)
            %   Returns the gain of the converter
            gain = obj.get_loss_factor()*(-obj.VD/obj.Vg + 1/(1-obj.D));
        end
        
        %% operator Overloadings:
        function cascated = mtimes(obj1, obj2)
            %   Returns an cascated converter given two converters
            cascated = 0;
        end
    end
    
    
    %% Private Methods:
    methods (Access = private)
        function loss_factor = get_loss_factor(obj)
            %   Returns the loss factor of the converter
            loss_factor = 1/(1 + (obj.RL + obj.D*obj.Ron + (1-obj.D)*obj.RD)/(obj.R*(1-obj.D)^2));
        end
    end
end

