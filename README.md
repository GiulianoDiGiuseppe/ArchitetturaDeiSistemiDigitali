# ArchitetturaDeiSistemiDigitali

## Autori
Antonio Romano 
Giuseppe Riccio 
Giuliano di Giuseppe 
Sossio Cirillo

## Esercizio 1
Si realizza un Multiplexer seguendo le specifiche richieste dal cliente:
1.1 Progettare, implementare in VHDL e testare mediante simulazione un multiplexer indirizzabile 16:1, utilizzando un approccio di progettazione per composizione a partire da multiplexer 4:1.
1.2 Utilizzando il componente sviluppato al punto precedente, progettare, implementare in VHDL e testare mediante simulazione una rete di interconnessione a 16 sorgenti e 4 destinazioni.
1.3 Sintetizzare ed implementare su board il progetto della rete di interconnessione sviluppato al punto 1.2, utilizzando gli switch per fornire gli input di selezione e i led per visualizzare i 4 bit di uscita. Per quanto riguarda i 16 bit dato in input, essi possono essere precaricati nel sistema oppure immessi anch’essi mediante switch, sviluppando in questo secondo caso un’apposita rete di controllo per l’acquisizione

## Esercizio 2
Si realizza un Encoder BCD seguendo le specifiche richieste dal cliente:
2.1 Progettare, implementare in VHDL e testare mediante simulazione una rete che, data in ingresso una stringa binaria X di 10 bit X9 X8 X7 X6 X5 X4 X3 X2 X1 X0 che corrisponde alla rappresentazione decodificata di una cifra decimale (cioè, una rappresentazione in cui ogni stringa contiene un solo bit alto), fornisce in uscita la rappresentazione Y della cifra mediante codifica Binary-Coded Decimal (BCD).
  Input: 0000000001 à Output: 0000 (cifra 0)
  Input: 0000000010 à Output: 0001 (cifra 1)
  Input: 0000000100 à Output: 0010 (cifra 2)
  ….
2.2 Sintetizzare ed implementare su board il progetto dell’encoder BCD utilizzando gli switch per fornire la stringa X in ingresso, e i led per visualizzare Y. Nel caso in cui si utilizzi una board dotata di soli 8 switch, è possibile sviluppare il progetto considerando X di soli 8 bit (la macchina sarà allora in grado di fornire in uscita la rappresentazione BCD delle cifre decimali da 0 a 7).
2.3 Utilizzare un display a 7 segmenti per visualizzare la cifra decimale codificata da Y (pilotare opportunamente i catodi del display per visualizzare la cifra)

## Esercizio 3
Si realizza un Riconoscitore di sequenza a 2 modalità seguendo le specifiche richieste dal cliente:
▪ 3.1 - Progettare, implementare in VHDL e testare mediante simulazione una macchina in grado di riconoscere la sequenza 1001. La macchina prende in ingresso un segnale binario i che rappresenta il dato, un segnale A di tempificazione e un segnale M di modo, che ne disciplina il funzionamento, e fornisce un’uscita Y alta quando la sequenza viene riconosciuta. In particolare,
  ▪ se M=0, la macchina valuta i bit seriali in ingresso a gruppi di 4,
  ▪ se M=1, la macchina valuta i bit seriali in ingresso uno alla volta, tornando allo stato iniziale ogni volta che la sequenza viene correttamente riconosciuta.
▪ 3.2 - Sintetizzare e implementare su board la rete sviluppata al punto precedente,utilizzando uno switch S1 per codificare l’input i e uno switch S2 per codificare il modo M, in combinazione con due bottoni B1 e B2 utilizzati rispettivamente per acquisire l’input da S1 e S2 in sincronismo con il segnale di tempificazione A, che deve essere ottenuto a partire dalclock del board. Infine, l’uscita Y può essere codificata utilizzando un led

## Esercizio 4

## Esercizio 5

## Esercizio 6


## Esercizio 7












