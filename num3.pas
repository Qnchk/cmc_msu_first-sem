program sorts(input,output,f1,f2);
const s_length=7;
      s_max_count=30;
type str=array[1..s_length] of char;
     mas=array[1..s_max_count] of str;
     input_data=text;
     output_data=file of str;
var f1:input_data;
    f2:output_data;
    data,data_copy:mas;
    s_count:integer;




{=======================================================================
+++++++++++++++++++++++++string clear+++++++++++++++++++++++++++++++++++
=======================================================================}   
   procedure s_clear(var s:str);
   var k:integer;
   begin
      for k:=1 to s_length do
         begin
            s[k]:=chr(0);
         end;
         
   end;
   
   
{=======================================================================
+++++++++++++++++++++++++string read+++++++++++++++++++++++++++++++++++
=======================================================================} 
   procedure str_read(var s:str);
   var k:integer;
       bufer:char;     
   begin
      k:=0;
      repeat
         k:=k+1;
         read(bufer);
         if not(bufer='.') then
            s[k]:=bufer;
      until (k=s_length) or (bufer='.');
   end;

{=======================================================================
++++++++++++++++++++++++TEXT FILE MAKER+++++++++++++++++++++++++++++++++
=======================================================================}
   procedure file_make(var f:input_data);
   var n,k:integer;
       s: str;   
   begin
      rewrite(f);
      write('Введите количество строк, которое хотите ввести:');
      readln(n);
      for k:=1 to n do
         begin
            s_clear(s);
            write('Введите строку номер ',k,',закончив ее точкой:');
            str_read(s);
            writeln(f,s);   
            readln;
         end;
      close(f);
   end;
   

   
{=======================================================================
++++++++++++++++++++++++RESULT FILE CREATE++++++++++++++++++++++++++++++
=======================================================================}
   
   procedure result_write(var f:output_data; data:mas; s_count:integer);
   var index:integer;
   begin
      ReWrite(f);
      for index:=1 to s_count do
         begin
            write(f,data[index]);
         end;
      close(f);
      writeln('File Created!');
   end;





{=======================================================================
+++++++++++++++++++++++++++FILE-->ARRAY+++++++++++++++++++++++++++++++++
=======================================================================}
   procedure file_read(var f:input_data;var data:mas;var s_count:integer);
   var bufer:str;
       ch:char;
       index:integer;
   begin
      s_count:=0;
      index:=0;
      reset(f);
      while not(eof(f)) do
         begin
            index:=0;
            s_clear(bufer);
            while not(eoln(f)) do
               begin     
                  read(f,ch);
                  index:=index+1;
                  bufer[index]:=ch;
               end;
            s_count:=s_count+1;
            data[s_count]:=bufer;
            readln(f);
         end;
      close(f);  
   end;

{=======================================================================
+++++++++++++++++++++++++++FILE WRITE+++++++++++++++++++++++++++++++++++
=======================================================================}

   procedure file_write(var f:output_data);
   var bufer:str;
       index:integer;
   begin
      reset(f);
      while not(eof(f)) do
         begin
            read(f,bufer);
            for index:=1 to s_length do
               write(bufer[index]);
            writeln;
         end;
   end;



{=======================================================================
+++++++++++++++++++++++++++str1 V str2++++++++++++++++++++++++++++++++++
=======================================================================}

   function str_compare(var s1,s2:str;var compares_count:integer):boolean;
   var index:integer;
       result,flag:boolean;
       
   begin
      flag:=true;
      result:=true;
      index:=1;
      while (index<=s_length) and flag do
         begin
            if (s1[index]>s2[index]) and flag then
               begin
                  result:=true;
                  flag:=false;
               end;
            if (s1[index]<s2[index]) and flag then
               begin
                  result:=false;
                  flag:=false;
               end; 
            index:=index+1;  
         end;  
      compares_count:=compares_count+1; 
      str_compare:=result;
   end;



{=======================================================================
+++++++++++++++++++++++++++Data write ++++++++++++++++++++++++++++++++++
=======================================================================}
   procedure  data_write(data:mas; s_count:integer);
   var index:integer;
   begin
      for index:=1 to s_count do
         begin
            write(data[index]);
            writeln;
        end;
   
   end;


