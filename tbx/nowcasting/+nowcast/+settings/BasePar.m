classdef (Abstract) BasePar < nowcast.settings.NowcastObj
    % BASEPAR common parameters for all model types

    properties
        startyear  (1,1) double                                  % starting year for estimation
        startmonth (1,1) double{mustBeMember(startmonth, 1:12)} = 1; % starting month for estimation

        p (1,1) double
        r (1,1) double
        block_factors (1,1) double
        Dum  % dates of the dummies (year, month). Format should be a k x 2 matrix with k = number of dummies (each dummy on a row) and year / month in columns.
    end

    methods

        function obj = BasePar(nvp)
            arguments
                nvp.p (1,1) double = 4;                  % number of lags
                nvp.r (1,1) double = 5;                  % number of factors
                nvp.startyear  (1,1) double = 2005;
                nvp.startmonth (1,1) double{mustBeMember(nvp.startmonth, 1:12)} = 1;
                nvp.block_factors (1,1) double = 0;      % switch to include block factors
                nvp.Dum        (:,2) double = [2020,3; 2020,6; 2020,9];
            end

            obj.p = nvp.p;
            obj.r = nvp.r;
            obj.startyear = nvp.startyear;
            obj.startmonth = nvp.startmonth;
            obj.block_factors = nvp.block_factors;
            obj.Dum = nvp.Dum;

        end

        function s = toStruct(obj)

            warning off
            s = struct(obj);
            warning on

        end

    end
end