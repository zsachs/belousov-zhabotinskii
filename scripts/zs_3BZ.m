% Zachariah Sachs
% CHEM 26701
% 3 June 2013

% Belousov-Zhabotinskii 3D Reaction

%This script includes:
% -Time series (with Ce and without) and spectral(without Ce) data split
%  into vectors
% -Plots of time series printed 'TS.png' with Ce and 'TW.png' w/o
% -Plots of unique spectra printed 'sp###.png'
% -Surfaces of time series abs vs. (wavelength,time)
% -Fourier transform and plotted power spectra with spikes marked printed
%  'frCe###.png' (catalysed) and 'frw###.png' (uncatalysed). Peaks and
%   frequencies written 'pksCe520.csv' and 'pke###.csv'

%**************************************************************************
% Import time series data with Ce

% First column is Elapsed Time
% Second column is Absorption
TS415=csvread('Y:\Public\sachs\4 lab\Timeseries_Ce\msBZ3D415.csv'); %at wavelength 415.03 nm
TS520=csvread('Y:\Public\sachs\4 lab\Timeseries_Ce\msBZ3D520.csv'); %at wavelength 520.04 nm
TS605=csvread('Y:\Public\sachs\4 lab\Timeseries_Ce\msBZ3D605.csv'); %at wavelength 605.02 nm

tCe415=TS415(:,1);
abCe415=TS415(:,2);
tCe520=TS520(:,1);
abCe520=TS520(:,2);
tCe605=TS605(:,1);
abCe605=TS605(:,2);

% Import time series data without Ce

% First column is Elapsed Time
% Second column is Absorption
TS415W=csvread('Y:\Public\sachs\4 lab\Timeseries_noCe\w_msBZ3D415.csv'); %at wavelength 415.03 nm
TS520W=csvread('Y:\Public\sachs\4 lab\Timeseries_noCe\w_msBZ3D520.csv'); %at wavelength 520.04 nm
TS605W=csvread('Y:\Public\sachs\4 lab\Timeseries_noCe\w_msBZ3D605.csv'); %at wavelength 605.02 nm

tCe415w=TS415W(:,1);
abCe415w=TS415W(:,2);
tCe520w=TS520W(:,1);
abCe520w=TS520W(:,2);
tCe605w=TS605W(:,1);
abCe605w=TS605W(:,2);

% Import spectra without Ce

% First column is Wavelength
% Second column is Absorption
Sp000=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00000.txt');
Sp001=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00001.txt');
Sp002=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00002.txt');
Sp003=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00003.txt');
Sp004=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00004.txt');
Sp005=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00005.txt');
Sp006=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00006.txt');
Sp007=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00007.txt');
Sp008=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00008.txt');
Sp009=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00009.txt');
Sp010=importdata('Y:\Public\sachs\4 lab\Spectra_noCe\BZ_spectrum_00010.txt');

L000=Sp000.data(:,1);
Ab000=Sp000.data(:,2);
L001=Sp001.data(:,1);
Ab001=Sp001.data(:,2);
L002=Sp002.data(:,1);
Ab002=Sp002.data(:,2);
L003=Sp003.data(:,1);
Ab003=Sp003.data(:,2);
L004=Sp004.data(:,1);
Ab004=Sp004.data(:,2);
L005=Sp005.data(:,1);
Ab005=Sp005.data(:,2);
L006=Sp006.data(:,1);
Ab006=Sp006.data(:,2);
L007=Sp007.data(:,1);
Ab007=Sp007.data(:,2);
L008=Sp008.data(:,1);
Ab008=Sp008.data(:,2);
L009=Sp009.data(:,1);
Ab009=Sp009.data(:,2);
L010=Sp010.data(:,1);
Ab010=Sp010.data(:,2);

