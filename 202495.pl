% Luma Gabino Vasconcelos RA: 202495
% Pietro Ruy Pugliesi RA: 185921


%rodar como 
%swipl -q -f seu-prog.pr -t topo  < arqtestes.in
%ler os dados
topo:- 
    read(X),
    %processINPUT(X, Resposta).
    %FormataSaida(Resposta, Impressao)
    % print(Impressao)
    print(X).

%fazer os algoritmo tudo
% process([], []).
% process([X, Y|Xs],Resp):- checaIntercessao(X, Y, RR), Resp = [RR|process(Xs)].


%pegar informacoes das figuras(Circulo: posicao do centro e raio,
% quadrado: centro e lados -> vertices)

%intersecao quadrado-quadrado

%intersecao circulo-circulo

%intersecao quadrado-circulo

%talvez separar pra nao ler a mesma intercessao 2 vezes

%IMPRESSAO:
%1. quantidade de pares com imtercessao
%2. nomes dos pares de figuras

