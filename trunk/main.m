%--Archivo principal
%-------------------
%--Define parametros de ejecucion y contiene llamada a algoritmo de
%--entrenamiento y generalizacion

%---------------------------------------------------------------------%
% Parametros
%---------------------------------------------------------------------%

% Maximo peso que tomaran las conexiones
maximoPeso = 0.9;
% Minimo peso que tomaran las conexiones
minimoPeso = -0.9;
% Cantidad de salidas de la red
cantidadSalidas = 1;
% Vector con las cantidades de unidades de cada capa oculta
capasOcultas = [40 40];
% Cantidad de entradas de la red
cantidadEntradas = 3;
% Bias
bias = -1;
% Learning Rate
eta = 0.05;
% Maxima cantidad de epocas a ejecutar
limiteEpocas = 1000;
% Cota superior de error cuadratico deseado
errorCuadraticoCorte = 0.0005;
% Funcion de activacion. Puede ser 'tanh' o 'sigm'
funcionActivacion = 'tanh';
% Define si se utilizara un learning rate adaptativo
parametrosAdaptativos = true;
% incremento constante en el learningrate al usarse adaptativo
incrementoEtaAdaptativo = 0.1;
% coeficiente de decremento lineal en el learningRate al usarse adaptativo
decrementoEtaAdaptativo = 0.1;
% Periodo de consistencia de los parametros adaptativos
epocasEtaAdaptativo = 3;
% Cota de error para la cual se considera una adaptacion en eta
errorAdaptacionEta = 0.00001;
% Ultimo decremento de eta
ultimoDecrementoEta = 1;
% Momentum
momentum = 0.9;
% Para verificar los patrones aprendidos, se toma este limite superior
limiteSuperiorError = 0.05;
% Para verificar los patrones generalizados, se toma este limite superior
limiteSuperiorErrorGeneralizacion = 0.1;
% Parametro beta para las funciones de activacionm
beta = 0.6;
% Cantidad de patrones de entrenamiento
cantidadPatronesEntrenamiento = 100;
% Archivo de donde se toman las muestras
archivoMuestras = 'samples4.txt';
% Obtencion de los patrones de entrenamiento
patronesEntrenamiento = patronesEntrenar(archivoMuestras, cantidadEntradas, cantidadPatronesEntrenamiento, 1, 50, 50);
% Obtencion de los patrones de generalizacion
patronesGeneralizacion = patrones(archivoMuestras, cantidadEntradas, 5000, 15000);
% Semilla para setear el estado en random
semillaRandom = 31337;


%---------------------------------------------------------------------%
% Inicializacion
%---------------------------------------------------------------------%

% Setear el estado random
rand('state', semillaRandom);
randn('state', semillaRandom);

% Se crea la red
red = nuevaRed(   cantidadEntradas,    capasOcultas,    cantidadSalidas,    maximoPeso,    minimoPeso);

% Vector con cantidades de patrones que fueron aprendidos cada epoca
aprendidosPorEpoca = [];
% Vector con error cuadratico medio por epoca
errorCuadratico = [];
% Vector utilizado para la generalizacion
generalizacion = [];
ultimoDecremetoEta= 1;
% Contador de Epocas
j=1;
salgo = false;
% Vector que almacena el ETA por epoca
etaHistorico = [];
% Vector que almacena el estado de la red en cada epoca
redHistorico = [];

redHistorico{1} = red;

%---------------------------------------------------------------------%
% Entrenamiento
%---------------------------------------------------------------------%

% Se entrena hasta que se minimize el error a la cota pedida, y todos los
% patrones sean aprendidos
while(1 - salgo),
    % Contador de patrones aprendidos
    patronesAprendidos = 0;
    errorCuadratico(j) = 0;

    %Se permuta el orden de los patrones para que no le lleguen siempre en
    %el mismo orden
    patronesEntrenamiento = patronesEntrenamiento(randperm(cantidadPatronesEntrenamiento));

    % Se itera por los patrones
    for i=1:length(patronesEntrenamiento),

        % Propagar Adelante
        red = propagarAdelante(red, patronesEntrenamiento(i).entradas , funcionActivacion, beta);
        salidaObtenida = red.salida;
        
        % Propagar Atras 
        red = propagarAtras(red, patronesEntrenamiento(i), salidaObtenida, funcionActivacion, beta, eta, momentum);

        if abs(salidaObtenida - patronesEntrenamiento(i).salida) <= limiteSuperiorError,
            patronesAprendidos = patronesAprendidos+ 1;
        end

        % Se calcula el error
        errorCuadratico(j) = errorCuadratico(j) + (patronesEntrenamiento(i).salida - salidaObtenida)^2;
    end
    aprendidosPorEpoca(j) = patronesAprendidos;
    errorCuadratico(j) = 0.5*(errorCuadratico(j))/cantidadPatronesEntrenamiento;
    
    % Si se pidieron parametros adaptativos
    if (parametrosAdaptativos)
        etaHistorico(j) = eta;
        eta = etaAdaptativo(errorCuadratico, j, eta, ultimoDecrementoEta, incrementoEtaAdaptativo, decrementoEtaAdaptativo, epocasEtaAdaptativo, errorAdaptacionEta);
        
        % Si sigue bajando eta, se vuelve para atras en la red, manteniendo
        % el eta bajo.
        if j >=3 && etaHistorico(j) < etaHistorico(j -1 ) && etaHistorico(j-1) < etaHistorico(j - 2)
           red = redHistorico{j-1}; 
        end
    end
    
    redHistorico{j+1} = red;
    
    % Se muestra en la pantalla
    epoca = j
    patronesAprendidos = patronesAprendidos
    ECM = errorCuadratico(j)
    eta = eta

    % Condicion de Corte
    if ((j+1)>limiteEpocas || (errorCuadratico(j) < errorCuadraticoCorte && counter >=cantidadPatronesEntrenamiento)),
        salgo = true;
    else
        j=j+1;
    end
end


%---------------------------------------------------------------------%
% Generalizacion
%---------------------------------------------------------------------%


cantGeneralizados = 0;
cantUnos = 0;
cantUnosGeneralizados = 0;

for i=1:length(patronesGeneralizacion),
    red = propagarAdelante(red, patronesGeneralizacion(i).entradas, funcionActivacion, beta);
    salidaObtenida = red.salida;
    if patronesGeneralizacion(i).salida == 1
        cantUnos = cantUnos + 1;
    end
    if abs(salidaObtenida - patronesGeneralizacion(i).salida) <= limiteSuperiorErrorGeneralizacion,
        cantGeneralizados = cantGeneralizados + 1;
        if patronesGeneralizacion(i).salida == 1
            cantUnosGeneralizados = cantUnosGeneralizados + 1;
        end
    end
    generalizados(i) = (abs(salidaObtenida - patronesGeneralizacion(i).salida) <= limiteSuperiorErrorGeneralizacion);
end

cantGeneralizados = cantGeneralizados
cantTotal = length(patronesGeneralizacion)
porcentajeGeneralizado = (cantGeneralizados*100)/cantTotal

porcentajeUnosGeneralizados = (cantUnosGeneralizados * 100) / cantUnos
