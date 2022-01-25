clear,clc
delete(instrfind)
s=serial('COM3');
s.baudrate=4800;
fopen(s);
pause(1)


cam=webcam(2);
dm=8;
pre_angle=0;
count=0;

while(1)
I=snapshot(cam);
I0=I;
figure(1);
I=I(:,:,1);
w =fspecial('gaussian',3,0.5);
I =imfilter(I,w,'conv','symmetric','same');
[m,n]=size(I);
I=I(1:dm:m,1:dm:n);
imshow(I0)
B=edge(I,'canny');
%figure(2)
%imshow(B)
[H,T,R] = hough(B);
P  = houghpeaks(H,1);
theta=pi/180*P(2);
R=P(1);
hold on

if (~count)
    pre_angle=P(2);
    count=1;
end

text(10,10,strcat('\theta=',num2str(P(2)),' deg'),'FontSize',20)
if H(P(1),P(2))>40
    text(10,40,'ON','FontSize',20)
    angle=P(2)-pre_angle;
    pre_angle=P(2);
    fwrite(s,angle+100,'uint8','async')
else
    text(10,40,'OFF','FontSize',20)
end

hold off

pause(0.3)
end