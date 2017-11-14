Fs=256
Ts=1/Fs
t=0:Ts:10;
sig = ecgsyn(Fs,60,0,89,1,0.5,2*Fs);
sig = sig(1:length(t));
N =  length(t)
freq = (0:N-1)*Fs/N;
freq = freq(1:floor(length(freq)/2));
 
plot(sig)
% passando ecg para a frequência
 
ECG = fft(sig);
ECG = ECG(1:floor(length(sig)/2));
 
plot(freq,abs(ECG));
%gerando sinal 60 hz:
 
f = 60
sinal = 2*sin(2*pi*f*t);
sinal = sinal'
plot(sinal)
%gerando spectro da frequência:
SINAL = fft(sinal);
SINAL = SINAL (1:floor(length(sinal)/2));
%plot(freq,abs(SINAL));
 
% somando o ruído com  o ECG
ruidoso=sig+sinal;
RUIDOSO = fft(ruidoso);
RUIDOSO = RUIDOSO(1:floor(length(ruidoso)/2));
 
plot(freq,abs(RUIDOSO));
 
  
%Construção do filtro
filtro = fir1(40,(50)*2/Fs,'low');
 
figure;
freqz(filtro); % mostra em frequência e fase
%filtrando o sinal
sinal_filtrado = conv(ruidoso,filtro);
%redimensionando no tempo e na frequência devido a convolução
tfilt=(0:length(sinal_filtrado)-1)/Fs;
freqfilt=(1:floor((length(sinal_filtrado)-1)/2))*Fs/length(sinal_filtrado);
%grafico do sinal filtrado no dominio do tempo e da frequência:
subplot(1,2,1)
plot(tfilt,sinal_filtrado)
subplot(1,2,2)
%gerando na frequência o sinal
SINAL_FILTRADO=fft(sinal_filtrado);
SINAL_FILTRADO=SINAL_FILTRADO(1:floor(length(sinal_filtrado)/2));
plot (freqfilt,abs(SINAL_FILTRADO));
