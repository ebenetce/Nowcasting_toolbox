function Loop = getLoopParams(nvp)

arguments
    nvp.?nowcast.settings.Loop
end

args = namedargs2cell(nvp);
Loop = nowcast.settings.Loop(args{:});

end