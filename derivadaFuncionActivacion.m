%---------------------------------------------------------------------%
% Calcula la derivada de la funcion de activacion, recibiendo el parametro,
% el factor beta y el tipoActivacion, que puede ser tanh o sigm
%---------------------------------------------------------------------%
function y = derivadaFuncionActivacion(x, beta, tipoActivacion)

if tipoActivacion == 'tanh'
    y = beta.*(1 - ((tanh(beta .* x)).^2));
elseif tipoActivacion == 'sigm'
    y = 2*beta.*(funcionActivacion(x, beta, tipoActivacion)).*(1 - funcionActivacion(x, beta, tipoActivacion));
else
    y = x;
end