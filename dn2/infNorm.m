function [M] = infNorm(py,fy)
%Izračuna največjo razliko med dvema točkama 
% v danih vektorjih vrednost
M = max(abs(py-fy));
end