%-----------------------------------------------------------------------%
% Propaga la entrada a lo largo de la red
%-----------------------------------------------------------------------%
function redPropagada = propagarAdelante(    red,    entrada,    funcActivacion,    beta)

    for j=1:(red.cantidadCapasOcultas + 1)

        red.vectorEntrada{j} = [entrada -1] * red.pesos{j};

        entrada = funcionActivacion(red.vectorEntrada{j}, beta, funcActivacion);
    end

    red.salida = entrada;

    redPropagada = red;