{=======================================================================
+++++++++++++++++++++++++++Data reverse+++++++++++++++++++++++++++++++++
=======================================================================}
   procedure data_reverse(var data:mas; s_count:integer);
   var index:integer;
       buffer:mas;
   
   begin
      for index:=1 to s_count do
         buffer[index]:=data[s_count-index+1];
      data:=buffer;
   end;


{=======================================================================
+++++++++++++++++++++++++++Object Swap++++++++++++++++++++++++++++++++++
=======================================================================}

   procedure objects_swap(var data:mas; s_count:integer);
   var index1,index2:integer;
       bufer:str;
   begin
      index1:=random(s_count)+1;
      index2:=index1;
      while index2=index1 do
         index2:=random(s_count)+1;
      bufer:=data[index1];
      data[index1]:=data[index2];
      data[index2]:=bufer;
   end;
   



   
   
{=======================================================================
+++++++++++++++++++++++++++MERGE SORT+++++++++++++++++++++++++++++++++++
=======================================================================}
   
   
   
   {функция, которая проверяет отсортировался ли массив}
   function sort_check(data:mas;s_count:integer):boolean;
   var index,fake:integer;
       result:boolean;
   begin
      fake:=0;
      result:=true;
      for index:=2 to s_count do
         if str_compare(data[index-1],data[index],fake) and result then
            result:=true
         else 
            result:=false;
      sort_check:=result;  
   end;
   
   
   
   
   {процедура которая выбирает отрезок по невозрастанию с начала}
   procedure segment_from_begin(data:mas; var count,counter,s_count:integer; var m1:mas; var a1,b1,compares_count:integer);
   var k:integer;
       flag:boolean;  
   begin
      flag:=true;
      count:=0;
      if counter<s_count then
         begin
            a1:=a1+1;
            count:=count+1;
            counter:=counter+1;
            m1[count]:=data[a1];
         end;  
      for k:=a1+1 to b1 do
         begin
            if flag then
               begin
                  if str_compare(data[k-1],data[k],compares_count) and (counter<s_count) then
                     begin
                        a1:=a1+1;
                        count:=count+1;
                        counter:=counter+1;
                        m1[count]:=data[k]   
                     end
                  else 
                     flag:=false;
               end;  
         end;   
   end;
   
   
   {процедура которая выбирает отрезок по невозрастанию с конца если смотреть справа налево}
   procedure segment_from_end(data:mas; var count,counter,s_count:integer; var m1:mas; var a1,b1,compares_count:integer);
   var k:integer;
       flag:boolean;  
   begin
      flag:=true;
      count:=0;
      if counter<s_count then
         begin
            b1:=b1-1;
            count:=count+1;
            counter:=counter+1;
            m1[count]:=data[b1];
         end;
      for k:=b1-1 downto a1 do
         begin
            if flag then
               begin
                  if str_compare(data[k+1],data[k],compares_count) and (counter<s_count) then
                     begin
                        b1:=b1-1;
                        count:=count+1;
                        counter:=counter+1;
                        m1[count]:=data[k]        
                     end
                  else 
                     flag:=false;
               end;  
         end;   
   end;
   
   
   
   {процедура слияния двух отрезков в один и запись их в начало}
   procedure merge_to_begin(var data,buf_data:mas; var a1,b1,a2,b2,counter:integer; s_count:integer; var compares_count:integer);
   var m1,m2:mas;
      count1,count2,c1,c2,k:integer;
   begin
      c1:=1;
      c2:=1;
      segment_from_begin(data,count1,counter,s_count,m1,a1,b1,compares_count);
      segment_from_end(data,count2,counter,s_count,m2,a1,b1,compares_count);
      while (c1<=count1) and (c2<=count2) do 
         begin
            if str_compare(m1[c1], m2[c2],compares_count) then
               begin
                  a2:=a2+1;
                  buf_data[a2]:=m1[c1];
                  c1:=c1+1
                  
               end
            else
               begin
                  a2:=a2+1;
                  buf_data[a2]:=m2[c2]; 
                  c2:=c2+1; 
               end;  
         end;
       
      if (c1<=count1) or (c2<=count2) then
         if c1<=count1 then 
            for k:=c1 to count1 do
               begin
                  a2:=a2+1;
                  buf_data[a2]:=m1[k]
                  
               end
         else
            for k:=c2 to count2 do
               begin
                  a2:=a2+1;
                  buf_data[a2]:=m2[k];
             
               end;
   end;
   
   
   {процедура слияния двух отрезков в один и запись его в конец}
   procedure merge_to_end(var data,buf_data:mas; var a1,b1,a2,b2,counter:integer;s_count:integer; var compares_count:integer);
   var m1,m2:mas;
      count1,count2,k:integer;
   begin
      segment_from_begin(data,count1,counter,s_count,m1,a1,b1,compares_count);
      segment_from_end(data,count2,counter,s_count,m2,a1,b1,compares_count);
      while (count1>0) and (count2>0) do
         begin
            if str_compare(m2[count2],m1[count1],compares_count) then
               begin
                  b2:=b2-1;
                  buf_data[b2]:=m1[count1];
                  count1:=count1-1
                  
               end
            else
               begin
                  b2:=b2-1;
                  buf_data[b2]:=m2[count2];
                  count2:=count2-1;
                  
               end;
         end;
      if (count1>0) or (count2>0) then
         if count1>0 then
            for k:=count1 downto 1 do
               begin
                  b2:=b2-1;
                  buf_data[b2]:=m1[k]
                  
               end
         else
            for k:=count2 downto 1 do
               begin
                  b2:=b2-1;
                  buf_data[b2]:=m2[k];
                  
               end;
   end;
   
   
   {1 итерация сортировки( когда один массив полностью переписался во второй}
   procedure one_iteration(var data,buf_data:mas; var iterations_count:integer;s_count:integer; var compares_count:integer);
   {a1,b1- границы массива, из которого мы ищем отрезки a2,b2- границы массива в который мы записываем слитые отрезки}
   var a1,b1,a2,b2,counter,switch:integer;
   begin
      counter:=0;
      switch:=1;
      a1:=0;
      a2:=0;
      b1:=s_count+1;
      b2:=s_count+1;
      while counter<s_count do
         begin
            if odd(switch) then
               merge_to_begin(data,buf_data,a1,b1,a2,b2,counter,s_count,compares_count)
            else
               merge_to_end(data,buf_data,a1,b1,a2,b2,counter,s_count,compares_count);
            switch:=switch+1;
         end;
      iterations_count:=iterations_count+1;
      
      
   end;
   
   
   {сама сортировка, которая гоняет туда-сюда массивчики пока Х не отсортируется}
   procedure merge_sort(var data:mas;s_count:integer);
   var iterations_count,compares_count:integer;
       buf_data:mas;
   begin
      iterations_count:=0;
      compares_count:=0;
      while not(sort_check(data,s_count)) do
         begin
            one_iteration(data,buf_data,iterations_count,s_count,compares_count);
            data:=buf_data;
            {writeln('++++++++++++итерация номер:',iterations_count,'++++++++++++');
            data_write(data,s_count);}
         end;
      writeln('Всего итераций было выпонено:',iterations_count);
      writeln('Всего сравнений было выполнено: ',compares_count);
   end;
 
 
 
  
{=======================================================================
+++++++++++++++++++++++++Selection sort+++++++++++++++++++++++++++++++++
=======================================================================} 
   procedure Selection_sort(var data:mas; s_count:integer);
   var index1,index2,num,iterations_count,compares_count:integer;
       max_s:str;
   begin
      iterations_count:=0;
      compares_count:=0;
      for index1:=1 to s_count  do
         begin
            max_s:=data[index1];
            for index2:=index1 to s_count do
               if str_compare(data[index2],max_s,compares_count) then
                  begin
                     max_s:=data[index2];
                     num:=index2;
                  end;
            data[num]:=data[index1];
            data[index1]:=max_s;
            iterations_count:=iterations_count+1;
            {writeln('++++++++++++итерация номер:',iterations_count,'++++++++++++');
            data_write(data,s_count);}
         end;
      writeln('Всего итераций было выполнено:',iterations_count);
      writeln('Всего сравнений было выполнено:',compares_count);
      
   end;
   
   
{=======================================================================
++++++++++++++++++++++++++++++MAIN++++++++++++++++++++++++++++++++++++++
=======================================================================}

begin
{assign(f1,'nul_count.txt')};

{ РАЗЛИЧНЫЕ ФАЙЛЫ ДЛЯ ПРОВЕРОК
assign(f1,'one_count.txt');
assign(f1,'random_count.txt');
}

assign(f1,'max_count.txt');


assign(f2,'output.txt');
{file_make(f1);}


file_read(f1,data,s_count);
data_copy:=data;



{сортировка выбором}

{writeln('========Data at the begining:==========');
data_write(data,s_count);
writeln;}
data_write(data,s_count);

if(s_count<>0) then
   begin
      writeln;
      writeln('                       SELECTION SORT');
      writeln;
      writeln('===============================================================');
      writeln('===================СОРТИРОВКА ВХОДНОГО ФАЙЛА===================');
      writeln('===============================================================');
      selection_sort(data_copy,s_count);
      writeln('===============================================================');
      writeln('============СОРТИРОВКА ОТСОРТИРОВАННОГО ВХОДНОГО ФАЙЛА=========');
      writeln('===============================================================');
      selection_sort(data_copy,s_count);
      writeln('===============================================================');
      writeln('=========СОРТИРОВКА ФАЙЛА, НО С ОБРАТНЫМ ПОРЯДКОМ СТРОК========');
      writeln('===============================================================');
      data_copy:=data;
      data_reverse(data_copy,s_count);
      selection_sort(data_copy,s_count);
      if s_count>=2 then
         begin
            writeln('===============================================================');
            writeln('====СОРТИРОВКА ФАЙЛА С ДВУМЯ ЭЛЕМЕНТАМИ,ПОМЕНЯННЫМИ МЕСТАМИ====');
            writeln('===============================================================');
            objects_swap(data_copy,s_count);
            selection_sort(data_copy,s_count);
         end;
   end
else
   begin
      writeln('                      SELECTION SORT');
      writeln('===============================================================');
      writeln('========================ПУСТОЙ ФАЙЛ============================');
      writeln('===============================================================');
   end;






{Естественное слияние} 


{writeln('========Data at the begining:==========');
data_write(data,s_count);
writeln;}
if s_count<>0 then
   begin
      writeln;
      data_copy:=data;
      writeln('                        MERGE SORT');
      writeln;
      writeln('===============================================================');
      writeln('===================СОРТИРОВКА ВХОДНОГО ФАЙЛА===================');
      writeln('===============================================================');
      merge_sort(data_copy,s_count);
      writeln('===============================================================');
      writeln('============СОРТИРОВКА ОТСОРТИРОВАННОГО ВХОДНОГО ФАЙЛА=========');
      writeln('===============================================================');
      merge_sort(data_copy,s_count);
      writeln('===============================================================');
      writeln('=========СОРТИРОВКА ФАЙЛА, НО С ОБРАТНЫМ ПОРЯДКОМ СТРОК========');
      writeln('===============================================================');
      data_copy:=data;
      data_reverse(data_copy,s_count);
      merge_sort(data_copy,s_count);
      if s_count>=2 then
         begin
            writeln('===============================================================');
            writeln('====СОРТИРОВКА ФАЙЛА С ДВУМЯ ЭЛЕМЕНТАМИ,ПОМЕНЯННЫМИ МЕСТАМИ====');
            writeln('===============================================================');
            objects_swap(data_copy,s_count);
            merge_sort(data_copy,s_count)
         end;
   end
else 
   begin
      writeln;
      writeln('                        MERGE SORT');
      writeln('===============================================================');
      writeln('========================ПУСТОЙ ФАЙЛ============================');
      writeln('===============================================================');
   end;
  




{Запись типизированного файла с результатами и вывод его для проверки
data:=data_copy;
result_write(f2,data,s_count);
file_write(f2);}
end.




 

   




   
   
    

