% cho vat chuyen dong nem xien trong trong truong co luc can dang hv
function CODE
clc
%%%
syms t v g vx vy
m= input('Nhap vao khoi luong vat: m = ');
h= input('Nhap vao he so luc can: h = ');
v0= input('Nhap vao van toc ban dau: v_0 = ');
alpha= input('Nhap vao alpha: alpha = ');
a= (m*g - h*v)/m;
ax= subs(a, {v g}, {vx 0}); % thay the v = vx, g = 0 trong bieu thuc a
ay= subs(a, {v g}, {vy -9.81}); % thay the v = vy, g = -9.81 trong bieu thuc a
vx= dsolve(['Dvx= ', char(ax)], ['vx(0) =', num2str(v0*cos(alpha))]);% giai phuong trinh vi phan theo bien t cua vx,vy,x va y voi cac chuoi ax, ay, vx va vy
vy= dsolve(['Dvy= ', char(ay)], ['vy(0) =', num2str(v0*sin(alpha))]);
x= dsolve(['Dx= ', char(vx)], 'x(0)= 0');
y= dsolve(['Dy= ', char(vy)], 'y(0)= 0');
disp(['x= ', char(x)]) %viet phýõng trinh vat chuyen ðong theo phýõng Ox
disp(['y= ', char(y)]) %viet phýõng trinh vat chuy?n ðong theo phýõng Oy
ezplot(x, y) % ve quy ðao chuyen ðong cua vat
end
