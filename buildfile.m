function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions test and archive.
plan = buildplan(localfunctions);

% Add the "check" task to identify code issues
plan("check") = CodeIssuesTask('tbx/nowcasting', WarningThreshold = 59);

plan("test") = TestTask(SourceFiles='tbx', TestResults = 'tests/results.html', CodeCoverageResults = 'tests/coverage.html');

% Make the "archive" task the default task in the plan
plan.DefaultTasks = "archive";

% Make the "archive" task dependent on the "check" and "test" tasks
plan("archive").Dependencies = ["check" "test"];

end

function archiveTask(~)

version = ver('nowcasting').Version;

if ~isfolder('releases')
    mkdir('releases')
end

here = fileparts(mfilename('fullpath'));
opts = matlab.addons.toolbox.ToolboxOptions(fullfile(here, "tbx"), "ea810d61-9776-4d3d-b6ca-68072d5331b6");

opts.ToolboxName = "Nowcasting Toolbox";
opts.ToolboxVersion = version;

opts.AuthorName = "Baptiste Meunier";
opts.AuthorEmail = "";
opts.AuthorCompany = "European Central Bank";

opts.Summary = "Nowcasting";
opts.Description = "Nowcasting";

opts.ToolboxMatlabPath = fullfile(here, "tbx", "nowcasting");
opts.ToolboxGettingStartedGuide = fullfile(here, "tbx","doc","GettingStarted.m");
opts.SupportedPlatforms.Win64 = true;
opts.SupportedPlatforms.Maci64 = true;
opts.SupportedPlatforms.Glnxa64 = true;
opts.SupportedPlatforms.MatlabOnline = false;

opts.MinimumMatlabRelease = "R2023a";
opts.MaximumMatlabRelease = "";

opts.OutputFile = "releases/Nowcasting.mltbx";
matlab.addons.toolbox.packageToolbox(opts);
end