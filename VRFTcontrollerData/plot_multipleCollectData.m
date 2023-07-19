%% Plota multiplos dados de experimento
close all
clear all


%manualmente
used_collectDatabases={
    '008_up100BL_14'
    '008_up100BL_18'
    '008_up100BL_22'
    };

used_collectDatabases={
    '08_up100BL_14'
    '08_up100BL_18'
    '08_up100BL_22'
    };

% used_collectDatabases={
%     '02_down100_14'
%     '02_down50_18'
%     '02_down50_22'
%     };

for i=1:length(used_collectDatabases)
        collectDataAdd_filename=cell2mat(used_collectDatabases(i));
        load(collectDataAdd_filename);
        figure(12)
        
        tini=1;
        tfim=(square_period/2-1)/DT;
        S=stepinfo(rotspeed_sOp(tini:tfim),Time(tini:tfim));
        ts{i}=S.SettlingTime-Time(tini);
        DCgain{i}=rotspeed_sOp(tfim)/(heta_out_sOp(tfim)*180/pi);
%         DCgain{i}=(max(rotspeed_sOp)-min(rotspeed_sOp))/(max(heta_out_sOp*180/pi)-min(heta_out_sOp*180/pi));
        add_collectData_plot
    end


figure(12)
subplot(3,1,1)
legend(used_collectDatabases(1:end), 'Interpreter', 'none')
ylabel('velocidade de rotação')

subplot(3,1,2)
legend(used_collectDatabases(1:end), 'Interpreter', 'none')
ylabel('pitch')
subplot(3,1,3)
legend(used_collectDatabases(1:end), 'Interpreter', 'none')
ylabel('RPM/pitch')

(DCgain)
(ts)



