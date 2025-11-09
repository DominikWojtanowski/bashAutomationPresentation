## Introduction
![Bash Logo](/assets/BashLogo.png)

### Skrypty Bash - Tworzenie prostych skryptów powłoki do automatyzacji zadań systemowych.

---

#### Czym jest bash?
> Bash - powłoka systemowa i **język skryptowy**, który służy jako interfejs do komunikacji (terminal) z systemem operacyjnym (glownie UNIX i UNIX-podobne (Linux)). **Celem dzisiejszej prezentacji jest omowienie jezyka skryptowego bash w kontekscie automatyzacji zadan w systemie**

---

### Bash jako język skryptowy
Pliki ktore uzywaja basha jako jezyka skryptowego zazwyczaj maja koncowce .sh
Pierwsza linia w skrypcie ktory uzywa basha jest zazwyczaj #!/bin/bash mowi to komputerowi ze do wykonania tego pliku powinnien zostac uzyty bash
Bash jest zazwyczaj uzywany do pisania prostych skryptow ktore automatyzuja jakies dzialania

#### Zalety Basha
- Bash jest wszedzie (jest domyslnym shellem w linuxie, kiedys byl w macos)
- Bash dziala jako interpreter i jezyk skryptowy 
- Pozwala automatyzowac wiele zadan
- Mozna odpalic go wszedzie uzywajac odpowiednich narzedzi
I wiele innych..

---
#### Cele automatyzacji
Glownym celem automatyzacji jest pozbycie sie potrzeby wlasnorecznego wykonywania tych zadań

#### Jak mozna automatyzowac?
W Linuxie istnieja dwie mozliwosci:
- crontab
- systemd .service i .timer

#### Na czym polega automatyzacja za pomoca crontab



#### Na czym polega automatyzacja za pomoca .timer i .service

#### Jakie przyklady podam?
1. Automatyczne sortowanie plikow wzgledem daty (examples/sortingFiles)
2. Automatyczne aktualizowanie systemu przy uruchomieniu lub po jakims czasie(systemd jesli bedzie jesli nie to cronjob)
3. Automatyczne backupowanie najwazniejszych plikow przy uruchomieniu
4. czyszczenie folderow tymczasowych 
5. Automatyczne powiadomienie gdy zawartosc dysku przekroczy jakis okreslony procent(uznajmy ze 80%)


