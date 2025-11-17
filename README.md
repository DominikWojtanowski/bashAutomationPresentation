## Introduction
![Bash Logo](/assets/BashLogo.png)

### Skrypty Bash - Tworzenie prostych skryptów powłoki do automatyzacji zadań systemowych.

---

#### Czym jest bash?
> Bash - powłoka systemowa i **język skryptowy**, który służy jako interfejs do komunikacji (terminal) z systemem operacyjnym (glownie UNIX i UNIX-podobne (Linux)). **Celem dzisiejszej prezentacji jest omówienie języka skryptowego bash w kontekscie automatyzacji zadań w systemie**

---

### Bash jako język skryptowy
Pliki ktore uzywają basha jako języka skryptowego zazwyczaj maja końcówce .sh
Pierwsza linia w skrypcie który uzywa basha jest zazwyczaj #!/bin/bash mówi to komputerowi ze do wykonania tego pliku powinnien zostac uzyty bash
Bash jest zazwyczaj używany do pisania prostych skryptów które automatyzują jakies działania

#### Zalety Basha
- Bash jest wszędzie (jest domyślnym shellem w linuxie, kiedyś byl w macos)
- Bash działa jako interpreter i język skryptowy 
- Bahsa można użyć do automatyzacji wielu zadań
I wiele innych..

#### Składnia Basha
0. **typy zmiennych**
```bash
number (...,-1,0,1,2,3, ... itp.) 
string (kazdy tekst zawarty w cudzyslowach)
array (tablica mogaca zawierac kazdy typ zawartosci w sobie)
assosciative array (tablica gdzie indexami sa stringi, zeby zadeklarowac tablice assioatywna trzeba uzyc deklaracji "declare -A <nazwa_tablicy>")

```
###### każdy typ da sie zadeklarować poprzez 'declare', można więcej poczytać na [declare man page](https://linuxcommand.org/lc3_man_pages/declareh.html)

---

1. **przypisywanie zmiennych**
```bash
#<nazwa_zmiennej>=<typ_danych>
#bool:
x=true
x=false
#number:
x=1

#string:
x="hello world"

#array:
x=("array" 1 ("array2" "array3"))

#assosciative array:
declare -A x
x["banana"]=5
x["apple"]=5

```
---

2. **odwoływanie się do tych zmiennych**
```bash
echo $<nazwa_zmiennej> #-> przeczyta wartość $<nazwa_zmiennej> (number, string)

for <nazwa_pojedynczego_elementu> in ${<nazwa_tablicy>[@]}; do
    echo $<nazwa_pojedynczego_elementu> #-> odwoływanie się do wartości tablicy w bashu
done

for <nazwa_pojedynczego_elementu> in ${!<nazwa_tablicy>[@]}; do
    echo $<nazwa_pojedynczego_elementu> #-> odwoływanie sie do indexu tablicy 
    echo ${<nazwa_tablicy>[$<nazwa_pojedynczego_elementu>]} #-> odwoływanie się do zawartości tablicy o danym indexie
done



```
---

3. **działania na zmiennych**
```bash
#dodawnie
value=$((value1 + value2))
#odjemowanie
value=$((value1 - value2))
#mnozenie
value=$((value1 * value2))
#dzielenie
value=$((value1 / value2))

#konkatenacja stringow
value=$value1$value2"przykladowy string"


```

---

4. **warunki i pętle**
Zanim przystąpimy do pokazywania warunków i pętli warto się dowiedzieć jak porównywać zmienne w warunkach, aby porównywać zmienne zazwyczaj używa sie specialnych operatorow:
- -eq -> porownywanie zmiennych (equal), mozna tez uzywac "=="
- -ne -> sprawdzenie czy zmienne sa inne (not equal)
- -lt -> sprawdzenie czy zmienna jest mniejsza niz inna zmienna (lesser than)
- -gt -> sprawdzenie czy zmienna jest wieksza niz inna zmienna (greater than)
- -le -> sprawdzenie czy zmienna jest mniejsza lub rowna innej zmiennej (lesser or equal to)
- -ge -> sprawdzenie czy zmienna jest wieksza lub rowna innej zmiennej (greater or equal to)


```bash
#if 
if [ warunek ];then
    kod...
fi
#przyklad
if [ "$x" -eq 5 ]; then
    echo "x jest rowne 5"
fi
#if elseif
if [ warunek ]; then
    kod...
elif [ inny warunek ]; then
    inny_kod...
fi

#przyklad
if [$x -le $y]; then
    echo "x jest mniejsze niz y"
elif [$x == $y]; then
    echo "x jest rowne y"
else
    echo "x jest wieksze niz y"
fi

#if else
if [warunek];then 
    kod...
else
    inny_kod...
fi
#przyklad
if [$x -eq $y]; then
    echo "x jest rowne y"
else
    echo "x jest rozne od y"
fi

#for loop
for i in {1..5}; do
    echo $i 
done

for i in "${array[@]}"; do
    echo $i
done

#while loop
x=2
while [ $x -le 5 ]; do
    echo "Count is $x"
    ((x++)) #postincrementation
    #((++x)) preincrementacja
done

#until loop
count=1
until [ $count -gt 5 ]; do
  echo "Count is $count"
  ((count++))
done

#czym sie rozni while loop od until loopa
#while loop wykonuje sie jeśli warunek jest prawdą a until loop wykonuje się jeśli warunek jest fałszem
```

---

5. odczyt od uzytkownika
```bash
#aby odczytać input od uzytkownika trzeba uzyć read
read -p "ile masz lat?: " wiek 
echo $wiek
read -p "Co dzisiaj jadles?" -a array
for i in ${array[@]}; do
    echo $i
done

```
więcej można przeczytać na [read man page](https://linuxcommand.org/lc3_man_pages/readh.html)
---

6. **podawanie argumentów z terminala**
Zazwyczaj argumenty przekazuje się w nastepujący sposób:
./<nazwa_pliku>.sh arg1 arg2 arg3 arg4 ...

```bash
#aby odwolać się do zmiennych z terminala można uzyć $1 $2 $3 $4 itd. $0 jest nazwą pliku którego uzywamy
#mozna tez uzyć $@ aby potraktowac te argumenty jakby byly w tablicy
echo "Pierwszy argument: $1"
echo "Drugi argument: $2"
echo "Wszystkie argumenty: $@"
```

---

7. **odwoływanie się do innych plików bash**
aby odwolać się do innych plików .sh mozna uzyć komendy source
```bash
source <sciezka_absolutna_do_plik2.sh> #inaczej trzeba patrzec na cwd
#i teraz nam sie tak jakby uruchomil plik2.sh i mozna np. odwolywac sie do jego zmiennych
echo $plik2Int

```

---
#### Cele automatyzacji
Głównym celem automatyzacji jest pozbycie sie potrzeby własnoręcznego wykonywania zadań

#### Jak mozna automatyzowac?
W Linuxie używa się głównie dwóch sposobów:
- crontab
- systemd .service i .timer
Jednak skupimy się na systemd ponieważ systemd jest domyślnie wszędzie a crontab nie koniecznie

#### Jakie przyklady podam?
1. Automatyczne sortowanie plików względem daty (examples/sortingFiles)
2. Automatyczne aktualizowanie systemu przy uruchomieniu lub po określonym czasie czasie
3. Logowanie informacji o systemie
4. Czyszczenie folderow tymczasowych 
5. Automatyczne powiadomienie gdy zawartosc dysku przekroczy jakis okreslony procent(uznajmy ze 80%)
