classdef BVARPar < nowcast.settings.BasePar
    % Model specifications BVAR
    properties
        bvar_lags          % number of lags
        bvar_thresh        % threshold for convergence
        bvar_max_iter      % number of iterations
    end

    methods
        function obj = BVARPar(nvp)
          % BVARPAR - Construct a BVAR parameter object from name-value pairs.
          %
          % This function initializes a BVAR parameter object with specified
          % tuning parameters. The parameters can be provided as a structure
          % with fields corresponding to the BVAR settings. Default values
          % are used if the fields are not specified.
          %
          % Input arguments:
          %   nvp - A struct-like input containing optional fields:
          %         .bvar_lags     (1,1) double - Number of lags (default: 5)
          %         .bvar_thresh   (1,1) double - Threshold for convergence (default: 1e-6)
          %         .bvar_max_iter (1,1) double - Maximum number of iterations (default: 200)
          %
          % Output arguments:
          %   obj - An instance of the BVARPar class with the specified tuning parameters.
          
            arguments
                nvp.bvar_lags     (1,1) double = 5;
                nvp.bvar_thresh   (1,1) double = 1e-6;
                nvp.bvar_max_iter (1,1) double = 200;
            end
            obj.bvar_lags     = nvp.bvar_lags;
            obj.bvar_thresh   = nvp.bvar_thresh;
            obj.bvar_max_iter = nvp.bvar_max_iter;
        end
    end % methods

end