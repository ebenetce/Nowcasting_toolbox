classdef tEval < matlab.unittest.TestCase
    methods (Test)
        function tConstructor(tc)
            e = nowcasting.settings.Eval();
            tc.verifyClass(e, 'nowcasting.settings.Eval');

            e = nowcasting.settings.Eval("gdp_rel",1);
            tc.verifyEqual(e.Gdp_rel, 1)
        end
    end
end