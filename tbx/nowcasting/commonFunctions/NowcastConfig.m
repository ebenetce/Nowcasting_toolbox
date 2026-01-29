
classdef NowcastConfig
    %NOWCASTCONFIG Simple container for configuration structs produced by modelSettings.

    properties (SetAccess = private)
        CountryName  (1,1) string
        CountryModel (1,1) string 
        do_eval   (1,1) logical = false
        do_loop   (1,1) double {mustBeMember(do_loop,[0 1 2])}  = 1 
        do_range  (1,1) logical = false
        do_mae    (1,1) logical = false
        do_subset (1,1) logical = false
        do_covid  (1,1) double {mustBeMember(do_covid,[0 1 2 3 4])} = 0
        var_keep  (1,:) double = []
    end

    properties
        Par  nowcast.settings.BasePar = nowcast.settings.DFMPar.empty()
        Loop nowcast.settings.Loop = nowcast.settings.Loop.empty() 
        MAE  nowcast.settings.MAE = nowcast.settings.MAE.empty()
        Eval nowcast.settings.Eval = nowcast.settings.Eval.empty()
    end

    methods
        function obj = NowcastConfig(countryName, countryModel, flags, overrides)

            %Consider name-value pairing
            arguments
                countryName  (1,1) string
                countryModel (1,1) string {mustBeMember(countryModel, ["DFM", "BEQ", "BVAR"])} = "DFM"

                flags.do_eval   (1,1) logical = false
                flags.do_loop   (1,1) double {mustBeMember(flags.do_loop, [0 1 2])} = 1
                flags.do_range  (1,1) double {mustBeMember(flags.do_range, [0 1])} = 0
                flags.do_mae    (1,1) logical = false
                flags.do_subset (1,1) logical = false
                flags.var_keep  (1,:) double = [1   3   5   7   9  10  11  13  14  15  19  21  22  24  25  26  27  28  30  31]
                flags.do_Covid  (1,1) double {mustBeMember(flags.do_Covid,[0 1 2 3 4])} = 0

                overrides.Par  nowcast.settings.BasePar = nowcast.getModelParams(countryModel)
                overrides.MAE  nowcast.settings.MAE  = nowcast.getMAEParams()
                overrides.Eval nowcast.settings.Eval = nowcast.getEvalParams()
                overrides.Loop nowcast.settings.Loop = nowcast.getLoopParams( list_name = "Eval_list_" + countryModel + ".xlsx" )
            end
            %Matlab version compatibility
            if isMATLABReleaseOlderThan('R2022a')
                error('Running EXT-Now requires Matlab version R2022a or higher.')
            end

            %Struct for maintaining model settings
            % settings = createSettings(flags,countryName,countryModel);
            obj.CountryName = countryName;
            obj.CountryModel = countryModel;

            obj.do_eval   = flags.do_eval;
            obj.do_loop   = flags.do_loop;
            obj.do_range  = flags.do_range;
            obj.do_mae    = flags.do_mae;
            % 0 = do nothing
            % 1 = add dummies (one for June 2020 and one for Sept. 2020)
            % 2 = put to NaN (from Feb. 2020 to Sep. 2020 included)
            % 3 = outlier-correction (with outliers replaces by NaN)
            % 4 = add dummies (one for Mar. 2020 and one for June 2020)
            obj.do_subset = flags.do_subset;
            obj.do_covid  = flags.do_Covid;

            %Assign do_eval=1 if do_loop is selected
            if flags.do_loop > 0
                obj.do_eval = true;
            end

            if obj.do_subset
                obj.var_keep = flags.var_keep;
            end

            %Model specifications
            obj.Par = overrides.Par;
            obj.Loop = overrides.Loop;
            obj.MAE = overrides.MAE;

            % Additional inputs for model evaluation
            if obj.do_eval
                obj.Eval = overrides.Eval;
            end

            % Update name of loop if do_loop == 2
            if obj.do_loop == 2
                obj.Loop.name_loop = obj.Loop.name_customloop;
            end

        end % Constructor

    end % methods

end % Nowcasting
