classdef MAE < nowcast.settings.NowcastObj
    % Additional input for mean absolute error
    properties
        Bac
        Now
        For
    end

    methods

        function obj = MAE(nvp)

            arguments
                nvp (1,1) struct
            end

            if ~isempty(nvp)
                for f = fields(nvp)'
                    f1 = f{1};
                    obj.(extractBefore(f1, '_')).(extractAfter(f1, '_')) = nvp.(f1);
                end
            end
        end

    end

end