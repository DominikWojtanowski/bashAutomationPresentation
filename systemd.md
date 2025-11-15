### Czy można automatyczne uruchamianie jakichkolwiek zadań powierzyć systemowi?
Okazuje się ze tak, postaram się omówić pliki .timer i .service z systemd

---
### Systemd
---
Systemd to pierwszy proces który powstaje w linuxie, odpowiada za uruchamianie następnych procesóœ
i inicializowanie systemu, lecz nie insteresuje nas systemd w całości, tylko 
jego część zajmująca się uruchamianiem skryptów, procesów co pewien czas.

### Zegary z systemd 
Co to jest zegary z systemd -> Zgodnie z definicją:

> Zegary to jednostkowe pliki systemd z suffixem .timer. Zegary są podobne do innych jednostkowych
plików konfiguracyjnych i są ładowane z tych samych ścieżek ale zawierają sekcje [Timer]

#### Rodzaje Zegarów
- Zegary czasu rzeczywistego, uruchamiają się w jakimś określonym czasie
- Zegary monotoniczne, uruchamiają się w czasie żależnym do punktu określonego punktu startowego
zatrzymują się jeśli komputer jest wstrzymany lub zatrzymany

### Po co nam pliki .timer i .service
Teorytycznie jeśli chciałbyś uruchomić plik .service w jedym określonym momencie to wystarczy ci 
```ini
[Unit]
więcej informacji poniżej

[Service]
Więcej informacji poniżej

[Install]
WantedBy=... wystarczy np multi-user.target jesli chcesz zeby plik .service
zostal uruchomiony po boocie
```
Jednak chciałbym pokazać troche więcej możliwości odnośnie uruchamiania procesów w określonym czasie
więc będzie nam do tego potrzebny zarówno plik .service jak i .timer


### Syntax systemd unit

```ini
# Poczatkowa linia
[Unit]
Description=#opis
Documentation=#lista do dokumenttacji poprzez lokalne strony man lub url, man:nazwa(nr) lub url
Requires=#lista innych unitow ktore powinny byc uruchomione przed tym plikiem, cale uruchomienie pliku zakonczy sie niepowodzeniem jesli jakis plik sie nie 
#uruchomi np: nazwa_pliku.service nazwa_pliku_2.service itp.
Wants=#to samo co powyzej tylko ze jak jakiś plik sie nie uruchomi to sam plik będzie dalej działal
BindsTo=#To samo co Requires tylko nie uruchamia plikow
Before=#wyznacza pliki które się uruchomią po tym pliku
After=#odwrotność Before
Conflicts=#Lista unitóœ które nie mogą być uruchomione w tym samym czasie jak ten unit uruchomienie unitu z tej listy spowoduje zatrzymanie innych unitow w tej liscie
Condition<nazwa_warunku>, np: ConditionPathExists=sciezka nie spelnienie tego warunku sprawi ze glowna jednostka bedzie pominieta, jednoakze inne jednostki z
#np wanted dalej beda sie uruchamiac
Assert<nazwa_warunku>, identycznie co z condition tylko ze nie spelnienie warunku skutkuje wywaleniem bledu i calkowitym nie uruchomieniem tego unitu

# ... inne linie specyficzne dla określonych 

#ostatnia linia
[Install] # ta sekcja jest opjonalna 
WantedBy=#<nazwa_pliku>.target określa plik który spowoduje uruchomienie się tego unitu np. WantedBy=multi-user.target 
#spowoduje uruchomienie sie unitu po boocie systemu
RequiredBy=#to samo co powyżej z różnicą tego ze jak nie będzie tego pliku to plik sie nie uruchomi
Alias=#pozwala nam uruchomic plik pod innym aliasem
Also=#Kiedy aktywujesz plik poprzez systemctl enable <nazwa_pliku>.service to inne pliki z tej listy też się aktywują 
DefaultInstance=#domyślna instancja która zostanie uruchomiona kiedy uaktywnisz plik poprzez systemctl enable nazwa_pliku, normalnie podczas tworzenia plikow plikow 
#<nazwa_pliku>@instancja.service trzeba wyspecifikowac przy aktywowaniu pliku nazwe

```


