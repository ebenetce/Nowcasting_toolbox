
classdef NowcastResults
    %NOWCASTRESULTS Simple container for outputs produced by modelEstimation.

    properties (SetAccess = immutable)
        MAE
        Loop
        Eval
        news_results
        range
        news_results_fcst
        table_now
        table_fcst
        prev_news
        heatmap
    end

    methods
        function obj = NowcastResults(MAE, Loop, Eval, news_results, range, news_results_fcst, table_now, table_fcst, prev_news, heatmap)
            obj.MAE               = MAE;
            obj.Loop              = Loop;
            obj.Eval              = Eval;
            obj.news_results      = news_results;
            obj.range             = range;
            obj.news_results_fcst = news_results_fcst;
            obj.table_now         = table_now;
            obj.table_fcst        = table_fcst;
            obj.prev_news         = prev_news;
            obj.heatmap           = heatmap;
        end

    end
end
