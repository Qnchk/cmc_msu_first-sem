{ Pogosyan Arsen 109}
program num1(input,output);
const a1=3;
      b1=4;
      a2=0.0001;
      b2=1;
      a3=3;
      b3=4;
      eps1=0.001; {eps=0.005} 
      eps2=0.001;  
   function F(x:real; n:integer):real;
   begin 
      case n of
         1: F:=0.6*x+3-(x-2)*(x-2)*(x-2)+1;
         2: F:=0.6*x+3-3/x;
         3: F:=(x-2)*(x-2)*(x-2)-1-3/x;
      end; 
   end;

   function F1(x:real; n:integer):real;
   begin
      case n of
          1: F1:=0.6-3*(x-2)*(x-2);
          2: F1:=0.6+3/sqr(x);
          3: F1:=3*(x-2)*(x-2)+3/sqr(x);
      end;
   end;

   function F2(x:real;n:integer):real;
   begin
      case n of
         1: F2:=-6*(x-2);
         2: F2:=0.6-6/(x*x*x);
         3: F2:=6*x-6/(x*x*x)-12;
      end;
   end;

   function hord(n:integer;a,b:real):real;
   begin
      hord:=a-F(a,n)*(b-a)/(F(b,n)-F(a,n));
   end;
   
   function Kosat(n:integer;a:real):real;
   begin
      kosat:=a-F(a,n)/F1(a,n);
   end;


 

   procedure root(n:integer; eps1,a,b:real; var x:real); 
                                            
   var bufer:real;
       k:integer;
   begin
      k:=0;
      if(F2(a,n)*F1(a,n)>0) then
          begin
             bufer:=a;
             a:=b;
             b:=bufer;
          end;
       
      while(abs(b-a)>eps1)do
         begin
            k:=k+1; 
            a:=hord(n,a,b);
            b:=kosat(n,b);              
            x:=(a+b)/2;
         end;
   end;


   function dop_integral(n,k:integer;x:real;var h:real):real;  
   var i:integer;                                            
       dop_s:real;
   begin
      h:=h/2;
      dop_s:=0;
      for i:=1 to 2*k do
         begin
            if(i mod (2)=0) then
               begin
                  dop_s:=dop_s+F(x,n);
               end;
            x:=x+h;
         end;
      dop_integral:=h*(dop_s);
   end; 


   function integral(n:integer; eps2,a,b:real):real;
   var p,s1,s2,x,h:real;
       k,i:integer;
   begin
      k:=2;
      p:=1/3;
      h:=(b-a)/k;
      x:=a;
      s1:=0.5*F(x,n);
      for i:=1 to k-1 do
         begin
            x:=x+h;
            s1:=s1+F(x,n);
         end;
      x:=x+h;
      s1:=h*(s1+0.5*F(x,n));
      s2:=s1/2+dop_integral(n,k,a,h);
      i:=0;
      while (p*abs(s1-s2))>eps2 do
         begin
            i:=i+1;
            k:=k*2; 
            s1:=s2;
            s2:=s2/2+dop_integral(n,k,a,h);  
         end;
      integral:=s2;
   end;

   procedure s_count;
   var a,b,c,result:real;
   begin
      root(1,eps1,a1,b1,a);
      root(2,eps1,a2,b2,b);
      root(3,eps1,a3,b3,c);
      writeln('B=',b:0:2,' C=',c:0:2,' A=',a:0:2);
      result:=integral(2,eps1,b,c)+integral(1,eps1,3.2,3.8);
      writeln('S=',result:0:2);
   end;


begin
s_count;
end.
