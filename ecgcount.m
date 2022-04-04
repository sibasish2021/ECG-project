filename = input('Enter the file to be analyzed  ','s');
filename1 = [filename,'.txt'];
c = input('Enter the column having the data ');
sig=load(filename1);
sig1=sig(:,c);



beats=0;
P=0;
S=0;
R=0;
Q=0;
str="";
for k=2:length(sig1)-1
    if(sig1(k)>sig1(k-1)&& sig1(k)>sig1(k+1)&& sig1(k)>1)
        beats=beats+1;
        R=R+1;
        str="R";
    end
    if(sig1(k)<sig1(k-1)&& sig1(k)<sig1(k+1)&& sig1(k)<-0.5)
        S=S+1;
        str="S";
    end
    if(sig1(k)<sig1(k-1)&& sig1(k)<sig1(k+1)&& sig1(k)<-0.15 && sig1(k)>-0.5 && str~="Q")
        Q=Q+1;
        str="Q";
    end

end  
fs=input('Enter the sampling frequency ');

N=length(sig1);
N_length=2^nextpow2(N);

duration_in_seconds=N/fs;
duration_in_minutes=duration_in_seconds/60;
bpm=beats/duration_in_minutes;
arr=['The heart rate is ' , num2str(bpm)];

[b,a] = butter(6,0.6);
freqz(b,a,[],100);
data= filter(b,a,sig1);
fftOfECG=abs((fft(data,N)));
y = 1:1:6000;
z=y/3000;
subplot(2,1,1);
plot(data,'r');
ylim([-5,5]);
title('ECG before smoothening');
xlabel('Samples')
ylabel('Voltages')

subplot(2,1,2);
plot(z,fftOfECG,'b');
title('FFT before smoothening');
xlabel('Samples')
ylabel('Voltages')

beats=0;
P=0;
S=0;
R=0;
Q=0;
str="";
for k=2:length(sig1)-1
    if(sig1(k)>sig1(k-1)&& sig1(k)>sig1(k+1)&& sig1(k)>1)
        beats=beats+1;
        R=R+1;
        str="R";
    end
    if(sig1(k)<sig1(k-1)&& sig1(k)<sig1(k+1)&& sig1(k)<-0.5)
        S=S+1;
        str="S";
    end
    if(sig1(k)<sig1(k-1)&& sig1(k)<sig1(k+1)&& sig1(k)<-0.15 && sig1(k)>-0.5 && str~="Q")
        Q=Q+1;
        str="Q";
    end

end  


if(bpm==0)
    disp('The patient is dead');
else
    disp(arr);
end