%**************************************************************************
% Plot time series with Ce
%tsCe415=figure;
tsCe=figure;
plot(tCe415,abCe415,'b');
hold on
title('Stirred Cerium Catalyzed BZ Time Series');
xlabel('Time (s)');
ylabel('Absorption');
plot(tCe520,abCe520,'g');
plot(tCe605,abCe605,'r');
hold off
%print(tsCe415,'-dpng','TS415');
print(tsCe,'-dpng','TS');

%tsCe520=figure;
%plot(tCe520,abCe520);
%title('Stirred Cerium  Catalyzed BZ Time Series');
%xlabel('Time (s)');
%ylabel('Absorption');
%print(tsCe520,'-dpng','TS520');

%tsCe605=figure;
%plot(tCe605,abCe605);
%title('Stirred Cerium  Catalyzed BZ Time Series');
%xlabel('Time (s)');
%ylabel('Absorption');
%print(tsCe605,'-dpng','TS605');

% Plot time series without Ce
%ts415w=figure;
tsw=figure;
plot(tCe415w,abCe415w,'b');
hold on
title('Stirred Uncatalyzed BZ Time Series');
xlabel('Time (s)');
ylabel('Absorption');
plot(tCe520w,abCe520w,'g');
plot(tCe605w,abCe605w,'r');
hold off
%print(ts415w,'-dpng','TW415');
print(tsw,'-dpng','TW');

%ts520w=figure;
%plot(tCe520w,abCe520w);
%title('Stirred BZ Time Series');
%xlabel('Timescale');
%ylabel('Absorption');
%print(ts520w,'-dpng','TW520');

%ts605w=figure;
%plot(tCe605w,abCe605w);
%title('Stirred BZ Time Series');
%xlabel('Time (s)');
%ylabel('Absorption');
%print(ts605w,'-dpng','TW605');

% Plot spectra without Ce

%spec000=figure;
%plot(L000,Ab000);
%title('Stirred Uncatalyzed BZ Absorption Spectra 0');
%xlabel('Wavelength (nm)');
%ylabel('Absorption');
%print(spec000,'-dpng','sp000');

spec001=figure;
plot(L001,Ab001);
title('Stirred Uncatalyzed BZ Absorption Spectra 1');
xlabel('Wavelength (nm)');
ylabel('Absorption');
print(spec001,'-dpng','sp001');

%spec002=figure;
%plot(L002,Ab002);
%title('Stirred Uncatalyzed BZ Absorption Spectra 2');

%spec003=figure;
%plot(L003,Ab003);
%title('Stirred Uncatalyzed BZ Absorption Spectra 3');

%spec004=figure;
%plot(L004,Ab004);
%title('Stirred Uncatalyzed BZ Absorption Spectra 4');

%spec005=figure;
%plot(L005,Ab005);
%title('Stirred Uncatalyzed BZ Absorption Spectra 5');

spec006=figure;
plot(L006,Ab006);
title('Stirred Uncatalyzed BZ Absorption Spectra 6');
xlabel('Wavelength (nm)');
ylabel('Absorption');
print(spec006,'-dpng','sp006');

%spec007=figure;
%plot(L007,Ab007);
%title('Stirred Uncatalyzed BZ Absorption Spectra 7');

%spec008=figure;
%plot(L008,Ab008);
%title('Stirred Uncatalyzed BZ Absorption Spectra 8');

%spec009=figure;
%plot(L009,Ab009);
%title('Stirred Uncatalyzed BZ Absorption Spectra 9');

%spec010=figure;
%plot(L010,Ab010);
%title('Stirred Uncatalyzed BZ Absorption Spectra 10');

%**************************************************************************
L=[415,520,605].';

% Surface the time series with Ce

Ce=[abCe415,abCe520,abCe605];

%cesurf=figure;
%mesh(L,tCe415,Ce);

% Surface the time series with Ce

Cew=[abCe415w,abCe520w,abCe605w];

%wcesurf=figure;
%surf(L,tCe415w,Cew);

%**************************************************************************
% Fourier Decomposition of Catalyzed Time Series Data
rrr=0.5; %time series rate in second between counts

