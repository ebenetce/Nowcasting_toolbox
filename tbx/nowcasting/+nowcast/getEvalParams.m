function Eval = getEvalParams(nvp)

arguments
    nvp.?nowcast.settings.Eval
end

args = namedargs2cell(nvp);
Eval = nowcast.settings.Eval(args{:});

end