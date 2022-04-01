:- use_module(database).
:- use_module(util).
:- use_module(setas).
:- use_module(blackjack).
:- use_module(setesetesete).
:- use_module(setas).

cls :- write("\33[2J").

homeScreen :- 

  writeln(" "),
  writeln( "__________        __ /\\ ________    _________                                           "),
  writeln( "\\______   \\ _____/  |)/ \\_____  \\   \\_   ___ \\_____ ______________   ___________  ____  "),
  writeln( " |    |  _// __ \\   __\\  /   |   \\  /    \\  \\/\\__  \\\\_  __ \\_  __ \\_/ __ \\_  __ \\/  _ \\ "),
  writeln( " |    |   \\  ___/|  |   /    |    \\ \\     \\____/ __ \\|  | \\/|  | \\/\\  ___/|  | \\(  <_> )"),
  writeln( " |______  /\\___  >__|   \\_______  /  \\______  (____  /__|   |__|    \\___  >__|   \\____/ "),
  writeln( "        \\/     \\/               \\/          \\/     \\/                   \\/              "),
  writeln(" "),
  writeln("          Casa de recreação que oferece jogos digitais operados por diversão"),
  writeln(" ").

 getBetCoin :-

  writeln("                                    ██████████"),
  writeln("                                  ██░░░░░░░░░░██"),
  writeln("                                ██░░░░██░░██░░░░██"),
  writeln("                              ██░░░░████████░░░░░░██"),
  writeln("                              ██░░░░██░░░░░░██░░░░██"),
  writeln("                              ██░░░░████████░░░░░░██"),
  writeln("                              ██░░░░██░░░░░░██░░░░██"),
  writeln("                              ██░░░░████████░░░░░░██"),
  writeln("                                ██░░░░██░░██░░░░██"),
  writeln("                                  ██░░░░░░░░░░██"),
  writeln("                                    ██████████"),
 
  writeln(" ").
 
 listMenuOptions :-
 
  writeln("Selecione a Opção:"),
  writeln(" "),
  writeln("[1] Escolha seu Jogo"),
  writeln("[2] Instruções"),
  writeln("[3] Ranking dos Jogadores"),
  writeln("[4] Créditos"),
  writeln("[5] Sair").

getGameList :-
  writeln("No Bet' O Carrero temos os seguintes jogos:"),
  writeln(" "),
  writeln("[1] Jogo das setinhas"),
  writeln("[2] BlackJack"),
  writeln("[3] 777 slots"),
  writeln(" "),
  write("Digite o número da opção que deseja:"),
  read(X),
  getGame(X),
  cls.

getRanking(X, R1):-
  get_scores(X, R1),
  writeln("Ranking dos Jogadores:"),
  writeln(" "),
  writeln("Nome  |  Pontuação"),
  writeln(" "),
  print_score(R1),
  halt.

getGame(1) :-
  initArrows.

getGame(2) :-
  init.
getGame(3) :-
  start_slots.


option(1):- getGameList.
option(2):- getInstructions.
option(3):- getRanking(_, _).
option(4):- getCredits.
option(5):- exitMensage.


 getCredits :-
  cls,
  writeln("Projeto da disciplina Paradigmas da Linguagem de Programação, período 2021.1."),
  writeln("Desenvolvido por Anna Beatriz Lucena, Henrique Lemos, Mateus Ribeiro, Natália Salvino, Ricardo Sena."),
  halt.


