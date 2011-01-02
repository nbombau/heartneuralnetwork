%---------------------------------------------------------------------%
% Obtiene patrones para entrenamiento. Permite indicar cantidad de unos y
% ceros. 
%---------------------------------------------------------------------%
function pat = patronesEntrenar(  nombreArchivo,   tamanioVentana,     limite,     desplazamiento, cantidadCeros, cantidadUnos)
    [senial valor] = textread(nombreArchivo,'%f %d');
       
    cantidadTotal = length(senial);
    sobrantes = mod(cantidadTotal, tamanioVentana);
    tamanioMaximo = cantidadTotal - sobrantes;
    
    cantidadUnosPedida = cantidadUnos;
    cantidadCerosPedida = cantidadCeros;
    cantidadUnos = 0;
    cantidadCeros = 0;
    
    senial = senial(1:tamanioMaximo);
    valor = valor(1:tamanioMaximo);

    desplazamientoAux = desplazamiento;
    i = 1;
    
    % Se obtienen 10 veces la cantidad de 1 y ceros pedida
    while (~(cantidadUnos >= (cantidadUnosPedida*10) && (cantidadCeros >= cantidadCerosPedida * 10))) && desplazamientoAux + tamanioVentana - 1 < tamanioMaximo%desplazamientoAux+tamanioVentana-1 < tamanioMaximo && i <= limite)
        patron.entradas = senial(desplazamientoAux:desplazamientoAux+tamanioVentana-1)' + 6.429316;%todo: normalizar con multiplicacion
        patron.salida = cantidadUnosConsecutivos(valor(desplazamientoAux:desplazamientoAux+tamanioVentana));
        
        if patron.salida == 1 && cantidadUnos < cantidadUnosPedida* 10
            patronesUnos(cantidadUnos+1) = patron;            
            cantidadUnos = cantidadUnos + 1;
        end
        if patron.salida == -1 && cantidadCeros < cantidadCerosPedida * 10
            patronesCeros(cantidadCeros + 1) = patron;
            cantidadCeros = cantidadCeros + 1;
        end

        desplazamientoAux = desplazamientoAux + floor(tamanioVentana/2);
    end
    cantidadUnos
    cantidadCeros
    cantidadPatronesUnos = length(patronesUnos);
    cantidadPatronesCeros = length(patronesCeros)
    
    % Se aleatorizan los patrones y se selecciona la cantidad pedida de cada tipo 
    %    permutacionUnos = randperm(cantidadPatronesUnos);
    %    permutacionCeros = randperm(cantidadPatronesCeros);

    % Conjunto de entrenamiento seleccionado por el grupo. En caso de
    % desear conjuntos random de entrenamiento, comentar las 2 lineas de
    % abajo, y descomentar las 2 de arriba
    
    permutacionUnos = [45 397 144 189 334 127 458 436 193 401 292 228 364 299  48 226 483 109 326 426 373 362 203 270 156 320 493 148 166 367 7 315 244 196 415 187 478 221 456 55 185 181 356 316 195 78 347 268 419 443 337];
    permutacionCeros = [392 143 275 355 305 67 369 120 102 318 50 497 146 330 52 170 452 432 240 423 243 235 17 183 75 402 142 304 12 371 224 238 149 403 207 30 394 478 158 90 247 266 18 415 109 451 310 477 91 23 38];
    
    patronesUnos = patronesUnos(permutacionUnos);
    patronesCeros = patronesCeros(permutacionCeros);
    
    cantidadUnos = 0;
    cantidadCeros = 0;
    i = 1;
    for i= 1:(cantidadUnosPedida + cantidadCerosPedida)
        if cantidadUnos < cantidadUnosPedida 
           pat(i) = patronesUnos(cantidadUnos + 1); 
           cantidadUnos = cantidadUnos + 1;
        elseif cantidadCeros < cantidadCerosPedida
           pat(i) = patronesCeros(cantidadCeros + 1);
           cantidadCeros = cantidadCeros + 1;
        else
            break;
        end
    end
end

