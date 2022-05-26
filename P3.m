Regresión Lineal
clear
clc
fprintf('\nREGRESIÓN LINEAL:\n');
P=[1.9 3.1 4.2 5.1 5.8 6.9 8.1 9.2 10];
R=[14.4 28.47 19.2 43.1 33.5 52.7 71.8 62.2 76.6]
%Comando de ajuste a la curva de grado 1:
pf=polyfit(R,P,1)
%Evaluar R en el polinomio pf:
eval=polyval(pf,R)
%Graficar:
plot(R, P,'*',R,eval,'-')
%Predecir la resistencia a profundidades de 15 y 45 metros
eval2=polyval(pf,15)  %La resistencia a 15 metros es 2.6281 kpa
eval3=polyval(pf,45)  %La resistencia a 45 metros a  6.0720 kpa
%paginas 525