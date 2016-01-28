initcourse('TSBB15')
%%

disp('---- 3 ----')
[x,y]=meshgrid(-128:127,-128:127);
figure
subplot(1,2,1);imagebw(x,1)
subplot(1,2,2);imagebw(y,1)


r=sqrt(x.^2+y.^2);
p1=cos(r/2);
P1 = fftshift(fft2(p1));

figure
subplot(1,2,1);imagebw(p1,1)
subplot(1,2,2);imagebw(abs(P1),1)



A = 1:11
A_shift = fftshift(A)
A_ishift =ifftshift(A)

%%

p2 = cos(r.^2/200);
P2 = fftshift(fft2(p2));
figure
subplot(1,2,1);imagebw(p2,1)
subplot(1,2,2);imagebw(abs(P2),1)

%%

p2=p2.*(r.^2/200<22.5*pi);
P2 = fftshift(fft2(p2));
figure
subplot(1,2,1);imagebw(p2,1)
subplot(1,2,2);imagebw(abs(P2),1)

%%

u=x/256*2*pi;
v=y/256*2*pi;

r1=sqrt(u.^2+v.^2);
p3=cos(r1/2);
P3 = fft2(p3);

figure
subplot(1,2,1);imagebw(p3,1)
subplot(1,2,2);imagebw(abs(P3),1)

%%

Lp_filt = zeros(256,256);

Lp_filt(find(r1<=pi/4))=1;

P2_filt = Lp_filt.*P2;
p2_filt = ifft2(P2_filt);

figure
subplot(1,2,1);imagebw(p2_filt,1)
subplot(1,2,2);imagebw(abs(P2_filt),1)

%%

lp=ones(1,9)/9;
p2fs=conv2(lp,lp',p2);
figure
imagebw(p2fs,1)

%%

sigma=3;
lp=exp(-0.5*([-6:6]/sigma).^2);
lp=lp/sum(lp);

p2fs=conv2(lp,lp',p2);
figure
imagebw(p2fs,1)
figure
imagebw(lp'*lp,1)

%%

A=double(imread('paprika.png'))/255;
A=im2double(imread('paprika.png'));

size(A)

subplot(2,2,1);image(A);axis image
for k=1:3,subplot(2,2,1+k);imagebw(A(:,:,k)*255,1);end

A_gray = rgb2gray(A);
subplot(2,2,1);imshow(A_gray);axis image

%%



df = -1/sigma^2*[-6:6].*lp;

fx=conv2(lp,df',p2,'same');
fy=conv2(df,lp',p2,'same');
z=fx+1i*fy;
subplot(1,2,1);gopimage(z);axis image

z2=abs(z).*exp(1i*2*angle(z));
subplot(1,2,2);gopimage(z2);axis image

subplot(1,2,1);gopimage(abs(z2));axis image

%%

sigma=6;
lp=exp(-0.5*([-6:6]/sigma).^2);
lp=lp/sum(lp);
df = -1/sigma^2*[-6:6].*lp;

fx=conv2(lp,df',p2,'same');
fy=conv2(df,lp',p2,'same');


T=zeros(256,256,3);
T(:,:,1)=fx.*fx;
T(:,:,2)=fx.*fy;
T(:,:,3)=fy.*fy;

subplot(1,2,1);image(tens2RGB(T));axis image



lp=exp(-0.5*([-10:10]/sigma).^2);
Tlp=zeros(256,256,3);
Tlp(:,:,1)=conv2(lp,lp',T(:,:,1),'same');
Tlp(:,:,2)=conv2(lp,lp',T(:,:,2),'same');
Tlp(:,:,3)=conv2(lp,lp',T(:,:,3),'same');
subplot(1,2,2);image(tens2RGB(Tlp));axis image

alpha = acos(sqrt(T(:,:,1)))

%%

load mystery_vector.mat

m = max(mystery_vector)

[I J] = ind2sub([320 240],m)

sobel_x = [-1 0 1;
           -2 0 2;
           -1 0 1];
       
       