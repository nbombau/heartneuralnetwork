%---------------------------------------------------------------------%
% Funcion de activacion. Recibe el parametro, el factor beta y el tipo de
% activacion, que puede tomar valores tanh y sigm
%---------------------------------------------------------------------%
function y = funcionActivacion(x, beta, tipoActivacion)
if tipoActivacion == 'tanh'
    y = tanh(beta * x);
elseif tipoActivacion == 'sigm'
    y = 1./(1+exp(-2* beta *x));
else
    y = x;
end