clc,clear
delete(instrfind)
s=serial('COM3');
s.baudrate=4800;
fopen(s);
pause(1)
while(1)
    angle=input('the angle');
    if ~angle
        break
    end
fwrite(s,angle,'uint8','async')
end
