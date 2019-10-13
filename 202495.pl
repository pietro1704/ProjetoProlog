% Luma Gabino Vasconcelos RA: 202495
% Pietro Ruy Pugliesi RA: 185921


%rodar como: 
%swipl -q -f seu-prog.pr -t topo  < arqtestes.in

topo:- 
    read(X),%ler os dados
    process(X, Resposta),%processa
    print(Resposta).
    % FormataSaida(Resposta, Impressao)
    % print(Impressao)
   
process(X, Resp):- 
    inverte(X,Invertida),
    tam(X,Tamanho),
    percorreLista(Tamanho, X, Invertida, [], Resp),
    umPorLinha(Resp).

% Calcula tamanho da lista
tam([],0).
tam([_|Resto],N) :- tam(Resto, NovoN), N is NovoN + 1.

% Inverte lista
inverte(Lista, Resp):- inverteAcc(Lista, Resp, []).
inverteAcc([],Z,Z).
inverteAcc([H|T],Z,Acc) :- inverteAcc(T,Z,[H|Acc]).

% Formatação das saídas
% Pega o nome dos pares que tem Intersecao
listaDeNomes([], Lista, Lista).
listaDeNomes([(X1, X2)|Xs], Acc, Lista) :- 
    nomeDosPares(X1, X2, R), listaDeNomes(Xs, [R|Acc], Lista).

nomeDosPares(quad(Nome1, _, _, _), quad(Nome2, _, _, _), R) :- R = (Nome1, Nome2).
nomeDosPares(circ(Nome1, _, _, _), circ(Nome2, _, _, _), R) :- R = (Nome1, Nome2).
nomeDosPares(quad(Nome1, _, _, _), circ(Nome2, _, _, _), R) :- R = (Nome1, Nome2).
nomeDosPares(circ(Nome1, _, _, _), quad(Nome2, _, _, _), R) :- R = (Nome1, Nome2).

umPorLinha([]):-!.
umPorLinha([X|List]) :-
    print(X),nl,
    umPorLinha(List).

%algoritmo:
%percorre a lista: 
%percorre1: para cada elemento da lista em ordem crescente...
percorreLista(Tam, [X|Xs], Invertida, Acc, Resp) :- 
    percorreLista2(Tam, Invertida, X, [], Resp1),
    % print(Tam), print(---), print(Acc),nl,
    append(Resp1, Acc, Concat),
    listaDeNomes(Acc, [], Lista),
    print("lista de nomes:="),print(Lista), nl, 
    print('um por linha: '), umPorLinha(Lista),
    Tam1 is Tam-1,
    Tam > 0 -> percorreLista(Tam1, Xs, Invertida, Concat, Resp); Resp = Acc.

%percorre2: ...checa Intersecao com o ultimo ate o posterior a ele
percorreLista2(_, _, _, [_|Acc], Acc).
percorreLista2(N, [X|Xs], Elem, Acc, Resp) :-
    N1 is N - 1,
    nl, print('checando: '), print(Elem), print('--'), print(X),print('->'), nl, 
    percorreLista2(N1, Xs, Elem, [Interc|Acc], Resp), 
    checaIntersecao(Elem,X,Interc),
    print(Interc), nl,
    print('nao entro aqui'), nl, 
    percorreLista2(N1, Xs, Elem, [Interc|Acc], Resp).

% Concatena duas listas
append([],A,A).
append([X|R],A,AA) :- append(R,A,RR), AA = [X|RR].

%pegar informacoes das figuras(Circulo: posicao do centro e raio,
% quadrado: centro e lados -> vertices)
% intersecao quadrado-quadrado
checaIntersecao(quad(Nome1, X1, Y1, L1), quad(Nome2, X2, Y2, L2), Resp):-   
    extremosQuadrado(X1,Y1,L1,LimEsq1,LimSup1,LimDir1,LimInf1), 
    extremosQuadrado(X2,Y2,L2,LimEsq2,LimSup2,LimDir2,LimInf2), 
    (LimEsq1=<LimDir2, LimEsq2=<LimDir1, LimSup1>=LimInf2, LimSup2>=LimInf1) -> 
    Resp = (quad(Nome1, X1, Y1, L1), quad(Nome2, X2, Y2, L2)); fail.
% %intersecao circulo-circulo
checaIntersecao(circ(Nome1, X1, Y1, R1), circ(Nome2, X2, Y2, R2), Resp):-   
    distancia(X1,Y1,X2,Y2,D), D < R1+R2 -> 
    Resp = (circ(Nome1, X1, Y1, R1), circ(Nome2, X2, Y2, R2)); fail.
% %intersecao quadrado-circulo
checaIntersecao(quad(Nome1, X1, Y1, L1), circ(Nome2, X2, Y2, R2), Resp):-   
    delta(X1,X2,L1,DX), 
    delta(Y1,Y2,L1,DY),
    (DX*DX + DY*DY) =< R2*R2 -> % igual pois 1 ponto de intersecao
    Resp = (quad(Nome1, X1, Y1, L1), circ(Nome2, X2, Y2, R2)); fail.

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
