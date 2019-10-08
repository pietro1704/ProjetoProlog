% Luma Gabino Vasconcelos RA: 202495
% Pietro Ruy Pugliesi RA: 185921


%rodar como: 
%swipl -q -f seu-prog.pr -t topo  < arqtestes.in
%ler os dados
%oioioioi

topo:- 
    read(X),
    %processINPUT(X, Resposta).
    %FormataSaida(Resposta, Impressao)
    % print(Impressao)
    print(X).

%fazer os algoritmo tudo
process([], []).
process([X|[]],X).
process([X, Y|Xs],Resp):- checaIntercessao(X, Y, RR), Resp = [RR|process(Xs)].


%pegar informacoes das figuras(Circulo: posicao do centro e raio,
% quadrado: centro e lados -> vertices)
%intersecao quadrado-quadrado
% checaIntercessao(quad(nome1, X1, Y1, L1), quad(nome2, X2, Y2, L2), Resp):-  extremosQuadrado(X1,Y1,L,L1X,L1Y,R1X,R1Y),
%                                                                             extremosQuadrado(X1,Y1,L,L2X,L2Y,R2X,R2Y), 
%                                                                             \(L1X>R2X; L2X>R1X; L1Y<R2Y; L2Y<R1Y) -> 
%                                                                             Resp = (quad(nome1, X1, Y1, L1), quad(nome2, X2, Y2, L2)); fail.
% % %intersecao circulo-circulo
% checaIntercessao(circ(nome1, X1, Y1, R1), circ(nome2, X2, Y2, R2), Resp):- distancia(X1,Y1,X2,Y2) < R1+R2 -> Resp = (circ(nome1, X1, Y1, R1), circ(nome2, X2, Y2, R2)); fail.
% % %intersecao quadrado-circulo
% checaIntercessao(quad(nome1, X1, Y1, L1), circ(nome2, X2, Y2, R2), Resp):- .

% Calcula distancia entre dois pontos
distancia(X1,Y1,X2,Y2,D) :- D is sqrt((X2-X1)^2 + (Y2-Y1)^2).
% Calcula extremos do quadrado
extremosQuadrado(X1,Y1,L,L1X,L1Y,R1X,R1Y) :- L1X is X1-L/2, L1Y is Y1+L/2, R1X is X1+L/2, R1Y is Y1-L/2 .
% Calcula delta
delta(Q,C,L,D) :- D is (C - max(Q, min(C, Q+L))).

gt(X,Y,Z) :- Z is max(X,Y) .

% checaIntercessao(circ(nome1, X1, Y1, R1), quad(nome2, X2, Y2, R2), Resp):- 

%talvez separar pra nao ler a mesma intercessao 2 vezes

%IMPRESSAO:
%1. quantidade de pares com imtercessao
%2. nomes dos pares de figuras

