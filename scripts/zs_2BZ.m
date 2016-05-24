% Zachariah Sachs
% CHEM 26701
% 3 June 2013

% Belousov-Zhabotinskii 2D Reaction

%This script includes:
% -Center of mass data (direction of propogation was along Y)
% -Plots of "propogation" printed 'comy.png'
% -Fourier transform and plotted power spectra printed 'frcoma.png' and
%  'frcomb.png'. Frequency spikes written 'pqsa.csv' and 'pqsb.csv'
% -Passage distance and time from B to A in Y direction written as
%  'A_to_B.csv' and 'Pass_B_A.csv'

%**************************************************************************
% Import A and B center of mass data

% Movie was 6:42=402 sec long with 5618 frames, for a frame rate of
frr=5618/402; %frames per second

% First column is XM
% Second column is YM
comA=csvread('Y:\Public\sachs\4 lab\cenomass\comA.csv'); 
comB=csvread('Y:\Public\sachs\4 lab\cenomass\comB.csv'); 

xma=comA(:,1);
yma=comA(:,2);
xmb=comB(:,1);
ymb=comB(:,2);

frms=1:length(xma); %frame vector
tim=frms/frr; %time vector
resol=3.85; %resolution in pixels per micrometer
%**************************************************************************
% Plot A and B YM together
prop=figure;
plot(tim,yma/resol);
title('Thin-Layer BZ Wave Propogation');
xlabel('Time (s)');
ylabel('Relative Center of Mass ({\mu} m)');
hold on
plot(tim,(ymb+567.5)/resol,'r');
hold off
print(prop,'-dpng','comy');

%**************************************************************************
% Fourier Decomposition of Center of Mass Data

ndata=length(tim);
Fcomya=fft(yma/resol)/ndata; %frequency contribution
Fcomyb=fft(ymb/resol)/ndata;
pfr=1/2*linspace(0,1,ndata/2); %frequency in 1/frames %WHY THE FACTOR OF 1/2?
freqs=pfr*frr; %frequencies in Hz

% Plot power spectra
[ha,qa]=findpeaks(abs(Fcomya(1:ndata/2)).^2,'MINPEAKHEIGHT',10^-3);
qa=qa([2;3]);
ha=ha([2;3]);

focoa=figure;
loglog(freqs,abs(Fcomya(1:ndata/2)).^2);
hold on
loglog(freqs(qa),ha,'or');
title('Thin-Layer BZ Power Spectrum A');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
hold off
print(focoa,'-dpng','frcoma');

[hb,qb]=findpeaks(abs(Fcomyb(1:ndata/2)).^2,'MINPEAKHEIGHT',10^-3);
qb=qb([2;5]);
hb=hb([2;5]);

focob=figure;
loglog(freqs,abs(Fcomyb(1:ndata/2)).^2);
hold on
loglog(freqs(qb),hb,'or');
title('Thin-Layer BZ Power Spectrum B');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
hold off
print(focob,'-dpng','frcomb');

% Save spikes
csvwrite('pqsa',[freqs(qa).',ha]);
csvwrite('pqsb',[freqs(qb).',hb]);

%**************************************************************************
% Find the peaks in the center of mass data, and take the average of the
% distance between what I assume are corresponding peaks to get the
% distance from A to B in pixels.

% The wave propagated in the y direction from B to A. If dark was more
% massive, then as the wave passed, the COM would dip. Who cares. Let's
% Look at the peaks. Obviously, the time between wavefronts was much longer
% than the time between passage by B then A.

[pksA,tA]=findpeaks(yma,'MINPEAKDISTANCE',220);
[pksB,tB]=findpeaks(ymb,'MINPEAKDISTANCE',220);

pksA=pksA([1 3:18]);
tA=tA([1 3:18]);

pka=figure;
plot(yma);
hold on
plot(tA,pksA,'or');
hold off

pksB=pksB([1 3:18]);
tB=tB([1 3:18]);

pkb=figure;
plot(ymb);
hold on
plot(tB,pksB,'or');
hold off

AtB=-(pksB-pksA)/resol; %A to B distance in micrometers
AmB=mean(AtB);
AsdB=std(AtB);

AtoB=[AtB;AmB;AsdB];
csvwrite('A_to_B',AtoB);

pass=(tA-tB)/frr; % passage time from B to A in seconds
paass=mean(pass);
passs=std(pass);

Pass=[pass;paass;passs];
csvwrite('Pass_B_A',Pass);
