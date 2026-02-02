classdef tDFMWorkflow < matlab.unittest.TestCase
    properties
        Folder
        Data 
    end

    methods (TestClassSetup)
        function setupWorkingFolder(tc)
            import matlab.unittest.fixtures.TemporaryFolderFixture
            fixture = tc.applyFixture(TemporaryFolderFixture);
            tc.Folder = fixture.Folder;
            tc.Data = fullfile(fileparts(nowcast.root), 'dataset', 'data_Example1.xlsx');
        end
    end
    methods (Test)
        function tnoLoopNoEval(tc)
            ms = NowcastConfig('Example1', 'DFM', do_loop=0, do_eval = 0);
            er = nowcast.estimate(ms, excel_datafile=tc.Data, outputfolder=fullfile(tc.Folder, 'output'));
            tc.verifyTrue(isfile(fullfile(tc.Folder, 'output', 'Example1', 'cur_nowcast.mat')))

            er = nowcast.estimate(ms, excel_datafile=tc.Data, outputfolder=fullfile(tc.Folder, 'output'));
            tc.verifyTrue(isfile(fullfile(tc.Folder, 'output', 'Example1', 'old_nowcast.mat')))
        end

        function tLoop1Eval(tc)
            ms = NowcastConfig('Example1', 'DFM', do_loop=1, do_eval = 1);
            er = nowcast.estimate(ms, excel_datafile=tc.Data, outputfolder=fullfile(tc.Folder, 'output'));
        end

        function tLoop2Eval(tc)
            ms = NowcastConfig('Example1', 'DFM', do_loop=2, do_eval = 1);
            er = nowcast.estimate(ms, excel_datafile=tc.Data, outputfolder=fullfile(tc.Folder, 'output'));
        end
    end
end