### syntax plikow .service
Do [Unit] i [Install]: [Spójrz powyżej](#syntax-systemd-unit)
```ini
[Unit]
...

[Service]
Type=#wymagana opcja, daje informacje dla systemd jak zarządzać tym plikiem i jak dobrze znajdować jego stan, my będziemy używać pliku .simple ale istnieją inne typy
# W zależności od typu który wybierzemy mogą się pojawić dodatkowe opcje
ExecStart=#specyfikuje sciezke do pliku i argumenty
ExecStartPre=#dodatkowe komendy które mają się uruchomić przed wykonaniem tego pliku .service
ExecStartPost=#identycznie jak powyżej tylko ze polecenia będą się uruchamiać po wykonaniu tego pliku
ExecReload=#polecenia które się uruchomią jak zrestartujesz polecenie (systemctl restart ...)
ExecStop=#komenda używana do zakończenia tego procesu (systemctl stop nazwa_pliku.service), jeśli nie będzie to proces zatrzyma się idealnie po zakończeniu
ExecStopPost=#komendy używane po zatrzymaniu procesu
Restart=#określa kiedy systemd ma restartować usługe, posiada wiele opcji: no, always(zawsze po zakonczeniu procesu), on_success, on_failure, 
#on_abnormal(gdy proces zakończy się sygnałem np crash), on_abort(gdy proces )
RestartSec=#jeżeli automatyczne restartowanie jest uruchomione to ta komenda określa ile trzeba czekać przed następnym restartem
TimeoutSec=#określa czas po którym systemd automatyczne uzna proces za nieudany i go zabije
SuccessExitStatus=int1 int2 ... #określa kody wyjścia które może wysłać plik, które nie będą uznane za błedy



[Install]
...

```
### syntax plikow .timer

Do [Unit] i [Install]: [Spójrz powyżej](#syntax-systemd-unit)

```ini

[Unit]
...

[Timer]
OnActiveSec=#pozwala uruchomic powiazany plik w zaleznosci od czasu uruchomienia pliki .timer
OnBootSec=#czas po boocie po którym powiązany plik powinnien zostac uruchomiony
OnStartupSec=#to samo co powyżej tylko ze po uruchomieniu systemd a nie po boocie
OnUnitActiveSec=#uruchomienie pliku po okreslonym czasie od ostatniego uruchomienia tego procesu
OnUnitInactiveSec=#to samo co powyżej tylko ze patrzy na ostatni czas oznaczenia tego procesu jako nieaktywny
OnCalendar=#uruchomienie powiązanego procesu o jakimś określonym czasie np. 20 lipca 
AccuracySec=#określa przedział czasowy do którego powiązany proces powinnien zostać uruchomiony np w przedziale 1 minuty od określonego czasu do uruchomienia
Unit=nazwa powiązanego pliku który poinnien zostać uruchomiony, domyślnie jest to <nazwa_pliku>.service
Persistent=#określa informacje czy proces powinnien zostać uruchomiony nawet jak w czasie kiedy miał byc uruchomiony to urządzenie było nieaktywne, opcje to no|yes
WakeSystem=#pozwala wybudzic system jesli jest uśpiony i nadchodzi czas wykonania tego procesu


[Install]
...

```


### Jak ustawić pliki zeby systemd nam automatycznie to uruchamiał
1. Napisz skrypt
2. Nadaj mu uprawnienia do wykonywania
3. Stwórz odpowiednie pliki .timer i .service ( w /etc/systemd/system ) globalnie lub dla jednego użytkownika ( /home/użytkownik/.config/systemd/user)
4. Przeładuj konfiguracje systemd (sudo systemctl daemon-reload ewentualnie systemctl --user daemon-reload)
5. Uruchom plik .timer (sudo systemctl enable --now <nazwa_pliku>.timer ewentualnie systemctl --user enable --now <nazwa_pliku>.timer)

### Co możesz zrobić aby zobaczyć status wykonania zadania?
1. Wpisać komende systemctl status <nazwa_timeru>.timer ewentualnie systemctl --user status <nazwa_timeru>.timer
2. Wpisać komende systemctl --list-timers aby zobaczyć wszystkie zegary ewentualnie z opcja --user
3. journalctl -u <nazwa>.service ewnetualnie z opcją --user

Więcej informacji można poczytać na: 
- [Open SUSE](https://documentation.suse.com/smart/systems-management/html/systemd-working-with-timers/index.html)
- [Arch Wiki](https://wiki.archlinux.org/title/Systemd/Timers)
- [Digital Ocean](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)

