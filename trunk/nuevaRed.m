%---------------------------------------------------------------------%
% Crea una nueva red
%---------------------------------------------------------------------%
function red = nuevaRed(    cantidadEntradas,    vectorCantidadesOcultas,    cantidadSalidas,    maximoPeso,    minimoPeso)
    red.cantidadSalidas = cantidadSalidas;
    red.cantidadEntradas = cantidadEntradas;
    red.cantidadCapasOcultas = length(vectorCantidadesOcultas);
    red.cantidadUnidadesOcultas = vectorCantidadesOcultas;
    
    red.pesos{1} = nuevaMatrizAleatoria(maximoPeso, minimoPeso, cantidadEntradas + 1, vectorCantidadesOcultas(1));
    
    for i=2:red.cantidadCapasOcultas,
        red.pesos{i} = nuevaMatrizAleatoria(maximoPeso, minimoPeso, vectorCantidadesOcultas(i - 1) + 1, vectorCantidadesOcultas(i));
    end

    red.pesos{red.cantidadCapasOcultas+1} = nuevaMatrizAleatoria(maximoPeso, minimoPeso, vectorCantidadesOcultas(red.cantidadCapasOcultas) + 1, cantidadSalidas);
    
    for i=1:length(red.pesos),
        red.variacionPesos{i} = 0;
    end
end
