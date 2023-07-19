clear all
close all

% Baseline Td
baselineNames={'ganho5mwLPV_','ganho5mw_14','ganho5mw_18','ganho5mw_22'};
baselineNames={'ganho5mwLPV_','ganho5mwLPV_','ganho5mwLPV_','ganho5mwLPV_'};
windchoose={'f1422','ctrl_step_14','ctrl_step','ctrl_step_22'};


% variando Td baseline
% baselineNames={'ganho5mw_Td2o_5_30','ganho5mw_Td2o_5_30','ganho5mw_Td2o_5_15','ganho5mw_Td2o_5_15'};
% windchoose={'LPV_f1625','ctrl_step','LPV_f1625','ctrl_step'};

for i=1:length(baselineNames)
    loadNamesBaseline{i}=strcat(cell2mat(baselineNames(i)),cell2mat(windchoose(i)));
end

IAElist=zeros(1,4);
for i=1:length(baselineNames)
    clearvars -except IAElist loadNamesBaseline i
    load(cell2mat(loadNamesBaseline(i)))
    
    IAElist(i)=IAE;
end


loadNamesBaseline'
IAElist'