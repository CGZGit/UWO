%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function du=dpu(a,x)
%       ===================================================================
%       Purpose: Compute derivative of parabolic cylinder functions U(a,x)
%       Input  : a --- Parameter (|a| < 5)
%                x --- Argument (|x| < 5)
%       Output : du ------ U'(a,x)                
%       ===================================================================
c=zeros(1,100);
d=zeros(1,100);
eps=1.0e-15;
sqpi=sqrt(pi);
c0=1.0;
c1=a;
c(1)=a;
for  k1=4:2:202;
m=k1/2;
ck=a*c1+(k1-2.0)*(k1-3.0)*c0/4;
c(m)=ck;
c0=c1;
c1=ck;
end;  
y1=a;
r=1.0;
for  k=1:100;
r=0.5*r*x*x/(k*(2.0*k+1.0));
r1=c(k+1)*r;
y1=y1+r1;
if(abs(r1/y1)<= eps&&k > 30)
    break; end;
end;
y1=x*y1;
d1=1.0;
d2=a;
d(1)=1.0;
d(2)=a;
for  k2=5:2:160;
m=fix((k2+1)/2);
dk=a*d2+0.25*(k2-2.0)*(k2-3.0)*d1;
d(m)=dk;
d1=d2;
d2=dk;
end;  
y2=1.0;
r=1.0;
for  k=1:100;
r=0.5*r*x*x/(k*(2.0*k-1.0));
r1=d(k+1)*r;
y2=y2+r1;
if(abs(r1/y2)<= eps&&k > 30)
    break; end;
end; 
if a < 0&&(a+1/2)==fix(a+1/2)
    ar=pi*(1/4+a/2);
    f1=gamma(1/4-a/2)/(sqpi*2^(a/2+1/4));
    f2=gamma(3/4-a/2)/(sqpi*2^(a/2-1/4));
    du=cos(ar)*f1*y1-sin(ar)*f2*y2;
else
sq2=sqrt(2.0);
p0=sqpi/2^(a/2+1/4);    
g1=gamma(1/4+a/2);
g3=gamma(3/4+a/2);
du=p0*(y1/g3-sq2*y2/g1);
end;
