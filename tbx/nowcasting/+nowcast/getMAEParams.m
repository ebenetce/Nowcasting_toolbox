function obj = getMAEParams(nvp)

arguments
    nvp.Bac_mae_1st = 0.15;     % MAE, backcasting, 1st month of quarter
    nvp.Bac_mae_2nd = 0.15;     % MAE, backcasting, 2nd month of quarter
    nvp.Bac_mae_3rd = 0.15;     % MAE, backcasting, 3rd month of quarter
    nvp.Bac_fda_1st = 0.88;     % FDA, backcasting, 1st month of quarter
    nvp.Bac_fda_2nd = 0.88;     % FDA, backcasting, 2nd month of quarter
    nvp.Bac_fda_3rd = 0.88;     % FDA, backcasting, 3rd month of quarter

    nvp.Now_mae_1st = 0.24;     % MAE, nowcasting, 1st month of quarter
    nvp.Now_mae_2nd = 0.24;     % MAE, nowcasting, 2nd month of quarter
    nvp.Now_mae_3rd = 0.21;     % MAE, nowcasting, 3rd month of quarter
    nvp.Now_fda_1st = 0.73;     % FDA, nowcasting, 1st month of quarter
    nvp.Now_fda_2nd = 0.85;     % FDA, nowcasting, 2nd month of quarter
    nvp.Now_fda_3rd = 0.88;     % FDA, nowcasting, 3rd month of quarter

    nvp.For_mae_1st = 0.48;     % MAE, forecasting, 1st month of quarter
    nvp.For_mae_2nd = 0.30;     % MAE, forecasting, 2nd month of quarter
    nvp.For_mae_3rd = 0.29;     % MAE, forecasting, 3rd month of quarter
    nvp.For_fda_1st = 0.56;     % FDA, forecasting, 1st month of quarter
    nvp.For_fda_2nd = 0.68;     % FDA, forecasting, 2nd month of quarter
    nvp.For_fda_3rd = 0.70;     % FDA, forecasting, 3rd month of quarter
end

obj = nowcast.settings.MAE(nvp);

end