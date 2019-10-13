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
    percorre_lista(X, R),
    tam(R,T),
    print(T),nl,  
    imprimeNomes(R).

imprimeNomes([]) :- !.
imprimeNomes([X|Xs]) :- !, print(X),nl, imprimeNomes(Xs).

%Percorre lista e pega primeiro elemento e o resto
percorre_lista([], []) :- !.
percorre_lista([_|[]], []) :- !.
percorre_lista([X|Xs], R) :- !, procura_interc(X, Xs, R1), percorre_lista(Xs, R2), append(R1, R2, R).

% Verifica para cada elemento sua interseccao com o resto da lista
procura_interc(_, [],[]) :- !.
procura_interc(Elem, [X|Xs], R) :- !, checaIntercessao(Elem, X, R1), procura_interc(Elem, Xs, R2), append(R1, R2, R).

umPorLinha([]):-!.
umPorLinha([X|List]) :-
    print(X),nl,
    umPorLinha(List).

% Calcula tamanho da lista
tam([],0).
tam([_|Resto],N) :- tam(Resto, NovoN), N is NovoN + 1.
% Concatena duas listas
append([],A,A).
append([X|R],A,AA) :- append(R,A,RR), AA = [X|RR].

%pegar informacoes das figuras(Circulo: posicao do centro e raio,
% quadrado: centro e lados -> vertices)
% intersecao quadrado-quadrado
checaIntercessao(quad(Nome1, X1, Y1, L1), quad(Nome2, X2, Y2, L2), Resp):-  extremosQuadrado(X1,Y1,L1,L1X,L1Y,R1X,R1Y), 
                                                                            extremosQuadrado(X2,Y2,L2,L2X,L2Y,R2X,R2Y), 
                                                                            (L1X=<R2X, L2X=<R1X, L1Y>=R2Y, L2Y>=R1Y) -> 
                                                                            Resp = [(Nome1, Nome2)]; Resp = [].
% %intersecao circulo-circulo
checaIntercessao(circ(Nome1, X1, Y1, R1), circ(Nome2, X2, Y2, R2), Resp):-  distancia(X1,Y1,X2,Y2,D), D < R1+R2 -> 
                                                                            Resp = [(Nome1, Nome2)]; Resp = [].
% %intersecao quadrado-circulo
checaIntercessao(quad(Nome1, X1, Y1, L1), circ(Nome2, X2, Y2, R2), Resp):-  delta(X1,X2,L1,DX), 
                                                                            delta(Y1,Y2,L1,DY),
                                                                            (DX*DX + DY*DY) < R2*R2 ->
                                                                            Resp = [(Nome1, Nome2)]; Resp = [].
checaIntercessao(circ(Nome1, X1, Y1, R1), quad(Nome2, X2, Y2, L2), Resp):- Resp = RR, checaIntercessao(quad(Nome2, X2, Y2, L2), circ(Nome1, X1, Y1, R1), RR).

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
