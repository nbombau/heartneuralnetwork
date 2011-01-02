%---------------------------------------------------------------------%
% En funcion de la evolucion de la red, adapta valor de eta
%---------------------------------------------------------------------%
function y = etaAdaptativo( errorCuadratico, epoca, eta, ultimoDecremento, a, b, epocasEtaAdaptativo, errorAdaptacionEta )

    variacionEta = 0;
    if (length(errorCuadratico) >= 2),
        if (errorCuadratico(epoca) - errorCuadratico(epoca-1)) > 0,
            ultimoDecremento = epoca;
            if (errorCuadratico(epoca) - errorCuadratico(epoca - 1)) > -errorAdaptacionEta,
                variacionEta = -1 * b * eta;
            end
        else if ((epoca - ultimoDecremento) >= epocasEtaAdaptativo),
                 if (sum(errorCuadratico((epoca- epocasEtaAdaptativo+ 1):epoca)) >= errorAdaptacionEta),
                    variacionEta = a;
                 end
            end
        end
    end
    
    y = eta + variacionEta;

end