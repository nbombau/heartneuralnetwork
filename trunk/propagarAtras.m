%-----------------------------------------------------------------------%
% Realiza el backpropagation sobre la red, y actualiza los pesos de la
% misma
%-----------------------------------------------------------------------%
function redActualizada = propagarAtras(    red, patron,     salidaObtenida,     funcActivacion,     beta,     eta,    momentum)

    capas = red.cantidadUnidadesOcultas;
    pesos = red.pesos;
    cantCapas = red.cantidadCapasOcultas;
    entrada = patron.entradas;
    
    % Delta de la salida
    red.delta{red.cantidadCapasOcultas + 1} = derivadaFuncionActivacion(red.vectorEntrada{red.cantidadCapasOcultas + 1}, beta, funcActivacion) * (patron.salida - salidaObtenida)';
    
    red.cantidadUnidadesOcultas = [ red.cantidadUnidadesOcultas red.cantidadSalidas];

    % Delta de las capas ocultas
    while cantCapas > 0
        

        aux = red.pesos{cantCapas+1};
        cantAux = size(aux);
        aux = aux(1:(cantAux(1)-1),:);

        red.delta{cantCapas} = derivadaFuncionActivacion(red.vectorEntrada{cantCapas}, beta, funcActivacion)' .* (aux * red.delta{cantCapas + 1});
        
        cantCapas = cantCapas - 1;
    end
    
    cantCapas = red.cantidadCapasOcultas;
    entrada = [entrada -1];

    % Actualizacion de pesos
    for i=1:cantCapas,
        aux = (eta * red.delta{i} * entrada)';
        red.pesos{i} = red.pesos{i} + aux + momentum * red.variacionPesos{i};
        red.variacionPesos{i} = aux;
        entrada = [funcionActivacion(red.vectorEntrada{i}, beta, funcActivacion) -1];
    end
    
    red.cantidadUnidadesOcultas = red.cantidadUnidadesOcultas(1:(length(red.cantidadUnidadesOcultas)-1));
    
    redActualizada = red;
end