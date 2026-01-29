classdef DFMPar < nowcast.settings.BasePar
    % Model specifications DFM
    properties
        p (1,1) double
        r (1,1) double
        idio (1,1) logical
        thresh (1,1) double
        max_iter (1,1) double
        block_factors (1,1) double
    end

    methods

        function obj = DFMPar(nvp)
            % Constructor for DFMPar class
            %
            % This function initializes the properties of a DFM Parameter object.
            %
            % Inputs:
            %   nvp.p = (1,1) double: number of lags
            %   nvp.r = (1,1) double: number of factors
            %   nvp.idio = (1,1) double: idiosyncratic component specification. 0 = iid, 1 = AR(1).
            %   nvp.thresh = (1,1) double: threshold for convergence of EM algorithm
            %   nvp.max_iter = (1,1) double: number of iterations of EM algorithm
            %   nvp.block_factors = (1,1) double: switch to include block factors. NB: if included, will be one factor per block (on top of global factors). Can be changed in code.
            %
            % Outputs:
            %   obj - An instance of the DFMPar class with properties initialized based on the input arguments.

            arguments
                nvp.p (1,1) double = 4;                  % number of lags
                nvp.r (1,1) double = 5;                  % number of factors
                nvp.idio (1,1) logical = true;           % idiosyncratic component specification. 0 = iid, 1 = AR(1).
                nvp.thresh (1,1) double = 1e-4;          % threshold for convergence of EM algorithm
                nvp.max_iter (1,1) double = 100;         % number of iterations of EM algorithm
                nvp.block_factors (1,1) double = 0;      % switch to include block factors
            end            

            obj.p = nvp.p;
            obj.r = nvp.r;
            obj.idio = nvp.idio;
            obj.thresh = nvp.thresh;
            obj.max_iter = nvp.max_iter;
            obj.block_factors = nvp.block_factors;           

        end

    end % methods

end