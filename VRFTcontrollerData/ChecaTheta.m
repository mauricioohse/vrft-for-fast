    

maxThetaDiff=max(diff(heta_out(tini_iae:tfim_iae))/DT)*180/pi
    if maxThetaDiff>8
        cprintf('red','ALERTA: M�XIMO DE PITCH RATE SUPERADO')
    end