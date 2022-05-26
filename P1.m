% 1. Interpolación

%% Ejercicio relacionado con Termodinámica 1 (cuarto semestre). 
%{
Emplee la porción de la tabla de vapor que se da para el H_2O
supercalentado a 200 MPa, para encontrar la entropía correspondiente s para
un volumen específico v de 0.108 m3/kg con:
a) Interpolación lineal de Newton:
b) Interpolación de Vandermonde.
%}

%%% Tabla:
%{         
|               |   1       |   2       |   3       |   4       |
|   v (m^3/kg)  |   0.10377 |   0.11144 |   0.1254  |   0.108   |
|   s (kJ/kg·K) |   6.4147  |   6.5453  |   6.7664  |   ?       |
%}

%% Código
clear
clc
format long;

syms v

v1 = 0.10377;
v2 = 0.11144;
v3 = 0.1254;
v4 = 0.108;

s1 = 6.4147;
s2 = 6.5453;
s3 = 6.7664;
%s4 = ?

fprintf('DIFERENCIAS DIVIDIDAS\n');

%% a) Newton:
fprintf('\nNewton -->\n');

c2_c1 = (s2 - s1)/(v2 - v1);
c3_c2 = (s3 - s2)/(v3 - v2);

c3_c2_c1 = (c3_c2 - c2_c1)/(v3 - v1);

c1 = s1;
c2 = c2_c1;
c3 = c3_c2_c1;

%s1 = s1
%s2 = c1 + c2(v - v1);
s = c1 + c2*(v - v1) + c3*(v - v1)*(v - v2);

s4 = subs(s, v4);

ves = [v1, v2, v3, v4];
eses = [s1, s2, s3, s4];

f1 = figure;
hold off;
hold on;
fplot(s,'-c','Linewidth', 2);
for i = 1:length(ves)
    plot(ves(i), eses(i), 'b*');
end

fprintf('\nLos valores de entropía según este modelo para los volúmenes son:\n');
for i = 1:length(ves)
    eses(i) = subs(s,ves(i));
    fprintf('v%i = %.9f; s%i = %.9f\n', i, ves(i), i, eses(i));
end

fprintf('\nModelo matemático: %s', simplify(s));
fprintf('\nLa entropía s cuando v es igual a 0.108 es: %2f(kJ/kg·K)\n', s4);

%% b) Vandermonde
fprintf('\nVandermonde -->\n');

ves = [v1, v2, v3];
eses = [s1, s2, s3];

solucion = (vander(ves))^(-1) * eses';
s = 0;

super = length(ves) - 1;
for i = 1:length(ves)
    s = s + solucion(i)*(v^(super));
    super = super - 1;
end

s4 = subs(s, v4);

ves(4) = v4;

fprintf('\nLos valores de entropía según este modelo para los volúmenes son:\n');
for i = 1:length(ves)
    eses(i) = subs(s,ves(i));
    fprintf('v%i = %.9f; s%i = %.9f\n', i, ves(i), i, eses(i));
end

f2 = figure;
hold off;
hold on;
fplot(s, 'Linewidth',2);
for i = 1:length(ves)
    plot(ves(i), eses(i), 'ro');
end

fprintf('\nModelo matemático: %s', simplify(s));
fprintf('\nLa entropía s cuando v es igual a 0.108 es: %2f (kJ/kg·K)', s4);
