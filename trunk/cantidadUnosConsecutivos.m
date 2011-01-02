%---------------------------------------------------------------------%
% Dado un vector devuelve la cantidad de unos consecutivos que este
% contiene
%---------------------------------------------------------------------%
function cantidad = cantidadUnosConsecutivos(entrada)
    cantidad = 0;
    cantidadEntradas = length(entrada);
    for i=1:cantidadEntradas,
        if entrada(i) == 1,
            cantidad = cantidad + 1;
        else
            cantidad = 0;
        end
        if cantidad == 3
           break; 
        end
    end

    if cantidad >= 3,
        cantidad = 1;
    else
        cantidad = -1;
end