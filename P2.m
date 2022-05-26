% 2. Integración de ecuaciones con fórmulas de Newton-Cotes

%% Ejercicio relacionado con "Física mecánica" 1 (segundo semestre).
%{
Una empresa de entregas de paquetes aéreos desea determinar qué tan lejos
caerán éstos después de cierto tiempo t para optimizar el tiempo de entrega
en un futuro. La velocidad de un paquete al caer está dada por:
    
    v(t) = (gm/c)(1-e^-((c/m)t))

Donde v = la velocidad (m/s), g = la constante gravitacional de 9.8 m/s2,
m = la masa del paquete y c = el coeficiente de arrastre de 12.5 kg/s. De
modo que la distancia recorrida por un paquete luego de cierto tiempo t es:

    d = ∫ v(t) dt
    d = gm/c ∫ 1-e^-((c/m)t) dt

Determinar la distancia recorrida por un paquete de 68.1 kg con un n de 3
segmentos y un b de 10 s con los siguientes métodos:
a) Trapecio compuesto,
b) Simpson 3/8 Compuesto
c) Cuadratura de Gauss Legendre
%}

%% Código
clear
clc
format long;
hold off;
hold on;

syms t;

g = 9.8;
m = 68.1;
c = 12.5;

d = ((g*m)/c)*(1-exp(-((c/m)*t)));

a = 0;
b = 10;

n = 3;
h = (b-a)/n;

vt = double(int(d,a,b));

abcisas = a : 0.01 : b;
ordenadas = subs(d, abcisas);
area1 = area(abcisas, ordenadas);

fprintf('INTEGRACIÓN NUMÉRICA\n');

fprintf('\nValor teórico de distancia recorrida: %.5fm\n', vt);
fprintf('\nValores experimentales:\n');

%% a) Trapecio compuesto:
fprintf('\nTrapecio compuesto -->\n');

sumatoria = (subs(d,a) + subs(d,b)) / 2;
for i=1:n-1
    ti = (a + i) * h;
    sumatoria = sumatoria + subs(d,ti);
end

ve = double(sumatoria * h);

ea = abs(vt - ve);
er = double(((b-a)^3/(12*(n^2)))*abs(max(subs(diff(d,2),a),subs(diff(d,2),b))));

fprintf('Valor experimental: %.5fm\n', ve);
fprintf('Error absoluto: %.e\n', ea);
fprintf('Error relativo: %.5f%%\n', er);

%% b) Simpson 3/8 Compuesto
fprintf('\nSimpson 3/8 Compuesto -->\n');

sumatoria = (subs(d,a) + subs(d,b));
for i=1:n-1
    ti = (a + i) * h;
    if (mod(i,3) == 0)
        sumatoria = sumatoria + 2*subs(d, ti);
    else
        sumatoria = sumatoria + 3*subs(d, ti);
    end
end

sumatoria = double(sumatoria * (3*h)/8);
ve = sumatoria;

ea = abs(vt - ve);
er = -double(((n/80)*(h^5))*max(subs(diff(d,4),a),subs(diff(d,4),b)));

fprintf('Valor experimental: %.5fm\n', ve);
fprintf('Error absoluto: %.e\n', ea);
fprintf('Error relativo: %.5f%%\n', er);

%% c) Cuadratura de Gauss Legendre 
fprintf('\nCuadratura de Gauss Legendre -->\n');

ti=[];
ci=[];

switch n
case 1
    ti = [0];
    ci = [2];
case 2
    ti = [-sqrt(1/3), sqrt(1/3)];
    ci = [1, 1];
case 3
    ti = [-sqrt(3/5), 0, sqrt(3/5)];
    ci = [5/9, 8/9, 5/9];
case 4
    ti = [-sqrt((3-2*sqrt(6/5))/7), sqrt((3-2*sqrt(6/5))/7), -sqrt((3+2*sqrt(6/5))/7), sqrt((3+2*sqrt(6/5))/7)];
    ci = [(18+sqrt(30))/36, (18+sqrt(30))/36, (18-sqrt(30))/36, (18-sqrt(30))/36];
case 5
    ti = [0, -(1/3)*sqrt(5-2*sqrt(10/7)), (1/3)*sqrt(5-2*sqrt(10/7)), -(1/3)*sqrt(5+2*sqrt(10/7)), (1/3)*sqrt(5+2*sqrt(10/7))];
    ci = [128/225, (322+13*sqrt(70))/900, (322+13*sqrt(70))/900, (322-13*sqrt(70))/900, (322-13*sqrt(70))/900];
otherwise
    disp('Valor de n incorrecto.');
end

sumatoria = 0;
for i=1:n
    sumatoria = sumatoria + ci(i) * subs(d,(((b-a)/2)*ti(i)) + (a+b)/2);
end

ve = double(sumatoria*(b-a)/2);

ea = double(abs(vt-ve));
er = (ea/vt) * 100;

fprintf('Valor experimental: %.5fm\n', ve);
fprintf('Error absoluto: %.e\n', ea);
fprintf('Error relativo: %.5f%%\n', er);