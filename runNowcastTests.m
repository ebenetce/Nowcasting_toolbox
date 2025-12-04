function runNowcastTests
% runNowcastTests
% Convenience script to run TestNowcastMain.

    import matlab.unittest.TestSuite

    suite   = TestSuite.fromClass(?TestNowcastMain);
    results = run(suite);
    
    disp(table(results));
end
