Fs = 1000;
t=0:1/Fs:1;
z = zeros(1,1001);
pulsewidth = (1/Fs)*5;
pulseperiods = [0:1/2:2];
b = 0:100;

% x = pulstran(t,pulseperiods,@rectpuls,pulsewidth*25);
% plot3(t,z, x)
clf;
hold all
for a = 0:100
    x = pulstran(t,pulseperiods,@rectpuls,pulsewidth*a);
    
    plot3(t,z+a, x)
    view(3)
end

%plot3(t, a, b)

% plot3(t,z,x,t,z+0.1,x2,t,z+0.2,x3,z,t,x)

% dutycycle(x)


% axis tight

% Fs = 10e3;
% t = 0:1/Fs:2;
% x1 = vco(sawtooth(2*pi*t,0.5),[0.1 0.4]*Fs, Fs);
% spectrogram(x1,kaiser(256,5),220,512,Fs,'yaxis')
% view(-45,65)
