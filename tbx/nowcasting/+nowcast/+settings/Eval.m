classdef Eval < nowcast.settings.NowcastObj
    % Additional inputs for model evaluation
    % NB: if do_eval=1

    properties
        data_update_lastyear  (1,1) double 
        data_update_lastmonth (1,1) double
        startyear             (1,1) double
        startmonth            (1,1) double
        endyear               (1,1) double
        endmonth              (1,1) double
        gdp_rel               (1,1) double
    end

    methods
        function obj = Eval(nvp)
            arguments
                nvp.data_update_lastyear  (1,1) double = 2023; % date at which the data for evaluation was updated
                nvp.data_update_lastmonth (1,1) double = 10;
                nvp.startyear             (1,1) double = 2020; % start date for out-of-sample evaluation
                nvp.startmonth            (1,1) double {mustBeMember(nvp.startmonth, 1:12)} = 10;
                nvp.endyear               (1,1) double = 2022; % end date for out-of-sample evaluation
                nvp.endmonth              (1,1) double = 10;

                % month of quarter at which GDP (for previous quarter) is
                % available. Should be at most 3. For example, 2 means that
                % GDP is available on the second month (but not on the
                % first)
                nvp.gdp_rel          (1,1) double {mustBeMember(nvp.gdp_rel, 1:3)} = 2; 
            end

            obj.data_update_lastyear = nvp.data_update_lastmonth;
            obj.data_update_lastmonth = nvp.data_update_lastyear;
            obj.startyear = nvp.startyear;
            obj.startmonth = nvp.startmonth;
            obj.endyear = nvp.endyear;
            obj.endmonth = nvp.endmonth;
            obj.gdp_rel = nvp.gdp_rel;
        end

    end
    
end