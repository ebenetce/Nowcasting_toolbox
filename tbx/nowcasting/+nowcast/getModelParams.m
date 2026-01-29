function par = getModelParams(modelType, varargin)

arguments
    modelType (1,1) string {mustBeMember(modelType, ["DFM", "BVAR", "BEQ"])}
end

arguments (Repeating)
    varargin 
end


switch modelType
    case 'DFM'
        par = nowcast.settings.DFMPar(varargin{:});
    case 'BVAR'
        par = nowcast.settings.BVARPar(varargin{:});
    case 'BEQ'
        par = nowcast.settings.BEQPar(varargin{:});
end