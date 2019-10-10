topo:-

% Read data
	read(Data),
	nl,

% Prints to check data colect
	print(Data),
	nl,
	tam(Data,Size),
	nl,

	print("Size ="),
	print(Size),
	nl,nl,

%   Loop
	prolog_while(Size, Data, returnData).

% ------------------ FUNÇÕES -------------------

% compare figure with its predecessors
prolog_while2( N, Data, Q1, Jo) :-
    ( N==0 -> true ;

         N1 is N -1,

         element_at(Q2,Data,N1),
         print(Q2),
         printaElem(Q1,Q2),

         prolog_while2(N1,Data,Q1,1)
    ).

% separate the figures and send for intersection test
prolog_while(N, Data, returnData) :-
    ( N==1 -> returnData = 10;

         N1 is N -1,

         %controle de ciclo
         element_at(Q1,Data,N1),
         print("Intersections with: "), print(Q1), nl,nl,

         prolog_while2(N1,Data,Q1,returnDataInterseptions), nl,

         print(---------------------------), nl,

         prolog_while(N1, Data, returnData)
    ).

element_at(Data, [Data|_], N):- N =:= 0, !.
element_at(Data, [_|Y], N):- N1 is N-1, element_at(Data, Y, N1).

makeList(List1, [List1]).

tam([],0).
tam([_|R],N) :- tam(R,NN), N is NN+1.

dist(X,Y,Z) :-
    (  
        X =< Y -> Z is Y - X;  
        Z is X - Y
    ).

intersept(Reach,Dx,Dy,Z) :-
    (  
        Dx =< Reach -> print(true);  
        Dy =< Reach -> print(true);  
        print(false)
    ).

printaElem(quad(NameQ1,Xc1,Yc1,Size1), quad(NameQ2,Xc2,Yc2,Size2)):-

    dist(Xc1,Xc2,Dx),
    dist(Yc1,Yc2,Dy),

    Reach is div(Size2,2) + div(Size1,2),

    print( ---> ),
    intersept(Reach,Dx,Dy,Hu),
    nl.






















