classdef BEQPar < nowcast.settings.BasePar
    % Model specifications BEQ
    properties
        lagM % number of lags for monthly regressor(s) (in quarterly terms). 0 = only contemporaneous.
        lagQ % number of lags for quarterly regressor(s) (in quarterly terms). 0 = only contemporaneous.
        lagY % number of lags for the endogenous variable (in quarterly terms). 0 = no lags of endogenous.
        type % type of interpolation (see BEQ_estimate for details)
        Dum  % dates of the dummies (year, month). Format should be a k x 2 matrix with k = number of dummies (each dummy on a row) and year / month in columns.
    end

    methods

        function obj = BEQPar(nvp)
            % Constructor for BEQPar class
            %
            % This function initializes the properties of a BEQ Parameter object.
            %
            % Inputs:
            %   nvp.lagM - (1,1) double: number of lags for monthly regressor(s) (in quarterly terms). 0 = only contemporaneous.
            %   nvp.lagQ - (1,1) double: number of lags for quarterly regressor(s) (in quarterly terms). 0 = only contemporaneous.
            %   nvp.lagY - (1,1) double: number of lags for the endogenous variable (in quarterly terms). 0 = no lags of endogenous.
            %   nvp.type - (1,1) double: type of interpolation (see BEQ_estimate for details)
            %   nvp.Dum  - (:,2) double: dates of the dummies (year, month). Format should be a k x 2 matrix with k = number of dummies (each dummy on a row) and year / month in columns.
            %
            % Outputs:
            %   obj - An instance of the BEQPar class with properties initialized based on the input arguments.

            arguments
                nvp.lagM (1,1) double = 1;
                nvp.lagQ (1,1) double = 1;
                nvp.lagY (1,1) double = 1;
                nvp.type (1,1) double = 901;
                nvp.Dum (:,2) double = [2020,3; 2020,6; 2020,9];
            end

            obj.lagM = nvp.lagM;
            obj.lagQ = nvp.lagQ;
            obj.lagY = nvp.lagY;
            obj.type = nvp.type;
            obj.Dum = nvp.Dum;
        end

    end % methods

end