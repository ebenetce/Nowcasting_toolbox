classdef TestNowcastMain < matlab.unittest.TestCase
    % TestNowcastMain
    %
    % Unit tests for:
    %   [Loop, Eval] = nowcast_main(do_eval, do_loop, do_range, do_mae, do_subset, model)
    %
    % do_eval   ∈ {0,1}
    % do_loop   ∈ {0,1,2}
    % do_range  ∈ {0,1}
    % do_mae    ∈ {0,1}
    % do_subset ∈ {0,1}
    % model     ∈ {'DFM','BVAR','BEQ'}
    
    properties (TestParameter)
        do_eval   = num2cell(0:1);
        do_loop   = num2cell(0:2);
        do_range  = num2cell(0:1);
        do_mae    = num2cell(0:1);
        do_subset = num2cell(0:1);
        model     = {'DFM','BVAR','BEQ'};
    end
    
    methods (Test, ParameterCombination = 'exhaustive')
        function testAllValidConfigsReturnStructs(testCase, ...
                do_eval, do_loop, do_range, do_mae, do_subset, model)
            
            [Loop, Eval] = nowcast_main( ...
                do_eval, do_loop, do_range, do_mae, do_subset, model);
            
            % Verify Loop
            testCase.verifyStructWithCharFields(Loop, 'Loop');
            
            % Verify Eval
            testCase.verifyStructWithCharFields(Eval, 'Eval');
        end
    end
    
    methods (Test)
        function testBaselineDFMConfig(testCase)
            
            do_eval   = 1;
            do_loop   = 1;
            do_range  = 0;
            do_mae    = 0;
            do_subset = 0;
            model     = 'DFM';
            
            [Loop, Eval] = nowcast_main( ...
                do_eval, do_loop, do_range, do_mae, do_subset, model);
            
            testCase.verifyStructWithCharFields(Loop, 'Loop');
            testCase.verifyStructWithCharFields(Eval, 'Eval');
            
        end
        
        function testInvalidModelThrowsError(testCase)
            % Negative test: ensure invalid model strings are rejected.
            %
            % This assumes nowcast_main throws an error with identifier
            % 'nowcast_main:InvalidModel'. Adjust the identifier as needed.
            
            do_eval   = 1;
            do_loop   = 0;
            do_range  = 0;
            do_mae    = 0;
            do_subset = 0;
            badModel  = 'XYZ';
            
            testCase.verifyError( ...
                @() nowcast_main(do_eval, do_loop, do_range, do_mae, do_subset, badModel), ...
                'nowcast_main:InvalidModel');
        end
    end
    
    methods (Access = private)
        function verifyStructWithCharFields(testCase, s, structName)
            
            testCase.verifyClass(s, 'struct', ...
                sprintf('%s must be a struct.', structName));
            
            fns = fieldnames(s);
            testCase.verifyNotEmpty(fns, ...
                sprintf('%s must have at least one field.', structName));
            
            for i = 1:numel(fns)
                v = s.(fns{i});
                isCharLike = ischar(v) || isstring(v);
                testCase.verifyTrue(isCharLike, ...
                    sprintf('Field %s.%s must be char or string.', ...
                    structName, fns{i}));
            end
        end
    end
end
