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

#### Skladnia Basha
0. **typy zmiennych**
```bash
number (...,-1,0,1,2,3, ... itp.) 
string (kazdy tekst zawarty w cudzyslowach)
array (tablica mogaca zawierac kazdy typ zawartosci w sobie)
assosciative array (tablica gdzie indexami sa stringi, zeby zadeklarowac tablice assioatywna trzeba uzyc deklaracji "declare -A <nazwa_tablicy>")

```
###### kazdy typ da sie zadeklarowac poprzez 'declare', mozna wiecej poczytac na [declare man page](https://linuxcommand.org/lc3_man_pages/declareh.html)

---

1. **przypisywanie zmiennych**
```bash
<nazwa_zmiennej>=<typ_danych>
bool:
x=true
x=false
number:
x=1

string:
x="hello world"

array:
x=("array" 1 ("array2" "array3"))

assosciative array:
declare -A x
x["banana"]=5
x["apple"]=5

```
---

2. **odwolywanie sie do tych zmiennych**
```bash
echo $<nazwa_zmiennej> #-> przeczyta wartosc $<nazwa_zmiennej> (number, string)

for <nazwa_pojedynczego_elementu> in ${<nazwa_tablicy>[@]}; do
    echo $<nazwa_pojedynczego_elementu> #-> odwolywanie sie do wartosci tablicy w bashu
done

for <nazwa_pojedynczego_elementu> in ${!<nazwa_tablicy>[@]}; do
    echo $<nazwa_pojedynczego_elementu> #-> odwolywanie sie do indexu tablicy 
    echo ${<nazwa_tablicy>[$<nazwa_pojedynczego_elementu>]} #-> odwolywanie sie do zawartosci tablicy o danym indexie
done



```
---

3. **dzialania na zmiennych**
```bash
#dodawnie
value=$value1 + $value2
#odjemowanie
value=$value1 - $value2
#mnozenie
value=$value1 * $value2
#dzielenie
value=$value1 / $value2

#konkatenacja stringow
value=$value1$value2"przykladowy string"


```

---

4. **warunki i petle**
zanim przystapimy do pokazywania warunkow i petli warto sie dowiedziec jak porownywac zmienne w warunkach, aby porownywac zmienne zazwyczaj uzywa sie specialnych operatorow:
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
if [$x -eq 5]; then
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
else; then
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
for i in ${1..5}; do
    echo $i 
done

for i in ${array[@]}; do
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
#while loop wykonuje sie jesli warunek jest prawda a until loop wykonuje sie jesli warunek jest falszem
```

---

5. odczyt od uzytkownika
```bash
#aby odczytac input od uzytkownika trzeba uzyc read
read -p "ile masz lat?: " wiek 
echo $wiek
read -pa "Co dzisiaj jadles?" array
for i in ${array[@]}; do
    echo $i
done

```
wiecej mozna przeczytac na [read man page](https://linuxcommand.org/lc3_man_pages/readh.html)
---

6. **podawanie argumentow z terminala**
zazwyczaj argumenty przekazuje sie w nastepujacy sposob:
./<nazwa_pliku>.sh arg1 arg2 arg3 arg4 ...

```bash
#aby odwolac sie do zmiennych z terminala mozna uzyc $1 $2 $3 $4 itd. $0 to jest nazwa pliku ktorego uzywamy
#mozna tez uzyc $@ aby potraktowac te argumenty jakby byly w tablicy
echo "Pierwszy argument: $1"
echo "Drugi argument: $2"
echo "Wszystkie argumenty: $@"
```

---

7. **odwolywanie sie do innych plikow bash**
aby odwolac sie do innych plikow .sh mozna uzyc komendy source
```bash
source plik2.sh
#i teraz nam sie tak jakby uruchomil plik2.sh i mozna np. odwolywac sie do jego zmiennych
echo $plik2Int

```

---
#### Cele automatyzacji
Glownym celem automatyzacji jest pozbycie sie potrzeby wlasnorecznego wykonywania tych zadań

#### Jakie przyklady podam?



