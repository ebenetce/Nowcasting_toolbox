classdef (Abstract) BasePar
    
    properties
        % common
        startyear  (1,1) double = 2005;       % starting year for estimation
        startmonth (1,1) double{mustBeMember(startmonth, 1:12)} = 1;         % starting month for estimation
    end
        
end