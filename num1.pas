{вычисление y=arctgx с помощью разложения в ряд}
program num1;
Var x,eps,result,chislitel:real;
      znamenatel:integer; {x- аргумент функции, eps - эпсилон точность
chislitel, znamenatel - числитель и знаменатель слагаемых в разложенном ряде соотвестенно}
Begin
{Блок обработки ввода нужных данных}
write('Введите аргумент X для функции y=arctg(X), где |x|<1: ');
readln(x);
while abs(x)>=1 do
begin
   write('Введенно некорректное значние X, введите x принадлежайший интервалу (-1; 1): ');
   readln(x);
end;
write('Введите точность до с которой надо вычислить: ');
readln(eps);

{ Блок подготовки, сразу обрабатываем первое слагаемое ряда, для дальнейшего
 удобного счета}
chislitel:=x;
znamenatel:=1;
result:=chislitel/znamenatel;
chislitel:=-chislitel;


{Основной цикл}
while abs(chislitel/znamenatel)>eps do
begin

 {в цикле считаем новые числитель и знаменатель отдельно
 это позволяет нам обойтись без счетчика + постоянно перед входом
 сверяем новую дробь с эпсилон точностью, в конце заменяем числитель на
 противоположный, так как знаки в разложенном ряде чередуются}
   chislitel:=chislitel*x*x;
   znamenatel:=znamenatel+2;
   result:=result+(chislitel/znamenatel);

   chislitel:=-chislitel;
end;
writeln('Результат программы: ',result:11:8);  {Вывод результата работы программы}
write('Результат встроенной функции: ', arctan(x):11:8);{Вывод работы встроенной функции дляудобной проверки}


end.