ndata=length(tCe415);
FabCe415=fft(abCe415)/ndata; %frequency contribution
FabCe520=fft(abCe520)/ndata;
FabCe605=fft(abCe605)/ndata;
cfr=1/2*linspace(0,1,ndata/2); %frequency in 1/counts %WHY THE FACTOR OF 1/2?
freqs=cfr/rrr; %frequencies in Hz

% Plot catalyzed power spectra
fr415=figure;
loglog(freqs,abs(FabCe415(1:ndata/2)).^2);
title('Cerium Catalyzed Bulk BZ Power Spectrum at 415 nm Absorption');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
print(fr415,'-dpng','frCe415');

[pks520,frs520]=findpeaks(abs(FabCe520(1:ndata/2)).^2,'MINPEAKHEIGHT',10^-4);
pks520=pks520([8;15;23;28]);
frs520=frs520([8;15;23;28]);

fr520=figure;
loglog(freqs,abs(FabCe520(1:ndata/2)).^2);
hold on
title('Cerium Catalyzed Bulk BZ Power Spectrum at 520 nm Absorption');
loglog(freqs(frs520),pks520,'or');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
hold off
print(fr520,'-dpng','frCe520');

fr605=figure;
loglog(freqs,abs(FabCe605(1:ndata/2)).^2);
title('Cerium Catalyzed Bulk BZ Power Spectrum at 605 nm Absorption');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
print(fr605,'-dpng','frCe605');

% Save catalyzed spikes
csvwrite('pksCe520',[freqs(frs520).',pks520]);

%**************************************************************************
% Fourier Decomposition of Uncatalyzed Time Series Data
www=0.5; %time series rate in seconds between counts

mdata=length(tCe415w);
Fabw415=fft(abCe415w)/mdata; %frequency contribution
Fabw520=fft(abCe520w)/mdata;
Fabw605=fft(abCe605w)/mdata;
kfr=1/2*linspace(0,1,mdata/2); %frequency in 1/counts %WHY THE FACTOR OF 1/2?
fweqs=kfr/www; %frequencies in Hz

% Plot catalyzed power spectra

[peks415,fres415]=findpeaks(abs(Fabw415(1:mdata/2)).^2,'MINPEAKHEIGHT',10^-6);
peks415=peks415([9;20;27;35;42;51;58;63]);
fres415=fres415([9;20;27;35;42;51;58;63]);

fw415=figure;
loglog(fweqs,abs(Fabw415(1:mdata/2)).^2);
hold on
loglog(fweqs(fres415),peks415,'or');
title('Uncatalyzed Bulk BZ Power Spectrum at 415 nm Absorption');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
hold off
print(fw415,'-dpng','frw415');

[peks520,fres520]=findpeaks(abs(Fabw520(1:mdata/2)).^2,'MINPEAKHEIGHT',10^-4);
peks520=peks520([1;2;3;5;7;9;11;12]);
fres520=fres520([1;2;3;5;7;9;11;12]);

fw520=figure;
loglog(fweqs,abs(Fabw520(1:mdata/2)).^2);
hold on
loglog(fweqs(fres520),peks520,'or');
title('Uncatalyzed Bulk BZ Power Spectrum at 520 nm Absorption');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
hold off
print(fw520,'-dpng','frw520');

[peks605,fres605]=findpeaks(abs(Fabw605(1:mdata/2)).^2,'MINPEAKHEIGHT',10^-6);
peks605=peks605([10;22;30;31]);
fres605=fres605([10;22;30;31]);

fw605=figure;
loglog(fweqs,abs(Fabw605(1:mdata/2)).^2);
hold on
loglog(fweqs(fres605),peks605,'or');
title('Uncatalyzed Bulk BZ Power Spectrum at 605 nm Absorption');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
hold off
print(fw605,'-dpng','frw605');

% Save uncatalyzed spikes
csvwrite('pke415',[fweqs(fres415).',peks415]);
csvwrite('pke520',[fweqs(fres520).',peks520]);
csvwrite('pke605',[fweqs(fres605).',peks605]);




