classdef Loop
    % Additional inputs for model evaluation
    % NB: if do_eval=1

    properties
        % Additional inputs for loop across models
        n_iter          % number of random models to be tested
        name_loop       % name for the loop
        min_startyear   % minimum start year of estimation
        max_startyear   % maximum start year of estimation
        startmonth      % start month of estimation (same for any start year)
        min_var         % minimum number of variables
        max_var         % maximum number of variables
        min_p           % DFM: minimum number of lags
        max_p           % DFM: maximum number of lags (NB: p>5 won't work)
        min_r           % DFM: minimum number of factors
        max_r           % DFM: maximum number of factors
        min_lagM        % BEQ: minimum number of lags (in quarterly terms) for monthly regressors
        max_lagM        % BEQ: maximum number of lags (in quarterly terms) for monthly regressors
        min_lagQ        % BEQ: minimum number of lags for quarterly regressors
        max_lagQ        % BEQ: maximum number of lags for quarterly regressors
        min_lagY        % BEQ: minimum number of lags for the endogenous variable
        max_lagY        % BEQ: maximum number of lags for the endogenous variable
        min_bvar_lags   % BVAR: minimum number of lags
        max_bvar_lags   % BVAR: maximum number of lags
        do_random       % switch on whether to randomize models in the loop
        % 0 = different runs of loop will select same models (can be useful to test the effect of one change on same set of models, e.g. Covid corrections)
        % 1 (default) = different runs of the loop will select different models
        % excel_loopfile = strcat('./',countryName,'_',countryModel,'_loop_',name_loop,'.xlsx'); % Excel file for loop over random models
        list_name (1,1) string % Name of excel with list of models (has to be located in folder 'eval/country.name/')
        name_customloop % Name of the loop
        alter_covid     % Switch to 1 to alter between Covid corrections (0 tests the list of models)
    end

    methods
        function obj = Loop(nvp)
            arguments
                % Additional inputs for loop across models
                nvp.n_iter (1,1) double = 10                      % number of random models to be tested
                nvp.name_loop (1,1) string = "b1"                 % name for the loop
                nvp.min_startyear (1,1) double = 2008             % minimum start year of estimation
                nvp.max_startyear (1,1) double = 2014             % maximum start year of estimation
                nvp.startmonth (1,1) double {mustBeMember(nvp.startmonth, 1:12)} = 1 % start month of estimation (same for any start year)
                nvp.min_var (1,1) double = 5                      % minimum number of variables
                nvp.max_var (1,1) double = 10                     % maximum number of variables
                nvp.min_p (1,1) double = 1                        % DFM: minimum number of lags
                nvp.max_p (1,1) double = 4                        % DFM: maximum number of lags (NB: p>5 won't work)
                nvp.min_r (1,1) double = 2                        % DFM: minimum number of factors
                nvp.max_r (1,1) double = 6                        % DFM: maximum number of factors
                nvp.min_lagM (1,1) double = 1                     % BEQ: minimum number of lags (in quarterly terms) for monthly regressors
                nvp.max_lagM (1,1) double = 4                     % BEQ: maximum number of lags (in quarterly terms) for monthly regressors
                nvp.min_lagQ (1,1) double = 1                     % BEQ: minimum number of lags for quarterly regressors
                nvp.max_lagQ (1,1) double = 4                     % BEQ: maximum number of lags for quarterly regressors
                nvp.min_lagY (1,1) double = 1                     % BEQ: minimum number of lags for the endogenous variable
                nvp.max_lagY (1,1) double = 2                     % BEQ: maximum number of lags for the endogenous variable
                nvp.min_bvar_lags (1,1) double = 2                % BVAR: minimum number of lags
                nvp.max_bvar_lags (1,1) double = 4               % BVAR: maximum number of lags
                nvp.do_random (1,1) logical = true                 % switch on whether to randomize models in the loop
                % 0 = different runs of loop will select same models (can be useful to test the effect of one change on same set of models, e.g. Covid corrections)
                % 1 (default) = different runs of the loop will select different models

                % nvp.excel_loopfile (1,1) double = strcat('./',countryName,'_',countryModel,'_loop_',nvp.name_loop,'.xlsx'); % Excel file for loop over random models
                nvp.list_name (1,1) string = "Eval_list.xlsx"      % Name of excel with list of models (has to be located in folder 'eval/country.name/')
                nvp.name_customloop (1,1) string = "customloop";   % Name of the loop
                nvp.alter_covid (1,1) double = 1;                  % Switch to 1 to alter between Covid corrections (0 tests the list of models)
            end

            for f = fields(nvp)'
                obj.(f{1}) = nvp.(f{1});
            end

        end
    end
    
end