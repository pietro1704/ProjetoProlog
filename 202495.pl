% Luma Gabino Vasconcelos RA: 202495
% Pietro Ruy Pugliesi RA: 185921

%rodar como: 
%swipl -q -f seu-prog.pl -t topo  < arqtestes.in

%unico predicado (como a main)
topo:- 
    read(X),%ler os dados
    percorre_lista(X, R),%algoritmo
    tam(R,T),%numero de pares com Intersecao
    print(T),nl,  %printa numero de pares com Intersecao
    imprimeNomes(R).%imprime os pares com Intersecao

%Percorre lista e pega primeiro elemento e o resto
percorre_lista([], []) :- !.
percorre_lista([_|[]], []) :- !.
percorre_lista([X|Xs], R) :- !, procura_interc(X, Xs, R1), percorre_lista(Xs, R2), append(R1, R2, R).

% Verifica para cada elemento sua interseccao com o resto da lista
procura_interc(_, [],[]) :- !.
procura_interc(Elem, [X|Xs], R) :- !, checaIntersecao(Elem, X, R1), procura_interc(Elem, Xs, R2), append(R1, R2, R).

% Concatena duas listas
append([],A,A).
append([X|R],A,AA) :- append(R,A,RR), AA = [X|RR].

%imprime lista de pares com Intersecao, 1 par por linha
imprimeNomes([]) :- !.
imprimeNomes([X|Xs]) :- !, print(X),nl, imprimeNomes(Xs).

% Calcula tamanho da lista
tam([],0).
tam([_|Resto],N) :- tam(Resto, NovoN), N is NovoN + 1.

%pegar informacoes das figuras(Circulo: posicao do centro e raio,
% Quadrado: centro e lados -> vertices):

% Intersecao quadrado-quadrado
checaIntersecao(quad(Nome1, X1, Y1, L1), quad(Nome2, X2, Y2, L2), Resp):- 
    extremosQuadrado(X1,Y1,L1,L1X,L1Y,R1X,R1Y), 
    extremosQuadrado(X2,Y2,L2,L2X,L2Y,R2X,R2Y), 
    (L1X=<R2X, L2X=<R1X, L1Y>=R2Y, L2Y>=R1Y) -> Resp = [(Nome1, Nome2)]; Resp = [].

% %Intersecao circulo-circulo
checaIntersecao(circ(Nome1, X1, Y1, R1), circ(Nome2, X2, Y2, R2), Resp):- 
    distancia(X1,Y1,X2,Y2,D), D =< R1+R2 -> Resp = [(Nome1, Nome2)]; Resp = [].

% %Intersecao quadrado-circulo
checaIntersecao(quad(Nome1, X1, Y1, L1), circ(Nome2, X2, Y2, R2), Resp):-  
    delta(X1,X2,L1,DX), 
    delta(Y1,Y2,L1,DY),
    (DX*DX + DY*DY) =< R2*R2 ->
    Resp = [(Nome1, Nome2)]; Resp = [].

%intersecao circulo-quadrado
checaIntersecao(circ(Nome1, X1, Y1, R1), quad(Nome2, X2, Y2, L2), Resp):- 
    Resp = RR, checaIntersecao(quad(Nome2, X2, Y2, L2), circ(Nome1, X1, Y1, R1), RR).


% Calcula distancia entre dois pontos
distancia(X1,Y1,X2,Y2,D) :- D is sqrt((X2-X1)^2 + (Y2-Y1)^2).

% Calcula extremos do quadrado (superior esq e inferior direito)
extremosQuadrado(XCentro,YCentro,L,XEsq,YSup,XDir,YInf) :- 
    XEsq is XCentro-L/2, YSup is YCentro+L/2, XDir is XCentro+L/2, YInf is YCentro-L/2 .

% Calcula deltax e deltay = distancia (x ou y) min entre quadrado e centro do circulo
delta(CoordQuad,CoordCirc,Lado,Delta) :- 
    %Near = ponto do quadrado mais proximo do centro do circulo
    Near is max((CoordQuad - Lado/2) , min(CoordCirc, (CoordQuad + Lado / 2))), 
    Delta is abs(CoordCirc - Near).
