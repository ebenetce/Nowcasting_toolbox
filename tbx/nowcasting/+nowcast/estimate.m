function er = estimate(settings,flags)

%Consider name-value pairing
arguments
    settings (1,1) NowcastConfig
 
    flags.mon_freq (1,1) string = "Monthly";
    flags.quar_freq (1,1) string = "Quarterly";
    flags.blocks_sheet (1,1) string = "blocks";
    flags.monthsAhead double = 6;
end

country.name = settings.CountryName;
country.model = settings.CountryModel;

Eval = settings.Eval;
Par = settings.Par;
MAE = settings.MAE;
Loop = settings.Loop;

if settings.do_eval == 0
    date_today = [year(datetime("today")),month(datetime("today"))]; % today's date
elseif settings.do_eval == 1
    date_today = [Eval.data_update_lastyear,Eval.data_update_lastmonth]; % date of the data "freeze" for out-of-sample evaluation
end

% Prepare file names
excel_datafile = strcat('data_',settings.CountryName); % Excel file containing data (if users use exceldata =1)
excel_outputfile = strcat('./tbx/nowcastingTemplateData/',settings.CountryName,'_tracking.xlsx'); % Excel file containing tracking and news decomposition
[Par,xest,t_m,groups,nameseries,blocks,groups_name,fullnames,datet,Loop] = ...
        common_load_data(excel_datafile,flags.mon_freq,flags.quar_freq,flags.blocks_sheet,Par,flags.monthsAhead,settings.do_loop,date_today,Loop);

% Subset data if required by user
if settings.do_subset == 1

    % Saving initial number of variables
    nM_init = Par.nM; 
    nQ_init = Par.nQ; 

    % Adjusting data
    xest = xest(:,[settings.var_keep,end]);       
    Par.nM = sum(settings.var_keep<=nM_init);
    Par.nQ = length(settings.var_keep) - Par.nM + 1;

    % Adjusting other parameters
    Par.blocks = Par.blocks([settings.var_keep,end]',:);
    groups = groups([settings.var_keep,end]);
    fullnames = fullnames([settings.var_keep,end]);
    ID_groups = unique(groups(:));
    groups_name = groups_name(ID_groups);

    % Adjust transformations (for bridge equations)
    var_keep_m = settings.var_keep(settings.var_keep<=nM_init); % monthly variables
    Par.trf.transf_m = Par.trf.transf_m(var_keep_m);
    var_keep_q = settings.var_keep(settings.var_keep>nM_init); % quarterly variables
    var_keep_q = [var_keep_q,(nM_init + nQ_init)];
    var_keep_q = var_keep_q - nM_init;
    Par.trf.transf_q = Par.trf.transf_q(var_keep_q);

end

if settings.do_eval == 0

    % ---------------------------------------------------------------------
    % Compute heatmap of input variables
    % NB: for the heatmap we consider  data before Covid correction
    heatmap = common_heatmap(xest,Par,groups,groups_name,fullnames);

    % Save initial number of variables
    Par.nM_init = Par.nM;

    % Correct for Covid period and NaN in the estimation sample
    [xest_out,nM_out,blocks_out,r_out,groups_out,groups_name_out,nameseries_out,fullnames_out,transf_m_out,transf_q_out] = ...
        common_NaN_Covid_correct(xest,datet,settings.do_Covid,Par.nM,Par.blocks,Par.r,groups,groups_name,nameseries,fullnames,Par.trf.transf_m,Par.trf.transf_q);

    % Adjust parameters post-correction
    Par.nM = nM_out;
    Par.nQ = size(xest_out,2) - Par.nM;
    Par.blocks = blocks_out;
    Par.r = r_out;
    Par.trf.transf_m = transf_m_out;
    Par.trf.transf_q = transf_q_out;
    groups = groups_out;
    groups_name = groups_name_out;
    nameseries = nameseries_out;
    fullnames = fullnames_out;

    % Prepare the estimation
    warning('off','all');
    datet_in = datet;

    % Run the estimation
    switch settings.countryModel
        case 'DFM'
            Res = DFM_estimate(xest_out,Par);
        case 'BEQ'
            Res = BEQ_estimate(xest_out,Par,datet_in,nameseries,1,[]);
        case 'BVAR'
            Res = BVAR_estimate(xest_out,Par,datet);
    end

    % Adjust results
    Res.groups = groups;
    Res.series = nameseries;
    Res.name_descriptor = fullnames;
    GDP_track = [datet Res.X_sm(:,end)];

    % Computes news relative to nowcast and forecast in 'newsfile'
    newsfile = 'cur_nowcast.mat'; % compare news relative to this run
    namesave = strcat('sav_',date); % current date
    outputfolder = strcat('.');
    rootfolder = cd;

    switch settings.countryModel
        case 'DFM'
            [news_results,news_results_fcst,table_now,table_fcst,prev_news] = ...
                DFM_News_Mainfile(outputfolder,newsfile,groups_name,xest_out,Res,Par,namesave,datet,nameseries,country.model);
        case 'BEQ'
            [news_results,news_results_fcst,prev_news] = ...
                BEQ_News_Mainfile(outputfolder,newsfile,groups_name,xest_out,Res,Par,namesave,datet,nameseries,country.model);

            % These are not produced in BEQ; make them explicit empties
            table_now  = [];
            table_fcst = [];

        case 'BVAR'
            [news_results,news_results_fcst,table_now,table_fcst,prev_news] = ...
                BVAR_News_Mainfile(outputfolder,newsfile,groups_name,xest_out,Res,Par,namesave,datet,nameseries,country.model);
    end

    if settings.do_range == 1 % Calculates range of nowcast if required by user

        [range] = common_range(xest_out,Par,datet,groups_name,groups,country,nameseries);
    elseif settings.do_range == 0
        range = [];
    end

    %OUTPUT
    MAE = common_mae(xest,Par,t_m,flags.monthsAhead,datet,settings.do_Covid,country,MAE,settings.do_mae,nameseries);

    common_save_results;

    disp ('Section 8: Results saved');

elseif settings.do_eval == 1

    % Run the evaluation (the script also produces Excel files)
    warning('off','all');
    [Loop,Eval] = common_eval_models(settings.do_loop,Loop,Eval,xest,Par,t_m,flags.monthsAhead,country,datet,settings.do_Covid,groups);

    % Ensure all other outputs exist in eval mode
    MAE = [];
    news_results = [];
    range = [];
    news_results_fcst = [];
    table_now = [];
    table_fcst = [];
    prev_news = [];
    heatmap = [];
end

% Bundle in a class
er = nowcast.NowcastResults(MAE, Loop, Eval, news_results, range, news_results_fcst, table_now, table_fcst, prev_news, heatmap);

end
