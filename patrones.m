%---------------------------------------------------------------------%
% Obtiene patrones del archivo indicado
%---------------------------------------------------------------------%
function pat = patrones(  nombreArchivo,   tamanioVentana,     limite,     desplazamiento)
    [senial valor] = textread(nombreArchivo,'%f %d');

    cantidadTotal = length(senial);
    sobrantes = mod(cantidadTotal, tamanioVentana);
    tamanioMaximo = cantidadTotal - sobrantes;
    senial = senial(1:tamanioMaximo);
    valor = valor(1:tamanioMaximo);

    desplazamientoAux = desplazamiento;
    i = 1;
    while ( desplazamientoAux+tamanioVentana-1 < tamanioMaximo && i <= limite)
        patron.entradas = senial(desplazamientoAux:desplazamientoAux+tamanioVentana-1)' + 6.429316;%todo: normalizar con multiplicacion
        patron.salida = cantidadUnosConsecutivos(valor(desplazamientoAux:desplazamientoAux+tamanioVentana));
        pat(i) = patron;

        i = i+1;
        desplazamientoAux = desplazamientoAux + floor(tamanioVentana/2);
    end
end

