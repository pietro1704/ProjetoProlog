% Luma Gabino Vasconcelos RA: 202495
% Pietro Ruy Pugliesi RA: 185921


%rodar como: 
%swipl -q -f seu-prog.pr -t topo  < arqtestes.in
%ler os dados
%oioioioi

topo:- 
    read(X),
    % process(X, Resposta),
    % print(Resposta),
    % FormataSaida(Resposta, Impressao)
    % print(Impressao)
    tam(X,Tamanho),
    inverte(X,Invertida,[]),
    percorre_lista(Tamanho, X, Invertida, Resp), print(X).


%fazer os algoritmo tudo
percorre_lista(Tam, [X|Xs], Invertida, Resp) :-
    ( Tam==0 -> Resp = true;
    
        Tam1 is Tam-1,

        percorre2_lista(Tam, Invertida, X, Resp),

        percorre_lista(Tam1, Xs, Invertida, Resp)
    ).


percorre2_lista(N, [X|Xs], Elem, Resp) :-
    ( N==1 -> Resp = true;

        N1 is N -1,

        print(Elem), print(-------), print(X), nl,

        percorre2_lista(N1, Xs, Elem, Resp)
    ).

% percorre2_lista(Inicio, Tam, [X|Xs], Elem, Resp) :-
%     ( Tam==1 -> returnData = 10;

%         Tam1 is Tam-1,

%         Intersecao = checaIntercessao(Elem, X),
%         percorre2_lista(Inicio, Tam, Lista, [Resp|Intersecao]),

%         while(Tam1, Lista, Resp)
%     ).

% Calcula tamanho da lista
tam([],0).
tam([_|Resto],N) :- tam(Resto, NovoN), N is NovoN + 1.
% Inverte lista
inverte([],Z,Z).
inverte([H|T],Z,Acc) :- inverte(T,Z,[H|Acc]).

%pegar informacoes das figuras(Circulo: posicao do centro e raio,
% quadrado: centro e lados -> vertices)
% intersecao quadrado-quadrado
checaIntercessao(quad(Nome1, X1, Y1, L1), quad(Nome2, X2, Y2, L2), Resp):-  extremosQuadrado(X1,Y1,L1,L1X,L1Y,R1X,R1Y), 
                                                                            extremosQuadrado(X2,Y2,L2,L2X,L2Y,R2X,R2Y), 
                                                                            (L1X=<R2X, L2X=<R1X, L1Y>=R2Y, L2Y>=R1Y) -> 
                                                                            Resp = (quad(Nome1, X1, Y1, L1), quad(Nome2, X2, Y2, L2)); fail.
% %intersecao circulo-circulo
checaIntercessao(circ(Nome1, X1, Y1, R1), circ(Nome2, X2, Y2, R2), Resp):-  distancia(X1,Y1,X2,Y2,D), D < R1+R2 -> 
                                                                            Resp = (circ(Nome1, X1, Y1, R1), circ(Nome2, X2, Y2, R2)); fail.
% %intersecao quadrado-circulo
checaIntercessao(quad(Nome1, X1, Y1, L1), circ(Nome2, X2, Y2, R2), Resp):-  delta(X1,X2,L1,DX), 
                                                                            delta(Y1,Y2,L1,DY),
                                                                            (DX*DX + DY*DY) < R2*R2 ->
                                                                            Resp = (quad(Nome1, X1, Y1, L1), circ(Nome2, X2, Y2, R2)); fail.
checaIntercessao(circ(Nome1, X1, Y1, R1), quad(Nome2, X2, Y2, L2), Resp):- Resp = RR, checaIntercessao(quad(Nome2, X2, Y2, L2), circ(Nome1, X1, Y1, R1), RR).


% Calcula distancia entre dois pontos
distancia(X1,Y1,X2,Y2,D) :- D is sqrt((X2-X1)^2 + (Y2-Y1)^2).
% Calcula extremos do quadrado
extremosQuadrado(X1,Y1,L,L1X,L1Y,R1X,R1Y) :- L1X is X1-L/2, L1Y is Y1+L/2, R1X is X1+L/2, R1Y is Y1-L/2 .
% Calcula delta
delta(CoordQuad,CoordCirc,Lado,Delta) :- Delta is (CoordCirc - max((CoordQuad-Lado/2), min(CoordCirc, (CoordQuad-Lado/2)+Lado))).



%talvez separar pra nao ler a mesma intercessao 2 vezes

%IMPRESSAO:
%1. quantidade de pares com imtercessao
%2. nomes dos pares de figuras

