
function ms = model_Settings(countryName, countryModel, varargin)

    %Calls modelSettings function
    [settings, Par, Loop, MAE, Eval] = modelSettings(countryName, countryModel, varargin{:});

    % Bundle in a class
    ms = NowcastConfig(settings, Par, Loop, MAE, Eval);
end
