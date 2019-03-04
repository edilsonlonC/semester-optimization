%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Nombre = Edilson Londoño Castañeda %
%Codigo = 1087557200                %
%Grupo 2                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

int : N_materias=55;%mterias de la 1 a 55, sin contar electivas 
int : N_semestres=10;
set of int : materias = 1..N_materias;
set of int : semestres=1..N_semestres;
array [materias] of int :asignaturas=1..N_materias;
int : Aristas=45;%relación entre materias 
set of int :PREC=1..Aristas;

%dependencias
array[PREC] of materias:prec=[1,2,2,2,4,5,6,8,9,10,10,11,12,12,13,16,16,17,17,17,18,19,20,20,22,25,25,26,27,32,36,37,29,31,39,40,42,43,44,48,49,43,43,50,50];
array[PREC] of 
materias:succ=[7,9,10,11,12,13,14,15,16,17,18,35,19,20,21,25,26,26,27,32,34,35,36,37,39,29,30,31,31,33,42,43,40,41,49,44,45,46,50,54,55,47,48,52,53];
%materias que se deben cursar el mismo semestre 
int : N=5;
set of int : N_mismoSemestre=1..N;
array [N_mismoSemestre] of int : Mismo1=[24,28,38,15,9];
array [N_mismoSemestre] of int : Mismo2=[25,29,39,16,8];
array[materias] of var 1..N_semestres:inicio;
array [materias,semestres] of  var 0..6:Creditos;
%creditos. posición por materia
array [materias] of  int :C=[2,5,2,5,3,1,2,2,4,5,3,4,3,1,2,4,4,2,3,4,5,3,4,3,4,4,3,3,4,3,3,2,2,3,3,3,4,2,3,4,3,4,4,4,5,4,3,2,3,3,1,4,3,6,3];
%materias que dependen de otras 
constraint
forall(i in PREC)
(
 inicio[prec[i]] <inicio[succ[i]]
);
%materias que  que se deben cursar al mismo tiempo
constraint 
forall (b in N_mismoSemestre)(
inicio[Mismo1[b]]=inicio[Mismo2[b]]
);
%Creditos por semestre
constraint 
forall (m in materias,s in semestres)
(
 Creditos[m,s]=bool2int(inicio[m]=s)*C[m] 
);

%suma de creditos por semestre 
var int:s1=sum(m in materias)(Creditos[m,1]);
var int:s2=sum(m in materias)(Creditos[m,2]);
var int:s3=sum(m in materias)(Creditos[m,3]);
var int:s4=sum(m in materias)(Creditos[m,4]);
var int:s5=sum(m in materias)(Creditos[m,5]);
var int:s6=sum(m in materias)(Creditos[m,6]);
var int:s7=sum(m in materias)(Creditos[m,7]);
var int:s8=sum(m in materias)(Creditos[m,8]);
var int:s9=sum(m in materias)(Creditos[m,9]);
var int:s10=sum(m in materias)(Creditos[m,10]);
constraint s1>=10 /\ s1 <=20 ;
constraint s2>=10 /\ s2 <=20 ;
constraint s3>=10 /\ s3 <=20 ;
constraint s4>=10 /\ s4 <=20 ;
constraint s5>=10 /\ s5 <=20 ;
constraint s6>=10 /\ s6 <=20 ;
constraint s7>=10 /\ s7 <=20 ;
constraint s8>=10 /\ s8 <=20 ;
constraint s9>=10 /\ s9 <=20 ;
constraint s10>=10 /\ s10 <=20;
%solve satisfy;%solución sin optimizar
solve minimize N_semestres;%solucion optimizada, la cual no permite acabar la carrera en menos semestres. Pero solo halla una %solución la cual reduce la cantidad de posibilidades. 