exitMensage :-

  writeln("Obrigada por perder dinheiro conosco, até a próxima! 😜"),
  writeln(" "),
  writeln("                                             ▓▓▓▓                      "),
  writeln("                                            ▓▓    ▓▓▓▓                "),
  writeln("                                          ▓▓  ░░░░    ▓▓▓▓            "),
  writeln("                                        ▓▓  ░░▒▒▒▒▒▒▒▒    ▓▓▓▓        "),
  writeln("                                    ▓▓▓▓  ░░░░▒▒░░░░▒▒▒▒▒▒    ▓▓▓▓    "),
  writeln("                                ▒▒▒▒░░░░▒▒▒▒░░▒▒▒▒▒▒░░░░▒▒░░░░    ▓▓▓▓"),
  writeln("                            ▒▒▒▒░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░  ▓▓▓▓  "),
  writeln("                        ▓▓▓▓░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒░░░░░░  ▓▓▓▓▓▓  "),
  writeln("                  ▓▓▓▓▓▓░░░░▓▓▓▓░░░░░░░░░░░░░░░░    ▒▒▒▒░░  ▓▓▓▓▓▓▓▓  "),
  writeln("            ▓▓▓▓▓▓  ░░░░▒▒▒▒▓▓▒▒▒▒▓▓░░░░░░░░          ░░▓▓▓▓▓▓▓▓▓▓▓▓  "),
  writeln("        ▓▓▓▓      ░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒        ▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓"),
  writeln("        ▓▓▒▒▓▓▓▓    ░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒    ▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓  "),
  writeln("      ▒▒▒▒▓▓▒▒▒▒▓▓▓▓    ░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓    "),
  writeln("    ▒▒    ▓▓▒▒▒▒▒▒▒▒▓▓▓▓    ░░░░    ░░▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓          "),
  writeln("  ▒▒  ░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓    ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒            ▒▒          "),
  writeln("▒▒░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓██████▓▓▓▓██▒▒▒▒▒▒      ▒▒▒▒▒▒▒▒▒▒        "),
  writeln("▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████████████▒▒▒▒▒▒                ▒▒      "),
  writeln("▒▒▒▒        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒████████████▓▓▓▓▒▒▒▒▒▒            ▒▒▒▒▒▒▒▒▒▒  "),
  writeln("                ▓▓▓▓▒▒▒▒▒▒▒▒████████████████      ▒▒                ░░░░▒▒"),
  writeln("                    ▓▓▓▓▒▒▒▒████████████          ▒▒            ▒▒▒▒▒▒▒▒▒▒"),
  writeln("                        ▓▓▓▓████████              ▒▒          ░░░░░░░░░░▒▒"),
  writeln("                            ████                    ▒▒    ░░░░░░▒▒▒▒▒▒▒▒▒▒"),
  writeln("                                                      ▒▒░░░░░░░░░░░░░░░░▒▒"),
  writeln("                                                        ▒▒░░░░░░░░▒▒▒▒▒▒▒▒"),
  writeln("                                                          ▒▒░░░░░░░░▒▒▒▒  "),
  writeln("                                                          ▒▒░░░░░░▒▒░░░░▒▒"),
  writeln("                                                            ▒▒░░░░░░▒▒▒▒▒▒"),
  writeln("                                                            ▒▒░░▒▒░░░░▒▒  "),
  writeln("                                                            ▒▒░░░░▒▒▒▒▒▒  "),
  writeln("                                                              ▒▒░░▒▒      "),
  writeln("                                                              ▒▒░░▒▒      "),
  writeln("                                                                ▒▒        ").

getInstructions :-
  cls,
  writeln(" "),
  getInstructionsArrowsGame,
  writeln(" "),
  getInstructions777Slots,
  writeln(" "),
  getInstructionsBlackJack,
  halt.


getInstructionsArrowsGame :-

  writeln( "1. Jogo das Setinhas"),
  writeln(" "),
  writeln( "Ao iniciar o jogo, uma sequência de caracteres (formada pelos caracteres awsd- que, no teclado, representam setas) irá aparecer na tela do usuário. Após isso, o usuário terá um tempo (determinado de acordo com a fase) para repetir a sequência."),
  writeln(" "),
  writeln( "$ Para a fase fácil, a sequência será de 5 caracteres e o usuário terá 6 segundos para responder;"),
  writeln( "$ Para a fase médio, a sequência será de 7 caracteres e o usuário terá 8 segundos para responder;"),
  writeln( "$ Para a fase fácil, a sequência será de 10 caracteres e o usuário terá 10 segundos para responder.").

getInstructions777Slots :-
  writeln("2. 777 Slots"),
  writeln(" "),
  writeln("Ao iniciar o jogo, uma sequência de 3 figuras aleatórias aparecerá na tela do usuário. Cada sequência tem um valor pré-estabelecido. ").

getInstructionsBlackJack :-
  writeln("3. BlackJack"),
  writeln(" "),
  writeln("O objetivo de qualquer mão de Blackjack é derrotar o dealer. Para fazer isso, você deve ter uma mão em que a pontuação seja mais elevada do que a mão do dealer, mas não exceda 21 no valor total. Como alternativa, você pode ganhar tendo uma pontuação menor que 22 quando o valor da mão do dealer ultrapassar 21.").

main :-
  homeScreen,
  getBetCoin,
  listMenuOptions,
  read(X),
  option(X).
  