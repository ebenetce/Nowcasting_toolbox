
function er = model_Estimation(ms, varargin)
%MODELESTIMATIONOBJ Thin wrapper that returns one NowcastResults object.
%   Calls your existing modelEstimation(...) unchanged and bundles outputs.
%
%   ms must be a NowcastConfig created by modelSettingsObj(...).
%
%   Usage:
%     ms = modelSettingsObj('Example1','DFM', do_loop=2);
%     er = modelEstimationObj(ms);  % defaults
%     er = modelEstimationObj(ms, mon_freq='Monthly', monthsAhead=6);

    if ~isa(ms, 'NowcastConfig')
        error('modelEstimationObj:ArgType', ...
              'First argument must be a NowcastConfig (from modelSettingsObj).');
    end

    % Forward to your original function with name-value flags untouched
    [MAE, Loop, Eval, news_results, range, news_results_fcst, table_now, table_fcst, prev_news, heatmap] = ...
        modelEstimation(ms.settings, ms.Par, ms.MAE, ms.Loop, ms.Eval, varargin{:});

    % Bundle in a class
    er = NowcastResults(MAE, Loop, Eval, news_results, range, news_results_fcst, table_now, table_fcst, prev_news, heatmap);
end
