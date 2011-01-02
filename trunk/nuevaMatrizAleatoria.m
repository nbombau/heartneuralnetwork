%---------------------------------------------------------------------%
% Genera una matrix aleatoria
%---------------------------------------------------------------------%
function matriz = nuevaMatrizAleatoria(    maximo,    minimo,    tamanioCapaInicial,    tamanioCapaFinal)
    matriz = minimo + (maximo - minimo) .* rand(tamanioCapaInicial, tamanioCapaFinal);

