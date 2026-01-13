
classdef NowcastConfig
    %NOWCASTCONFIG Simple container for configuration structs produced by modelSettings.

    properties (SetAccess = immutable)
        settings
        Par
        Loop
        MAE
        Eval
    end

    methods
        function obj = NowcastConfig(settings, Par, Loop, MAE, Eval)
            obj.settings = settings;
            obj.Par      = Par;
            obj.Loop     = Loop;
            obj.MAE      = MAE;
            obj.Eval     = Eval;
        end
    end
end
