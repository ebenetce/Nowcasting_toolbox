classdef tEval < matlab.unittest.TestCase
    methods (Test)
        function tConstructor(tc)
            e = nowcast.settings.Eval();
            tc.verifyClass(e, 'nowcast.settings.Eval');

            e = nowcast.settings.Eval("gdp_rel",1);
            tc.verifyEqual(e.gdp_rel, 1)
        end
    end
end