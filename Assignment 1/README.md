## – Metode Numerice –

# Tema 1: Metode Numerice Matriceale

```
Publicare:21.03.2025 · Deadline hard:30.04.2025 23:
```

## Contents

- 1 Markov is coming ...(40p)
   - 1.1 Enunt,
   - 1.2 O explicat,ie vizuală
   - 1.3 Referint,e teoretice
      - 1.3.1 Matricea de adiacent,ă
      - 1.3.2 Matricea legăturilor
      - 1.3.3 Sistem de ecuat,ii liniare
      - 1.3.4 Algoritm euristic de căutare
      - 1.3.5 Codificarea labirintului
   - 1.4 Cerint,e
      - 1.4.1 Restrict,ii s,i precizări
- 2 Linear Regression(40p)
   - 2.1 Enunt,
      - 2.1.1 Algoritmi de optimizare
      - 2.1.2 Regularizare
      - 2.1.3 Format CSV
   - 2.2 Cerint,e
- 3 MNIST 101(40p)
   - 3.1 Enunt,
   - 3.2 Referint,e teoretice
      - 3.2.1 Adaptare a regresiei liniare: regresia logistică
      - 3.2.2 Neajunsurile regresiei logistice
      - 3.2.3 Extinderea de la regresia logistică la o ret,ea neurală. Perceptronul
      - 3.2.4 Predict,ie. Forward propagation
      - 3.2.5 Determinarea gradient,ilor. Backpropagation
      - 3.2.6 Init,ializarea parametrilor
   - 3.3 Cerint,e
      - 3.3.1 Restrict,ii s,i precizări
- 4 Regulament
   - 4.1 Arhivă
   - 4.2 Punctaj
      - 4.2.1 Reguli s,i precizări
   - 4.3 Alte precizări


## Obiectivele temei de casă

```
Prima temă de casă la Metode Numerice vizează următoarele obiective:
```
- Familiarizarea cu mediul de programareGNU Octaves,i facilităt,ile oferite de acesta;
- Folosirea matricelor s,i a sistemelor de ecuat,ii liniare pentru a modela probleme reale, întâlnite în viat,a
    de zi cu zi, precum lant,urile Markov;
- Introducerea în învăt,area supervizată^1.

## Changelog

- 21.03.2025:S-a publicat tema 1,momentan fără checker.

(^1) en.Supervised ML


## 1 Markov is coming ...(40p)

### 1.1 Enunt,

După ce a obt,inut note foarte bune la materiile de pe semestrul întâi (în mod special la programare s,i
la algebră liniară), Mihai s-a decis să îs,i ocupe timpul cu o problemă interesantă, pentru care îs,i propune să
găsească o solut,ie cât mai performantă.

Fiind pasionat de tehnologie, el s,i-a cumpărat un robot,el pe care îl poate programa după cum dores,te.
În timpul liber, a mai construit s,i un mic labirint pe care intent,iona să testeze robot,elul.

Acum, Mihai dores,te să plaseze robot,elul undeva în labirint s,i să-l programeze astfel încât să aleagă, la
fiecare pas, cea mai bună direct,ie pentru a reus,i să evadeze. Robot,elul se consideră evadat dacă găses,te una
din ies,irile consancrate ale labirintului.

Pentru că Mihai nu este încă familiarizat cu algoritmii avansat,i de căutare (căci aces,tia se învat,ă abia
în anul 2), îs,i propune să plece de la o problemă mai simplă, iar apoi să implementeze un algoritm simplu,
astfel: Având la dispozit,ie un labirint s,i o pozit,ie de plecare, care este probabilitatea ca robotul meusă
ajungă într-o zonă de câs,tig, dacă la fiecare pas elalege o direct,ie aleatoare de deplasaredintre
cele disponibile? De asemenea, cum as,putea folosi probabilităt,ile determinate anterior pentru determinarea
unei căi pentru robot prin labirintul meu, într-o manierămai eficientădecât o căutare exhaustivă?

### 1.2 O explicat,ie vizuală

```
Figura 1: Exemplu de labirint
```
Să presupunem labirintul de mai sus, foarte simplu reprezentat sub forma unei matrice pătratice, în care
pozit,ia de plecare a robot,elului nostru este colt,ul din stânga–sus. Considerăm că punctul de pornire are
coordonatele(1,1). Robotul va alege la fiecare pas să se mute într-o nouă celulă a labirintului pe care nu a
vizitat-o anterior, putând să se deplaseze câte o pătrăt,ică în sus, în jos, la stânga sau la dreapta, însă nu are
voie să meargă pe diagonală.


Spre exemplu, din pozit,ia de start, acesta va vizita celula de coordonate(2,1), apoi celulele de coordonate
(3,1)s,i(4,1), iar apoi va alege între cele 2 celule adiacente pe cea care are probabilitatea mai mare de a
ajunge la o ies,ire câs,tigătoare din labirintul nostru. Ies,irile în cadrul problemei studiate sunt de 2 tipuri:

- Ies,iri care duc la câs,tig.Ele sunt ies,irile marcate cu verde pe figura de mai sus, s,i se suprapun tot
    timpul cu limita superioară, respectiv cu cea inferioară ale labirintului. În momentul în care robotul
    alege să iasă din labirint pe una dintre aceste ies,iri, se poate spune că acesta a câs,tigat (probabilitatea
    de câs,tig este 1).
- Ies,iri care duc la pierderea jocului. Ele sunt ies,irile marcate cu ros,u pe figura de mai sus, s,i
    se suprapun tot timpul cu limitele laterale (stânga / dreapta) ale labirintului. În momentul în care
    robotul alege să iasă din labirint prin una dintre aceste ies,iri, se poate spune că acesta a pierdut jocul
    (probabilitatea de câs,tig în această stare este 0).

În interiorul labirintului, pot exista s,i peret,i care să nu permită trecerea robot,elului între 2 celule
adiacente din punct de vedere spat,ial. Spre exemplu, în figura de mai sus, nu se poate merge din celula
(1,1)direct în celula(1,2). Astfel, în orice moment de timp, robotul va avea un număr de cel mult 4
alegeri corespunzătoare direct,iilor în care se poate deplasa, din care acesta o poate alege complet aleator (cu
probabilitate egală) pe oricare dintre ele.

### 1.3 Referint,e teoretice

Pentru modelarea situat,iei prezentate vom folosi lant,uri de probabilităt,i, cunoscute sub denumirea de
lant,uri Markov. Lant,urile Markov sunt deosebit de utile în teoria probabilităt,ilor, având aplicat,ii în
domenii precum economie, fiabilitatea sistemelor dinamice, respectiv în algoritmii de inteligent,ă artificială.
Google Page Rankeste, de asemenea, o formă modificată a unui lant,Markov.

```
Figura 2: Ilustrat,ie simplă a unui lant,Markov
```
Structura de date de bază în cadrul lant,urilor Markov este graful orientat, în care nodurile reprezintă
stările, iar fiecare muchie existentă între două stări reprezintă o probabilitate nenulă de trecere de la o stare
init,ială la o stare finală. Evident, pentru orice stare, suma tuturor probabilităt,ilor de tranzit,ie este egală cu
unitatea. Matematic, acest lucru se poate reprezenta astfel:

```
Xn
```
```
j=
```
```
pij= 1,∀i∈ 1 ,n (1)
```

Putem astfel să aplicăm o idee asemănătoare s,i în problema noastră. Vom asocia fiecărei celule a
labirintului câte o stare s,i vom numerota stările, începând cu colt,ul din stânga-sus, ca în figura de mai jos:

```
Figura 3: Exemplu de numerotare a unui labirint de dimensiune 3 × 3
```
În afară de stările corespunzătoare amplasării robotului într-una dintre celulele labirintului, vom mai
avea nevoie de două stări suplimentare:

- Starea WIN.Aceasata va fi starea în care putem considera că am câs,tigat, din care nu mai putem
    ies,i ulterior;
- Starea LOSE.Aceasta va reprezenta starea în care putem considera că am pierdut.

```
Odată adăugate s,i acestea în graful nostru orienat, discutăm de următorul lant,Markov:
```
```
Figura 4: Lant,ul Markov asociat exemplului de labirint din fig. 5
```
Pentru acest lant,Markov (care, din punct de vedere abstract, reprezintă un graf orientat în care fiecare
muchie are o anumită greutate, egală cu probabilitatea descrisă mai sus), avem nevoie de o caracterizare
concretă (cu alte cuvinte, de un mod de stocare) care să ne ajute în ret,inerea efectivă a lant,ului. În continuare,
vom prezenta câteva caracterizări posibile.


#### 1.3.1 Matricea de adiacent,ă

Matricea de adiacent,ă a unui graf orientat, asemănătoare cu conceptul de matrice de adiacent,ă a unui
graf neorientat, se poate defini prin următoarea relat,ie:

```
A= (Aij)i,j∈ 1 ,n∈{ 0 , 1 }n×n,undeAij=
```
##### (

```
1 , dacă există o tranzit,ie din stareaiîn stareaj
0 , altfel
```
În situat,ia grafului din fig. 4, reprezentat prin 11 stări (9 stări corespunzătoare celulelor labirintului,
respectiv 2 stări suplimentare, WIN s,i LOSE,în această ordine), matricea de adiacent,ă A a grafului este
din{ 0 , 1 }^11 ×^11 s,i are următoarea formă:

##### A=

#####                  

##### 0 0 0 1 0 0 0 0 0 1 0

##### 0 0 1 0 0 0 0 0 0 0 0

##### 0 1 0 0 0 1 0 0 0 0 1

##### 1 0 0 0 1 0 1 0 0 0 0

##### 0 0 0 1 0 1 0 0 0 0 0

##### 0 0 1 0 1 0 0 0 1 0 0

##### 0 0 0 1 0 0 0 1 0 1 0

##### 0 0 0 0 0 0 1 0 1 0 0

##### 0 0 0 0 0 1 0 1 0 0 1

##### 0 0 0 0 0 0 0 0 0 1 0

##### 0 0 0 0 0 0 0 0 0 0 1

#####                  

Se observă că sectorulA(1 : 9,1 : 9)^2 este simetric, întrucât peret,iinusunt unidirect,ionali (dacă tranzit,ia
de la stareaila stareajeste posibilă, atunci s,i tranzit,ia inversă este posibilă).

#### 1.3.2 Matricea legăturilor

Matricea legăturilor reprezintă o formă mai potentă a matricei de adiacent,ă, fiind foarte asemănătoare
cu aceasta – singura diferent,ă este dată de semnificat,ia elementelor ce o populează. În cazul matricei de
legături, elementele sunt chiar probabilităt,ile de tranzit,ie de la o stare la alta în lant,ul Markov. Folosind
notat,ia de probabilitatepijintrodusă anterior (ec. 1), ea se defines,te astfel:

```
L= (pij)i,j∈ 1 ,n∈[0,1]n×n⇔Lij=
```
##### (

```
pij, 0 < pij≤ 1
0 , altfel
```
```
Pentru exemplul de lant,din fig. 4, matricea legăturilor este următoarea:
```
##### L=

##### 

##### 

##### 

##### 

#####             

##### 0 0 0 1 / 2 0 0 0 0 0 1 / 2 0

##### 0 0 1 0 0 0 0 0 0 0 0

##### 0 1 / 3 0 0 0 1 / 3 0 0 0 0 1 / 3

(^1) / 3 0 0 0 1 / 3 0 1 / 3 0 0 0 0
0 0 0 1 / 2 0 1 / 2 0 0 0 0 0
0 0 1 / 3 0 1 / 3 0 0 0 1 / 3 0 0
0 0 0 1 / 3 0 0 0 1 / 3 0 1 / 3 0
0 0 0 0 0 0 1 / 2 0 1 / 2 0 0
0 0 0 0 0 1 / 3 0 1 / 3 0 0 1 / 3
0 0 0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 0 0 1

##### 

##### 

##### 

##### 

#####             

(^2) Am utilizat notat,ia standard din Octave, adicăA(1 : 9,1 : 9)se referă la submatricea formată din intersect,ia primelor 9
linii cu primele 9 coloane.


Observăm că matricea este o matrice stochastică pe linii^3 ., ceea ce îi aduce o mult,ime de proprietăt,i
interesante, discutate deja în cadrul cursului de Metode Numerice.

#### 1.3.3 Sistem de ecuat,ii liniare

Pe lângă abordările anterioare, putem t,ine minte lant,ul Markov s,i ca pe o formulare ce se pretează pe
un alt stil de problemă: rezolvarea unui sistem de ecuat,ii liniare.

Mai exact, să considera un vectorp∈Rmnreprezentând probabilităt,ile de câs,tig pentru fiecare celulă
din labirint, undem∈N∗s,in∈N∗sunt dimensiunile labirintului; spre exemplu, în cazul fig. 5,p∈R^9.
Popularea acestui vector se face respectând numerotarea stărilor descrisă anterior.

Să experimentăm put,in cu cazul în care robot,elul nostru se află în starea 1. Atunci, el poate efectua
următoarele tranzit,ii / deplasări valide prin labirint:

- Poate trece înstarea 4, cu probabilitatea^1 ⁄ 2 ;
- Poate trece înstarea WINs,i să câs,tige, tot cu probabilitatea^1 ⁄ 2.

```
Astfel, starea 1 va fi caracterizată prin următoarea ecuat,ie:
```
```
p 1 =
```
##### 1

##### 2

```
·p 4 +
```
##### 1

##### 2

```
·pWIN,darpWIN= 1
```
```
⇒p 1 =
```
##### 1

##### 2

```
·p 4 +
```
##### 1

##### 2

```
În mod similar, se pot scrie ecuat,ii pentru toate stările:









```
```








```
```
p 1 =^12 ·p 4 +^12
p 2 =p 3
p 3 =^13 ·p 2 +^13 ·p 6
p 4 =^13 ·p 1 +^13 ·p 5 +^13 ·p 7
p 5 =^12 ·p 4 +^12 ·p 6
p 6 =^13 ·p 3 +^13 ·p 5 +^13 ·p 9
p 7 =^13 ·p 4 +^13 ·p 8 +^13
p 8 =^12 ·p 7 +^12 ·p 9
p 9 =^13 ·p 6 +^13 ·p 8
```
```
După cum ne-am obis,nuit, putem trece acest sistem în forma sa matriceală:
             
p 1
p 2
p 3
p 4
p 5
p 6
p 7
p 8
p 9
```
#####              

##### =

#####              

##### 0 0 0 1 / 2 0 0 0 0 0

##### 0 0 1 0 0 0 0 0 0

##### 0 1 / 3 0 0 0 1 / 3 0 0 0

(^1) / 3 0 0 0 1 / 3 0 1 / 3 0 0
0 0 0 1 / 2 0 1 / 2 0 0 0
0 0 1 / 3 0 1 / 3 0 0 0 1 / 3
0 0 0 1 / 3 0 0 0 1 / 3 0
0 0 0 0 0 0 1 / 2 0 1 / 2
0 0 0 0 0 1 / 3 0 1 / 3 0

#####              

##### ·

#####              

```
p 1
p 2
p 3
p 4
p 5
p 6
p 7
p 8
p 9
```
#####              

##### +

#####              

(^1) / 2
0
0
0
0
0
(^1) / 3
0
0

#####              

##### (2)

(^3) Suma elementelor de pe fiecare linie este egală cu 1


În sistemul anterior, vectorul termenilor liberi (evident,iat cu albastru) provine din acele elemente care
init,ial erau combinat,ii liniare depWIN.

```
Am făcut toată această prelucrare în ec. 2 pentru a putea scrie următorul produs:
```
```
p=Gp+c
```
Această formă se pretează perfect metodei Jacobi de rezolvare în care identificămGs,icdrept matricea,
respectiv vectorul de iterat,ie. De aceea, vom opta pentru această metodă iterativă pentru a solut,iona
sistemul. În cazul nostru particular (fig. 5), raza spectrală a matriceiGare valoareaρ(G)≈ 0. 85192 , ceea
ce înseamnă că Jacobi va converge.

```
Pentru cei curios,i, solut,ia este: 








```
```








```
```
p 1 ≈ 0. 84615
p 2 ≈ 0. 15385
p 3 ≈ 0. 15385
p 4 ≈ 0. 69231
p 5 ≈ 0. 50000
p 6 ≈ 0. 30769
p 7 ≈ 0. 73077
p 8 ≈ 0. 50000
p 9 ≈ 0. 26923
```
#### 1.3.4 Algoritm euristic de căutare

Rezultatele de mai sus reflectă o intuit,ie evidentă: stările care sunt mai„apropiate”destarea WIN
au o probabilitate mai mare de câs,tig, iar cele care sunt apropiate destarea LOSEau o probabilitate mai
mică. Acesta este motivul pentru care am putea gândi un algoritm de căutareeuristiccu ajutorul căruia
robotul ar putea ajunge din pozit,ia init,ială la una din stările câs,tigătoare.

Un algoritm de căutare euristic este un algoritm care nu ne furnizează o solut,ie optimă (în cazul nostru,
un drum minim) pentru toate cazurile posibile, însă are avantajul de a fi foarte rapid în comparat,ie cu
algoritmii de căutare exhaustivi (clasici).

```
Apelăm la un algoritm greedy simplu, bazat de DFS, care are pseudocodul de pe următoarea pagină.
În pseudocodul de mai jos, parametrii funct,iei de căutare sunt următorii:
```
- start_position, reprezentând pozit,ia de start a robotului în codificarea utilizată până la acest moment
    (un indice de la 1 lan·minclusiv, undens,imsunt dimensiunile labirintului);
- probabilities, prin care se înt,elege vectorul probabilităt,ilor fiecărei stări în parte, de lungimen·m+ 2
    (acesta este de fapt vectorul extins al probabilităt,ilor, spre deosebire de cel calculat anterior folosind
    metoda iterativă – cont,ine s,i probabilităt,ile asociate stărilor WIN, respectiv LOSE);
- adjacency_matrix, matricea de adiacent,ă a labirintului propus, în maniera în care aceasta a fost
    descrisă mai devreme.

Algoritmul întoarce un vector de indecs,i reprezentativi celuleleor / stărilor labirintului, urmând ca aces,tia
să fie tradus,i ulterior în perechi linie–coloană pentru a putea fi interpretat,i mai us,or.


Algoritm euristic

```
1:procedureheuristic_greedy(start_position, probabilities, adjacency_matrix)
2: path←[start_position]
3: visited[start_position]←True
4: whilepathis not emptydo
5: position←top() / last element of the path vector
6: ifposition is the WIN statethen
7: returnpath
8: ifposition has no unvisited neighboursthen
9: erasepositionfrom the end of thepath
10: neigh←the unvisited neighbour (with greatest probability to reach WIN) of the currentposition
11: visited[neigh]←True
12: path←[path, neigh]
13: returnpath(since there is no path to the WIN state)
```
În figura de mai jos, am evident,iat drumul pe care îl va alege robotul, luând în considerare probabilităt,ile
calculate anterior (vom porni în acest exemplu din starea / celula 2).

```
Figura 5: Exemplu de drum obt,inut folosind algoritmul euristic
```
#### 1.3.5 Codificarea labirintului

Pentru a prelucra labirintul sub forma unor date de intrare, este necesară o reprezentare a labirintului
într-o formă condensată. Astfel, Mihai se inspiră dintr-un algoritm pe care l-a găsit într-un alt context, cel
al graficii pe calculator, numit algoritmul Cohen-Sutherland.

Ideea preluată din algoritmul original este de a codifica binar zidurile ce separă celule adiacente spat,ial:
labirintul nostru poate fi stocat drept o matrice cum×nintrări, numere întregi reprezentate pe 4 bit,i de
formab 3 b 2 b 1 b 0 (2), unde fiecare bit activ (setat pe 1) reprezintă o posibilă direct,ie de deplasare obturată de

un perete al labirintului. În cazul nostru, ne însus,im următoarea codificare:

- Bitulb 3 setat pe 1 indică unzid la nordul celulei;
- Bitulb 2 setat pe 1 indică unzid la sudul celulei;


- Bitulb 1 setat pe 1 indică unzid la estul celulei;
- Bitulb 0 setat pe 1 indică unzid la vestul celulei;

```
Figura 6: Reprezentarea direct,iilor în algoritmul Cohen-Sutherland, alături de un exemplu
```
```
În situat,ia labirintul nostru, codificarea ar fi:
```
```
Figura 7: Codificarea peret,ilor labirintului pentru exemplul dat
```
Este foarte important să observat,i faptul că peret,ii sunt bidirect,ionali (anume că, des,i o codificare
aleatoare ar permite tranzit,ii unidirect,ionale între stări, noi vom trata exclusiv cazul peret,ilor care blochează
tranzit,iile în labirint în ambele sensuri între oricare stări adiacente).

### 1.4 Cerint,e

În urma parcurgerii materialului teoretic furnizat anterior, suntet,i pregătit,i să implementat,i următoarele
funct,ii în Matlab:

- function [Labyrinth] = parse_labyrinth(file_path)

```
Funct,iaparse_labyrinthva primi o cale relativă către un fis,ier text unde se află reprezentarea
codificată a labirintului, as,a cum a fost descrisă în sect,iunea de teorie dedicată.
Formatul fis,ierului de intrare va fi următorul:
```

```
1 m n
2 l_11 l_12 l_13 ... l_1n
3 l_21 l_22 l_23 ... l_2n
4 l_31 l_32 l_33 ... l_3n
5 ...
6 l_m1 l_m2 l_m3 ... l_mn
```
- function [Adj] = get_adjacency_matrix(Labyrinth)

```
Funct,iaget_adjacency_matrixva primi matricea codificărilor rezultată după pasul anterior
s,i va întoarce matricea de adiacent,ă a grafului / lant,ului Markov.
```
- function [Link] = get_link_matrix(Labyrinth)

```
Funct,iaget_link_matrixva primi matricea codificărilor unui labirint valid s,i va returna ma-
tricea legăturilor asociată labirintului dat.
```
- function [G, c] = get_Jacobi_parameters(Link)

```
Funct,iaget_Jacobi_parametersva primi matricea legăturilor obt,inută anterior s,i va returna
matricea de iterat,ie s,i vectorul de iterat,ie pentru metoda Jacobi.
```
- function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)

```
Funct,iaperform_iterativeva primi matricea s,i vectorul de iterat,ie, o aproximat,ie init,ială
pentru solut,ia sistemului, o tolerant,ă (eroare relativă maxim acceptabilă pentru solut,ia aproximativă
a sistemului, între doi pas,i consecutivi) s,i un număr maxim de pas,i pentru execut,ia algoritmului.
```
- function [path] = heuristic_greedy(start_position, probabilities, Adj)

```
Funct,iaheuristic_greedyva primi o pozit,ie de start (un index al unei celule / stări din
intervalul 1 ,mn), vectorul extins al probabilităt,ilor (incluzând cele două probabilităt,i pentru stările
WIN s,i LOSE) s,i matricea de adiacent,ă a lant,ului Markov.
Va returna apoi o cale validă către starea de WIN. Se garantează că labirintul (s,i, implicit, graful
asociat) este conex, s,i deci va exista întotdeauna o cale de câs,tig validă.
```
- function [decoded_path] = decode_path(path, lines, cols)

```
Funct,iadecode_pathva primi o cale validă (sub forma unui vector coloană) s,i dimesniunile
labirintului s,i va returna un vector de perechi (matrice cu două coloane), fiecare pereche reprezentând
linia s,i coloana celulei cu codificarea dată.
```
#### 1.4.1 Restrict,ii s,i precizări

```
Înainte să vă apucat,i de lucru, ar fi bine să luat,i aminte că:
```
- LabirintulNUeste neapărăt pătratic (numărul de coloane nu trebuie să coincidă cu numărul de linii);
- Se garantează faptul că labirintul este conex s,i că există mereu câte o cale către ies,irea / starea de
    WIN s,i către cea de LOSE;


- Observat,i că matricele de adiacent,ă s,i de legătură sunt matrice mari, dar rare. EsteOBLIGATORIE
    ret,inerea acestor matrice s,i a matricelor derivate (precum matricea de iterat,ie sau vectorul de iterat,ie)
    sub forma unormatrice rare. Octave vă oferă posibilitatea stocării matricelor rare într-o manieră
    mult mai eficientă decât cea convent,ională, anume prin stocarea elementelor nenule s,i a pozit,iilor
    acestora. De asemenea, există funct,ii specializate pentru lucrul cu matrice rare, pe care vă încurajăm
    să le descoperit,i aici.
- Pentru toate funct,iile din cadrul acestui task, este interzisă folosirea funct,ieidlmread(din cauza
    incompatibilităt,ii rezultatelor ce pot apărea între diverse versiuni de GNU Octave). Folosit,i alte
    modalităt,i de parsare în acest caz.

Pentru restrict,iile general valabile, verificat,i sfârs,itul acestui document.


## 2 Linear Regression(40p)

### 2.1 Enunt,

Având o pasiune profundă s,i pentruMetode Numerice, Mihai este interesat atât de Învăt,area Au-
tomată^4 , cât s,i de Inteligent,a Artificială^5 , s,i i-ar plăcea să le exploreze mai în detaliu (atât cât poate). Curios
din fire, acesta începe să citească despre cum poate să proiecteze un model de învăt,are automată care să se
antreneze pe baza unui set de date existent ce are o anumită dimensiune.

Cu ajutorul unui algoritm de Învăt,are Automată Supervizată^6 , numit în literatura de specialitateLinear
Regression, Mihai dores,te să înt,eleagă mai multe despre manipulareapredict,iilors,i aerorilor^7 ce pot
să apară în prelucrarea computat,ională.

În esent,ă,Linear Regressionpoate fi interpretat geometric drept o dreaptă (la ALGAED at,i întâlnit
not,iunea dedreaptă de regresie) careminimizeazăradicalul sumei pătratelor distant,elor punctelor (datelor)
ce fac parte dintr-o mult,ime de interes^8.

```
Figura 8: Reprezentarea grafică a unei drepte de regresie ce trece printr-un set de date.
```
Din punct de vedere funct,ional,Linear Regressionse ocupă demics,orarea, până într-o anumită
limită, afunct,iei de costs,i apierderii(aceste concepte vor fi detaliate în paragrafele ce urmează).
Evident, există mai multe tipuri deLinear Regression(precum regresia simplă, regresia multiplă s,i cea
logistică).

În urma cercetărilor sale, Mihai se hotărăs,te să foloseascăMultiple Linear Regressionpentru a putea
facepredict,iicu privire la pret,ul apartamentelor din zona sa, întrucât nu mai dores,te să locuiască cu ai lui,
vrând să îs,i manifeste independent,a fat,ă de ei.

```
O astfel de predict,ie poate fi scrisă sub forma unei funct,iihθ:Rn→R, cuθ∈Rn+1, funct,ie ce se poate
```
(^4) en.Machine Learning
(^5) en.Artificial Intelligence
(^6) en.Supervised Machine Learning
(^7) Conceptele debiass,ivariance
(^8) Acest fenomen este cunoscut s,i dreptaproximare în sensul celor mai mici pătrates,i va fi studiat în cadrul metodelor
numerice funct,ionale (a doua parte a materiei).


defini după cum urmează:
hθ(x) =θ 0 +θ 1 x 1 +θ 2 x 2 +...+θnxn+ε

```
În scrierea anterioară, am folosit următoarele notat,ii:
```
- hθ(x)reprezintă valoareaprezisăpentru funct,ionalităt,ile(x 1 ,x 2 ,...,xn)(acestea se mai numesc s,i
    predictorisaufeatures);
- θ 1 ,...,θn∈Rreprezintă coeficient,ii specifici modelului de învăt,are automată (aces,tia mai poartă
    denumirea deweights);
- θ 0 ∈Rreprezintă valoarea luihθ(x)atunci când tot,i predictorii sunt 0, adicăx= 0 (în literatură
    poartă numele deintercept);
- ε∈Reste eroarea (diferent,aîn modul) dintre valoarea prezisă s,i cea actuală a luihθ(x).

Ei bine, aces,ti coeficient,iθ 0 ,θ 1 ,...,θnce formeazăθdescriu cât de capabil este un model de învăt,are
automată pentru a face predict,ii cât mai bune (apropiate de realitate) după primirea de date noi, ce nu au
mai fostvăzutede către acesta. Putem as,adar să definimfunct,ia de cost, o funct,ie ce returnează eroarea
dintre valoarea actuală s,i cea prezisă, s,i să încercăm să ominimizăm.

```
Funct,ia de costJ:Rn+1→Rva avea următoarea scriere:
```
```
J(θ) =J(θ 0 ,θ 1 ,...,θn) =
```
##### 1

```
2 m
```
```
Xm
```
```
i=
```
```
h
hθ
```
##### ␐

```
x(i)
```
##### ␑

```
−y(i)
```
```
i 2
```
```
Am utilizat următoarele notat,ii în scrierea de mai sus:
```
- θ 1 ,...,θn∈Rreprezintă coeficient,ii specifici modelului, la fel ca mai sus;
- m∈N∗reprezintă numărul de antrenamente^9 ;
- x(i)reprezintă intrările pentru antrenamentele de ordini∈N^10 , ceea ce înseamnă căhθ(x(i))este
    ipoteza (valoarea prezisă) pentru antrenamentul cu indexuli;
- y(i)reprezintă ies,irile pentru antrenamentele de ordini∈N.

NUconfundat,i notat,iaγ(i)cu ridicarea la putere sau cu derivarea! Facem referire strict la indexul
(numărul) iterat,iei curente.

#### 2.1.1 Algoritmi de optimizare

Pe parcursul studiului său, Mihai a mai descoperit s,i faptul că există anumit,i algoritmi de optimizare
pentru a determina coeficient,ii modelului, s,i anumemetoda gradientului descendent^11 , respectivNor-
mal Equation.

Metoda gradientului descendentreprezintă o modalitate generală pentru optimizarea funct,iilor
convexe (în cazul nostru, o vom aplica funct,iei de cost), ce poate determina minimul local al funct,iei de
interes. Metoda utilizează o tehnică iterativă.

Având în vedere că funct,ia de costJ(θ)are unminim global unic, putem spune că orice minim
local este, de asemenea, un minim global; cu alte cuvinte, funct,ia de cost esteconvexă, iar acest lucru ne
garantează faptul că orice metodă de optimizare va converge către minimul global al funct,iei de cost.

Această metodă îs,i efectuează pas,ii în funct,ie de gradientul funct,iei de cost s,i de valoarea aleasă pentru
rata de învăt,are, notată la noi cuα∈R.

(^9) en.training samples
(^10) en.ithtraining example
(^11) en.Gradient Descent


Amintim că prin gradientul funct,iei de cost înt,elegem vectorul fomat din derivatele part,iale în raport cu
θ 1 ,...,θn. Cu alte cuvinte:

##### ∇J=

##### 

##### 

##### 

```
∂J
∂θ 1 (θ)
..
.
∂J
∂θn(θ)
```
##### 

##### 

```
,unde
```
##### ∂J

```
∂θj
```
```
(θ) =
```
##### 1

```
m
```
```
Xm
```
```
i=
```
```
h
hθ
```
##### ␐

```
x(i)
```
##### ␑

```
−y(i)
```
```
i
·x(ji),∀j∈ 1 ,n
```
```
Transformarea pe care această metodă o propune este dată de relat,ia:
```
```
θj:=θj−α·
```
##### ∂J

```
∂θj
```
```
(θ),∀j∈ 1 ,n
```
Normal Equationreprezintă o metodă care implică o ecuat,ie directă pentru a determina coeficient,ii
θ 1 ,...,θn∈Rspecifici modelului de interes. Această tehnică este utilă în situat,ia în care lucrăm cu seturi
restrânse (mici) de date. Se cristalizează următoarea ecuat,ie:

```
θ= (XTX)−^1 XTY
```
```
unde:
```
- X∈Rm×nreprezintă matricea ce stocheazămvectori liniex(i),i∈ 1 , 2 ,...,m, fiecare vector linie
    avândnvalori specifici predictorilor.
- Y∈Rm×^1 reprezintă vectorulcoloanăce ret,inemvaloriactuale.
- θ∈Rn×^1 reprezintă vectorulcoloanăce ret,inencoeficient,iθ 1 ,...,θn∈Rspecifici modelului de
    învăt,are automată.

O problemă vizibilă cu acest algoritm este că determinarea inversei unei matrice implică un cost computat,ional
ridicat pentru seturi mari de date. Pentru a mitiga această dificultate, vom folosi o altă metodă(prezentată
la curs)pentru a rezolva sistemul, anumemetoda gradientului conjugat^12.

```
Reamintim algoritmul în cauză:
```
Conjugate Gradient Method

```
1:procedureconjugate_gradient(A, b, x_0, tol, max_iter)
2: r(0)←b−Ax(0)
3: v(1)←r(0)
4: x←x 0
5: tolsquared←tol^2
6: k← 1
7: whilek <=maxiterandr(k-1)
T
r(k-1)> tolsquareddo
```
```
8: tk←
```
```
r(k-1)
T
r(k - 1)
vkTAvk
9: x(k)←x(k-1)+tkv(k)
10: r(k)←r(k-1)−tkAv(k)
```
```
11: sk←
```
```
r(k)
T
r(k)
r(k-1)Tr(k-1)
12: v(k+1)←r(k)+skv(k)
13: k←k+ 1
14: returnx
```
(^12) NUuitat,i faptul că această metodă necesită ca matricea sistemului să fiepozitiv definită.


#### 2.1.2 Regularizare

În domeniul Învăt,ării Automate,regularizareareprezintă o metodă ce poate fi aplicată unui model de
învăt,are automată astfel încât acesta să devină mult maigeneral, adică să aibă eroarea devariant,ăcât
mai mică după introducerea denoi dateîn urma antrenamentului său.

```
Figura 9: Reprezentarea grafică a unei drepte de regresie ce trece printr-un set de date de
antrenament (punctele verzi) s,i printr-un set de date de testare (punctele maro). Se poate
observa eroarea de variant,ă (radicalul sumei pătratelor distant,elor punctelor maro)
```
Având în vedere cele ment,ionate, Mihai este interesat în două tehnici de regularizare,Regularizarea
L1, respectivRegularizarea L2.

Regularizarea L2, denumită s,iRidge Regression, se referă la a găsi o dreaptă de regresie care să
treacă optim prin punctele care definesc setul de date de testare, introducând, însă, o mică eroare de bias.
Cu alte cuvinte, dreapta găsită nu va minimiza pe deplin radicalul sumei pătratelor distant,elor punctelor
din setul de date de antrenament.

În esent,ă, această metodă se axează pe mics,orarea coeficient,ilorθ 0 ,θ 1 ,...,θn∈Rastfel încât aces,tia
să fie apropiat,i de 0, efectul fiindslăbireadependent,ei dintrey(i)s,i anumit,ix 1 ,x 2 ,...,xndinx(i), adică
ies,irea de ordini∈Nva depinde mai put,in de predictori.

```
Funct,ia regularizată de costJL 2 :Rn+1→Rva avea următoarea scriere:
```
```
JL 2 (θ) =JL 2 (θ 0 ,θ 1 ,...,θn) =
```
##### 1

```
2 m
```
```
Xm
```
```
i=
```
```
h
hθ
```
##### ␐

```
x(i)
```
##### ␑

```
−y(i)
```
```
i 2
+λ
```
```
Xn
```
```
j=
```
```
θj^2
```
```
Unde:
```
- λ

```
Pn
j=1θ
2
jreprezintă termenul specific regularizării L2;
```
- λ∈R+este parametrul care controleazăputerea regularizării, acesta se poate determina folosind
    tehnica cross-validation, însă noi îl vom oferi la partea de implementare.


Regularizarea L1, denumită s,iLasso Regression, este similară cu regularizarea L2, cu except,ia
faptului că anumit,iθ 0 ,θ 1 ,...,θn∈Rpot fi chiar 0, adicăse poate elimina definitivdependent,a ies,irii
de ordini∈Nde anumit,ipredictori. Scopul rămâne acelas,i, s,i anume mics,orarea complexităt,ii modelului
de învăt,are automată.

```
Funct,ia regularizată de costJL 1 :Rn+1→Rva adopta următoarea scriere:
```
```
JL 1 (θ) =JL 1 (θ 0 ,θ 1 ,...,θn) =
```
##### 1

```
m
```
```
Xm
```
```
i=
```
```
h
y(i)−hθ
```
##### ␐

```
x(i)
```
```
␑i 2
+λ∥θ∥ 1
```
```
Unde:
```
- ∥θ∥ 1 reprezintă norma L1 a coeficient,ilor modelului, adică∥θ∥ 1 =|θ 0 |+|θ 1 |+···+|θn|.
- λ∈R+esteparametrulcare controlează regularizarea.

#### 2.1.3 Format CSV

Pentru realizarea funct,iei care implică metodagradientului descendent, vet,i avea la dispozit,ie setul
de date de antrenare în format CSV.

Pentru a exemplifica, ilustrăm tabelar primele 24 de intrări (doar 9 coloane din cele 13) din setul de date
propus:

```
Price Area Bedrooms Bathrooms Stories Mainroad Guestroom Basement Hot water
13300000 7420 4 2 3 yes no no no
12250000 8960 4 4 4 yes no no no
12250000 9960 3 2 2 yes no yes no
12215000 7500 4 2 2 yes no yes no
11410000 7420 4 1 2 yes yes yes no
10850000 7500 3 3 1 yes no yes no
10150000 8580 4 3 4 yes no no no
10150000 16200 5 3 2 yes no no no
9870000 8100 4 1 2 yes yes yes no
9800000 5750 3 2 4 yes yes no no
9800000 13200 3 1 2 yes no yes no
9681000 6000 4 3 2 yes yes yes yes
9310000 6550 4 2 2 yes no no no
9240000 3500 4 2 2 yes no no yes
9240000 7800 3 2 2 yes no no no
9100000 6000 4 1 2 yes no yes no
9100000 6600 4 2 2 yes yes yes no
8960000 8500 3 2 4 yes no no no
8890000 4600 3 2 2 yes yes no no
8855000 6420 3 2 2 yes no no no
8750000 4320 3 1 2 yes no yes yes
8680000 7155 3 2 1 yes yes yes no
8645000 8050 3 1 1 yes yes yes no
```
În acest caz, ies,irea (variabilay) reprezintă coloanaPrice, iarpredictoriix 1 ,x 2 ,...,x 12 sunt toate
celelalte coloane.


### 2.2 Cerint,e

Având în vedere expunerea suportului teoretic s,i problema ce se dores,te a fi rezolvată, avet,i de imple-
mentat următoarele funct,ii:

- function [Y, InitialMatrix] = parse_data_set_file(file_path)

```
Funct,iaparse_data_set_fileva primi o cale relativă către un fis,ier text unde se află datele
pentru un set oarecare.
Formatul fis,ierului de intrare va fi acesta:
```
```
1 m n
2 Y_11 x_11 x_12 x_13 ... x_1n
3 Y_21 x_21 x_22 x_23 ... x_2n
4 Y_31 x_31 x_32 x_33 ... x_3n
5 ...
6 Y_m1 x_m1 x_m2 x_m3 ... x_mn
```
```
În acest caz,neste numărul de predictori, iarmse refera la numărul vectorilor de predictori
x 1 ,x 2 ,...,xns,i la dimensiunea vectorului Y de ies,ire.InitialMatrixreprezintă o matrice cu tipuri de
datedistincte!, adică stochează atât tipuri numerice, cât s,i string-uri. Pentru a gestiona acest lucru,
putet,i folosi tipulCelldinOctave.
```
- function [FeatureMatrix] = prepare_for_regression(InitialMatrix)

```
Funct,iaprepare_for_regressionmodelează matricea anterioară astfel încât să cont,ină doar tipuri
numerice. Cu alte cuvinte, fiecare pozit,ie din matrice ce cont,ine string-ul ’yes’ se înlocuies,te cu
tipul numeric (numărul) 1, iar fiecare pozit,ie ce cont,ine string-ul ’no’ se înlocuies,te cu tipul numeric
(numărul) 0. Pentru pozit,iile ce au aceste valori’semi-furnished’,’unfurnished’sau’furnished’, acestea
se vordescompuneîn două pozit,ii cu valori numerice de 0 s,i 1.
Fie următoarele cazuri:
```
- Dacă pozit,ia are valoarea’semi-furnished’, atunci se va descompune în două pozit,ii cu valorile 1
    s,i 0.
- Dacă pozit,ia are valoarea’unfurnished’, atunci se va descompune în două pozit,ii cu valorile 0 s,i
    1.
- Dacă pozit,ia are valoarea’furnished’, atunci se va descompune în două pozit,ii cu valorile 0 s,i 0.

```
Exemplu:
```
```
1 no 0 yes semi-furnished
2 no 2 no semi-furnished
3 yes 1 yes unfurnished
4 yes 2 no furnished
5 yes 2 no furnished
6 yes 1 yes semi-furnished
7 no 2 no semi-furnished
```
```
Înlocuind toate string-urile cu tipuri numerice, matricea de mai sus se va transforma în:
```

```
1 0 0 1 1 0
2 0 2 0 1 0
3 1 1 1 0 1
4 1 2 0 0 0
5 1 2 0 0 0
6 1 1 1 1 0
7 0 2 0 1 0
```
```
După înlocuirea tuturor pozit,iilor cu valori numerice, rezultatul obt,inut trebuie salvat în variabila
de ies,ireFeatureMatrix. Se observă că s-a mai adăugat o coloană, prin urmare s-a mărit numărul de
predictori cu 1.
```
- function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)

```
Funct,ialinear_regression_cost_functionimplementează funct,ia de cost, as,a cum a fost descrisă în
sect,iunea teoretică, folosind cei doi vectori s,i o matrice:
```
- Theta, care reprezintă un vectorcoloanăformat din coeficient,iiθ 1 ,...,θn∈R.
- FeatureMatrix, care reprezintă o matrice ce ret,ine valorile unor predictori (adică o linieidin
    această matrice reprezintăx(i)descris în suportul teoretic).
- Y, care reprezintă un vectorcoloanăce cont,inevalorile actuale, adicăies,irilece au un anumit
    ordin.
Pentru simplificarea implementării, putet,i omite termenul care indică eroarea din cadrul funct,iei
hθ(x), iarθ 0 îl putet,i considera 0.
Se garantează faptul că dimensiunile argumentelor suntcompatibilepentru a prelucra funct,ia de cost.
- function [Y, InitialMatrix] = parse_csv_file(file_path)

```
Funct,iaparse_csv_fileva primi o cale relativă către fis,ierul .csv unde se află datele pentru setul
propus.
Formatul (part,ial) al acestui fis,ier se află la pagina 18.
Există funct,ii Octave pentru a parsa, cu us,urint,ă, astfel de fis,iere.
```
- function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)

```
Funct,iagradient_descentcalculează, folosind tehnicagradientului descendent, coeficient,iiθ 1 ,...,θn∈
Rdupă efectuarea celoriterpas,i. Ca mai sus,θ 0 = 0(îl considerăm 0).
De asemenea, vectorul de predictorix(i)reprezintă liniaidin matriceaFeatureMatrix.
Considerat,i această aproximat,ie init,itală:θ 1 = 0,θ 2 = 0,...,θn= 0.
Această funct,iese va testafolosind setul de date din fis,ierul .csv (există funct,ii Octave pentru a parsa,
cu us,urint,ă, astfel de fis,iere).
```
- function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)
    Funct,ianormal_equation calculează, cu ajutorul metodeigradientului conjugat, coeficient,ii
θ 1 ,...,θn∈R. De asemenea,θ 0 = 0.
Această funct,ie trebuie să returneze un vectorThetacu tot,i coeficient,ii calculat,i.
Dacă matriceasistemuluinu estepozitiv definită, atunciThetao să stocheze doar valori de 0 s,i o
să fie returnat direct. Se garantează faptul căiterva fi ales în mod corespunzător.


- function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)

```
Funct,ialasso_regression_cost_function implementează funct,ia de cost, as,a cum a fost descrisă în
sect,iunea teoretică, folosind cei doi vectori, o matrice s,i un scalar de la intrare:
```
- Theta, care reprezintă un vectorcoloanăformat din coeficient,iiθ 1 ,...,θn∈R.
- FeMatrix, care reprezintă o matrice ce ret,ine valorile unor predictori (adică o linieidin această
    matrice reprezintăx(i)descris în suportul teoretic).
- Y, care reprezintă un vectorcoloanăce cont,inevalorile actuale, adicăies,irilece au un anumit
    ordin.
- λ, care reprezintă parametrul ce controleazăregularizarea.
    Pentru simplificarea implementării, putet,i omite termenul care indică eroarea din cadrul funct,iei
hθ(x), iarθ 0 îl putet,i considera 0.
Se garantează faptul că dimensiunile argumentelor suntcompatibilepentru a prelucra funct,ia de cost.
- function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)

```
Funct,iaridge_regression_cost_function implementează funct,ia de cost, as,a cum a fost descrisă în
sect,iunea teoretică, folosind cei doi vectori, o matrice s,i un scalar de la intrare:
```
- Theta, care reprezintă un vectorcoloanăformat din coeficient,iiθ 1 ,...,θn∈R.
- FeMatrix, care reprezintă o matrice ce ret,ine valorile unor predictori (adică o linieidin această
    matrice reprezintăx(i)descris în suportul teoretic).
- Y, care reprezintă un vectorcoloanăce cont,inevalorile actuale, adicăies,irilece au un anumit
    ordin.
- λ, care reprezintă parametrul ce controleazăregularizarea.
    Pentru simplificarea implementării, putet,i omite termenul care indică eroarea din cadrul funct,iei
hθ(x), iarθ 0 îl putet,i considera 0.
Se garantează faptul că dimensiunile argumentelor suntcompatibilepentru a prelucra funct,ia de cost.


## 3 MNIST 101(40p)

### 3.1 Enunt,

Trecând prin periplul său prin algoritmi numerici s,i predict,ie cu ajutorul regresiei liniare, Mihai face un
ultim pas pentru o introducere completă în învăt,area supervizată. Foarte captivat de regresia liniară, el se
întreabă cum ar putea adapta algoritmul s,i metodele de optimizare deja cunoscute pentru regresia liniară
pentru a le putea folosi s,i la alt gen de probleme, cum ar fi problemele declasificare.

Astfel, task-ul pe care s,i-l propune este să clasifice poze cont,inând cifre zecimale scrise de mână (de la
0 la 9) folosind un model de clasificare potrivit. Pentru că este vorba despre o problemă de clasificare în
mai multe clase, clasificatorul ales de Mihai este o mică ret,ea neurală care are un strat de input cu 400 de
unităt,i neuronale (valorile pixelilor unei poze de dimensiune 20 × 20 ), un strat de output cu 10 unităt,i (câte
una pentru fiecare clasă) s,i un strat ascuns, cu un număr intermediar de unităt,i neuronale (25 de unităt,i),
folosit pentru a cres,te complexitatea s,i deci s,i performant,a modelului de clasificare.

```
Figura 10: Câteva exemple din dataset-ul MNIST
```
### 3.2 Referint,e teoretice

#### 3.2.1 Adaptare a regresiei liniare: regresia logistică

Principiul de bază prin care se realizau predict,ii cu ajutorul regresiei liniare era faptul că rezultatul dorit
reprezenta o combinat,ie liniară a unui set de parametri dat,i (features- at,i întâlnit deja câteva exemple de
features în cadrul celei de-a doua părt,i a temei). Astfel, un model similar poate fi folosit s,i pentru clasificarea
datelor primite într-un număr finit de clase.

Să luăm mai întâi o problemă foarte simplă de clasificare în două clase. O problemă de clasificare cu
două clase are drept date de intrare un vector de parametri (la fel ca la regresia liniară), împreună cu un
rezultat, reprezentat de un label (o etichetă). În cazul clasificării binare, acest label poate avea valorile
y∈{ 0 , 1 }. Încă din acest pas observăm ineficient,a aplicării regresiei liniare pentru o problemă de clasificare:
regresia liniară poate da drept rezultat (valoare prezisă) orice număr real (pozitiv sau negativ), un rezultat
nepotrivit pentru predict,ia noastră în doar 2 clase.

Din acest motiv, avem nevoie de o metodă (oneliniaritate) prin care să mapăm rezultatul obt,inut în
urma combinat,iei liniare în intervalul[0,1]. Acesta este motivul pentru care, în loc de binecunoscuta ipoteză


hθ(x) =θTxsă utilizăm o ipoteză modificată, de forma

```
hθ=σ
```
##### 

```
θTx
```
##### ␁

undeσ:R→[0,1]este neliniaritatea amintită anterior. De obicei, se alege funct,iasigmoidpentru maparea
dorită, adică funct,ia:

```
σ(x) =
```
##### 1

```
1 +e−x
```
##### (3)

În figura de mai jos, avet,i graficul funct,iei sigmoid, în care se evident,iază rolul acesteia de a mapa orice
rezultat real în intervalul[0,1]:

```
Figura 11: Graficul funct,iei sigmoidσ(x) =1+^1 e−x
```
Având acum o nouă formă a ipotezei noastre, trebuie să redefinim s,i funct,ia de cost (loss function) care
va trebui să fie optimizată, întrucât eroarea pătratică (în termeni de normă 2 – cele mai mici pătrate) este
insuficientă. Ne dorim ca un model neantrenat să aibă o eroare mare dacă valoarea ipotezei de regresie diferă
semnificativ fat,ă de valoarea efectivă a clasei în care un exemplu este încadrat. De aceea, s-a introdus o
nouă funct,ie de cost, al cărei rol este să evident,ieze acest caz extrem, numităcross-entropy:

```
costi=−y(i)·log
```
```
h
hθ
```
##### ␐

```
x(i)
```
```
␑i
−(1−y(i))·log
```
```
h
1 −hθ
```
##### ␐

```
x(i)
```
```
␑i
```
```
Funct,ia de cost (pe toate exemplele de training) devine:
```
```
J(θ) =
```
##### 1

```
m
```
##### ·

```
Xm
```
```
i=1
```
```
costi=
```
##### 1

```
m
```
##### ·

```
Xm
```
```
i=1
```
```
n
−y(i)·log
```
```
h
hθ
```
##### ␐

```
x(i)
```
```
␑i
−(1−y(i))·log
```
```
h
1 −hθ
```
##### ␐

```
x(i)
```
```
␑io
```
Pentru acest caz, putem aplica tehnicile de optimizare a funct,iei de cost cunoscute deja din sect,iunea
anterioară a temei (Gradient Descents,i o formă modificată de Gradient Conjugat), obt,inând un model
cu performant,e foarte bune pentru task-uri simple de clasificare.

#### 3.2.2 Neajunsurile regresiei logistice

Regresia logistică este o tehnică de învăt,are supervizată foarte bună atunci când avem de-a face cu
probleme simple de clasificare (numărul de features este mic). Cu toate acestea, are unele neajunsuri, dintre
care merită ment,ionate următoarele:


- Regresia logistică clasică nu se poate extinde us,or la mai mult de 2 clase. Extinderea problemei de
    clasificare necesită câte un model particular pentru fiecare clasă introdusă (one vs all classification);
- Regresia logistică nu scalează la probleme de clasificare mai complexe, cum ar fi probleme specifice din
    zona de Computer Vision (identificarea obiectelor s,i procesarea imaginilor). Pentru astfel de probleme,
    este necesară utilizarea unor clasificatori mai complecs,i.

#### 3.2.3 Extinderea de la regresia logistică la o ret,ea neurală. Perceptronul

Regresia logistică poate fi privită ca o ret,ea, as,a cum este prezentat în figura de mai jos. În ret,eaua
dată, componentele noastre sunt reprezentate de:

- Nodurile ret,elei, numite s,ineuroni;
- Legăturileîntre nodurile ret,elei. Acestea semnifică contribut,ia (cu o anumită pondere^13 ) a respec-
    tivului perceptron pentru calcularea valorii unui neuron din următorul strat;
- Funct,ia de activare, care reprezintă o neliniaritate. Cele mai uzuale funct,ii de activare sunt sigmoid
    (prezentat anterior), Rectified Linear Unit (ReLU) s,i tangenta hiperbolică. În cazul nostru, vom analiza
    strict cazul în care funct,ia de activare este sigmoid;
- Pentru modelul de mai jos, avem un anumit număr de unităt,i neuronale de intrare s,i o singură unitate
    de ies,ire, corespunzătoare clasei din care va face parte.

```
Figura 12: Perceptronul
```
Acest design poate fi extins prin includerea unor unităt,i neuronale intermediare, care să formeze un
strat ascuns^14 s,i prin mărirea numărului de unităt,i neuronale de ies,ire, corespunzător numărului de clase
ale clasificatorului nostru. Astfel, am obt,inut o ret,ea neuronală conectată^15.

O ret,ea neuronală poate avea oricâte straturi ascunse, însă în cadrul acestui task noi vom folosi o
arhitectură care are un singur strat ascuns, ca în figura următoare.

(^13) en.weight
(^14) en.hidden layer
(^15) en.fully-connected neural network


```
Figura 13: Arhitectura ret,elei neurale folosite
```
```
Mărimile ce apar într-o ret,ea neurală descrisă de arhitectura de mai sus sunt:
```
- Cele trei straturi existente(denumite în literatura de specialitateinput layer,hidden layers,ioutput
    layer) au dimensiuniles 1 ,s 2 ,s 3 ∈N. Dimensiunea unui layer este reprezentată de numărul de neuroni
    din acel strat;
- Numărul de clase finale(care este egal cu numărul de neuroni din stratul de output) se notează cu
    K∈N;
- Fiecare neuron dintr-un strat este caracterizat de o mărime, numităactivare. Activările pentru layer-
    ul de input sunt chiar datele de intrare în ret,eaua neurală (în cazul nostru, vor fi 400 de pixeli ai unor
    poze 20 × 20 ). Pentru layer-ul de output, activările sunt chiar predict,iile noastre (layer-ul de output
    va avea 10 unităt,i neuronale). Pentru layer-ul intermediar (hidden) s,i pentru cel de output, activările
    vor fi determinate în funct,ie de toate activările neuronilor din layer-ul anterior (de aici s,i not,iunea de
    fully-connected);
- Pentru trecerea de la un layer la altul, vom utiliza o serie de parametri care alcătuiesc două matrice,
    Θ(1)∈Rs^2 ×(s^1 +1)s,iΘ(2)∈Rs^3 ×(s^2 +1).

#### 3.2.4 Predict,ie. Forward propagation

Predict,ia clasei din care face parte un anumit exemplu este un procedeu efectuat atât în etapa de
antrenare a modelului, cât s,i în etapa de testare (după antrenare). În cazul ret,elei neurale, procedeul prin
care se realizează determinarea activărilor neuronilor din layer-ul intermediar s,i determinarea predict,iilor
finale se numes,teforward propagation. Acest procedeu are următorii pas,i:

- Fie

##### 

```
x(i),y(i)
```
##### ␁

```
un exemplu din dataset-ul de antrenare, undex(i)reprezintă datele de intrare în ret,eaua
neurală s,iy(i)reprezintă clasa din care face parte exemplul dat;
```
- Se construies,te vectorul activărilor neuronilor din layer-ul de input din datele de intrare, la care se
    adaugă o unitate (bias):
       a(1)=

##### ␔

##### 1

```
x(i)
```
##### ␕


- Se aplică prima transformare liniară, dată de matriceaΘ(1), s,i se obt,ine un vectorz(2)al rezultatelor
    intermediare (pre-activări).
       z(2)= Θ(1)·a(1)
- Se aplică funct,ia de activare (în cazul nostru, funct,ia sigmoid – ec. 3). Funct,ia de activare va fi
    implementată vectorizat, rezultatul aplicării acesteia pe un tablou fiind aplicarea funct,ieisigmoidpe
    fiecare element din acel tablou.
       a(2)=σ

##### ␐

```
z(2)
```
##### ␑

- Se adaugă o unitate la începutul vectorului activărilor (pentrubias):

```
a(2)=
```
##### ␔

##### 1

```
a(2)
```
##### ␕

- Se aplică s,i cea de-a doua transformare liniară, astfel:

```
z(3)= Θ(2)·a(2)
```
- Se aplică, din nou, funct,ia de activare (sigmoid):

```
a(3)=σ
```
##### ␐

```
z(3)
```
##### ␑

- Aflându-ne în contextul ultimului layer, nu mai adăugăm unitatea pentrubias, iar activările obt,inute
    vor reprezenta predict,iile noastre pentru clasele propuse.

În cazul concret al task-ului nostru, vom obt,ine un vector de 10 predict,ii, fiecare element reprezentând
o predict,ie (similaritate) a exemplului dat cu una dintre cele 10 clase disponibile.

#### 3.2.5 Determinarea gradient,ilor. Backpropagation

La fel cum am observat la regresia liniară, orice model de învăt,are are nevoie de o modalitate prin care
să îs,i optimizeze (în acest caz, minimizeze) funct,ia de cost prin ajustarea parametrilor săi.

Pentru început, să scriem funct,ia de cost pentru o ret,ea neurală. Această funct,ie de cost reprezintă o
generalizare a funct,iei de cost pentru regresie logistică s,i se bazează, de asemenea, pecross entropy.

```
Înainte de a vă furniza formula, clarificăm că:
```
- Θ(1)este omatrice,Θ(1)∈Rs^2 ×(s^1 +1);
- Θ(2)este omatrice,Θ(2)∈Rs^3 ×(s^2 +1;
- θeste unvector,θ∈Rs^2 ·(s^1 +1)+s^3 ·(s^2 +1), s,i reprezintă vectorul care cont,ine toate elementele din cele
    2 matrice, în mod desfăs,urat.

```
J(θ) =
```
##### 1

```
m
```
##### ·

```
Xm
```
```
i=1
```
```
costi=
```
##### 1

```
m
```
##### ·

```
Xm
```
```
i=1
```
##### XK

```
k=1
```
```
n
−y(ki)·log
```
```
h
hθ
```
##### ␐

```
x(i)
```
##### ␑

```
k
```
```
i
−
```
##### ␐

```
1 −yk(i)
```
##### ␑

```
·log
```
```
h
1 −hθ
```
##### ␐

```
x(i)
```
##### ␑

```
k
```
```
io
```
##### +

```
λ
2 m
```
##### 

##### 

```
sX 1 +1
```
```
j=2
```
```
Xs^2
```
```
k=1
```
##### ␐

```
Θ(1)k,j
```
##### ␑ 2

##### +

```
sX 2 +1
```
```
j=2
```
```
Xs^3
```
```
k=1
```
##### ␐

```
Θ(2)k,j
```
##### ␑ 2

##### 

##### 

A se observa că, la fel ca la regresie liniară, nu am regularizat s,i ponderile corespunzătoare activărilor
constante (biases).


Dacă la regresie liniară ajustarea parametrilor se putea realiza cu ajutorul gradient,ilor determinat,i
analitic (sub forma derivatelor part,iale ale funct,iei de cost), în cazul ret,elelor neurale acest lucru nu mai este
posibil direct, întrucât o expresie analitică a gradient,ilor este foarte dificil de obt,inut.

Cu toate acestea, putem folosi un algoritm cu ajutorul căruia să determinăm gradient,ii pentru fiecare
parametru al modelului. Acest algoritm se numes,tebackpropagation.

Algoritmul de backpropagation se bazează pe solut,ionarea gradient,ilor prin intermediul determinării
erorilor de activare. Concret, să presupunem că tocmai am realizatforward propagationpentru a deter-
mina predict,iile exemplului de antrenament curent pentru fiecare clasă. Atunci, putem defini eroarea care

a apărut în activarea din layer-ull, în neuronul de indicek, notată cuδ(kl). De asemenea, vom mai păstra
matricele∆(1)s,i∆(2), de aceleas,i dimensiuni cu matriceleΘ(1) s,iΘ(2), în care vom acumula gradient,ii
parametrilor ret,elei.

```
Pe scurt, pas,ii pentru algoritmul debackpropagationsunt:
```
- Determinăm eroarea în layer-ul de output:

```
δ(3)=a(3)−y(i)
```
- Putem acumula gradient,ii pentru parametrii care fac trecerea de la layer-ul intermediar la layer-ul de
    output, folosind formula:
       ∆(2)= ∆(2)+δ(3)·(a(2))T
- Pentru determinarea erorii în layer-ul intermediar, folosim formula:

```
δ(2)= (Θ(2))Tδ(3).∗σ′(z(2))
```
```
undeσ′este derivata funct,iei de activaresigmoid, avem adevărată relat,iaσ′(x) =σ(x)·(1−σ(x)). De
asemenea, operatorul.∗reprezintă produsul Hadamard a două tablouri (produsulelementwise). Hint:
ca notă de implementare, putet,i folosi direct activarea calculată anterior, iar din primul termen al
operat,iei.∗putet,i elimina prima componentă (contribut,ia la eroarea unităt,ii de bias). În caz contrar,
putet,i obt,ine o eroare de tipdimension mismatch.
```
- Eliminăm prima componentă dinδ(2)(aceasta este componenta pentru bias, acolo unde nu are sens să
    calculăm o eroare în valoarea activării).
- Acumulăm gradient,ii s,i pentru parametrii care fac trecerea de la layer-ul de input la cel intermediar:

```
∆(1)= ∆(1)+δ(2)·(a(1))T
```
- După ce am realizat acumularea gradient,ilor pentru toate exemplele de antrenament, putem împărt,i
    la numărul exemplelor de antrenament:

```
∂J(Θ)
∂θij(l)
```
##### =

##### 1

```
m
```
##### ·∆

```
(l)
ij
```
- La final, putem adăuga s,i termenul corespunzător regularizării (numai pentruj > 1 , pentruj= 1
    formula anterioară rămâne valabilă):

```
∂J(Θ)
∂θ(ijl)
```
##### =

##### 1

```
m
```
```
·∆(ijl)+
```
```
λ
m
```
```
·Θ(ijl)
```
Având la dispozit,ie acum gradient,ii s,i valoarea funct,iei de cost, putem realiza optimizarea funct,iei de cost
prin Gradient Descent sau Gradient Conjugat.


#### 3.2.6 Init,ializarea parametrilor

În cazul ret,elelor neurale, init,ializarea parametrilor (elementelor matricelor) cu valori nule nu este
posibilă (avem simetrie s,i vom obt,ine o simetrie în ceea ce prives,te clasificarea exemplului nostru în diversele
clase disponibile). De asemenea, init,ializarea cu zero a parametrilor duce la anularea gradient,ilor (ret,eaua
neurală este incapabilă să învet,e), o problemă care în Deep Learning se numes,te Vanishing Gradient Problem.
Putet,i citi mai multe despre această problemă aici.
Solut,ia este init,ializarea parametrilor cu valori aleatoare, din intervalul(−ε,ε). Empiric, s-a constatat că o
valoare potrivită pentruεeste dată de următoarea formulă:

```
ε 0 =
```
##### √

##### 6

```
p
Lprev+Lnext
```
### 3.3 Cerint,e

```
Având în vedere referint,ele teoretice, avet,i de implementat următoarele funct,ii:
```
- function [X, y] = load_dataset(path)
    Funct,iaload_dataset primes,te o cale relativă la un fis,ier .mat s,i încarcă în memorie acel fis,ier, re-
    turnând matricea care cont,ine exemplele folosite pentru training s,i pentru test. Liniile matricei X vor
    reprezenta exemplele de date.
- function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
    Funct,iasplit_datasetprimes,te un dataset, as,a cum a fost el returnat de funct,ia anterioară (training
    examples, împreună cu labels) s,i împarte setul de date în 2 seturi: un set de training s,i un set de test,
    ambele reprezentate printr-o matrice de features s,i un vector de clase. Împărt,irea pe cele 2 seturi se va
    face astfel: se amestecă exemplele, iar apoi o fract,iune egală cu parametrulpercentdin exemplele date
    în dataset va fi adăugată în setul de training (valorile de returXtrains,iytrain), iar restul exemplelor
    vor fi plasate în setul de test.
- function [matrix] = initialize_weights(L_prev, L_next)
    Funct,iainitialize_weightsprimes,te dimensiunile (numărul de neuroni) celor 2 straturi între care se
    aplică transformarea liniară s,i întoarce o matrice cu elemente aleatoare din intervalul(−ε,ε), conform
    precizărilor din referint,e.
- function [J, grad] = cost_function(params, X, y, lambda, input_layer_size,
    hidden_layer_size, output_layer_size)
    Funct,iacost_functionprimes,te următorii parametri:
       - paramsreprezintă un vector coloană care cont,ine toate valorile ponderilor (weights) din matricele
          Θ(1)s,iΘ(2). Cu alte cuvinte, folosind elementele din acest vector s,i dimensiunile straturilor putem
          construi matricele pentru transformările liniare. Hint:reshape.
       - Xreprezintă mult,imea exemplelor de training, fără labels asociate (feature matrix).
       - yreprezintă label-urile asociate exemplelor de mai sus.
       - input_layer_sizereprezintă dimensiunea stratului de input.
       - hidden_layer_sizereprezintă dimensiunea stratului intermediar/ascuns.
       - output_layer_sizereprezintă dimensiunea stratului final (care este egal cu numărul de clase).
    Funct,ia returnează un vector de aceeas,i dimensiune cu parametrulparams, obt,inut prin desfăs,urarea
    (unrolling) matricelor în care calculăm gradient,ii după aplicarea algoritmului debackpropagation, s,iJ,
    care reprezintă funct,ia de cost pentru valoarea momentană a parametrilor.


- function [classes] = predict_classes(X, weights, input_layer_size,
    hidden_layer_size, output_layer_size)
Funct,ia primes,te un set de exemple de test s,i vectorul pentru weights, precum s,i dimensiunile layerelor
ret,elei s,i întoarce un vector cu toate predict,iile pentru exemplele date din setul de test.
Hint:forward propagation

#### 3.3.1 Restrict,ii s,i precizări

- În dataset-ul folosit, pentru clasa corespunzătoare cifrei 0 s-a folosit label-ul 10, tocmai pentru ca
    label-urile să fie conforme cu indexarea din GNU Octave.
- În cazul linear/logistic regression, rezultatul ipotezei era o valoare numerică, după caz (pentru linear
    regression putea fi orice număr real, pentru logistic regression putea fi orice număr cuprins între 0 s,i 1,
    din cauza funct,ieisigmoid). În cazul unei ret,ele neurale, ipoteza va da un vector dinRoutput_layer_size,
    întrucât ret,eaua neurală dă probabilităt,i de apartenent,ă pentru un exemplu la fiecare dintre cele
    output_layer_size= 10 clase existente. Observat,i însă că rezultatul ret,elei neurale este un vector
    de probabilităt,i. Acestui vector de probabilităt,i trebuie să îi asociem un label (corespunzător clasei
    de care apart,ine, acesta va fiindexul celei mai mari probabilităt,i). Pentru a determina erorile
    s,i funct,ia de cost, se procedează invers: fiecare label din vectorulyva fi „expandat” la un vector de
    output_layer_size= 10 elemente, element al bazei canonice (are un singur 1 s,i 0 în rest).
- Adăugarea coloanei de 1 la matricea X are loc în partea de forward propagation. În practică, aceasta
    poate fi s,i adăugată de la început, însă testele (cele de load) nu adaugă coloana de 1 la matricea X,
    acest lucru realizându-se în funct,iilecost_functions,i înpredict_classes.


## 4 Regulament

Ultima versiune ajunsă pe server va fi cea luată în considerare la corectare s,i condit,iile de punctare vor fi
cele din ziua în care aceasta a fost încărcată pe site. Este OBLIGATORIU ca pe lângă sursele programelor ce
rezolvă temele să existe un fişier README în care se prezintă algoritmul/metoda/ideea folosită, consideraţii
referitoare la aceasta, modul de implementare, probleme care apar şi justificarea deciziilor luate, etc. Textul
acestui fişier trebuie să fie concis, să aibă o ţinută tehnică şi să fie complementar comentariilor din cod.

### 4.1 Arhivă

Solut,ia temei se va trimite ca o arhivăzip. Numele arhivei trebuie să fie de forma
Grupă_NumePrenume_TemaX.zip- exemplu:311CA_Alexandru-Mihai-IulianBuzea_Tema1.zip.

Arhiva temei trebuie să cont,ină doar cele 3 directoare cont,inând fis,ierele sursă (markov−is−coming,
linear−regressions,imnist− 101 ) împreună cu fis,ierul README/README.md.

Numele şi extensiile fişierelor auxiliare create de voiNUtrebuie să conţină spaţii sau majuscule, cu
exceptia fis,ierului README (care este are nume scris cu majuscule s,i poate avea extensiamd, în cazul în
care optat,i pentru formatul Markdown).

```
Nerespectarea oricărei reguli din sect,iuneaArhivăaduce un punctajNULpe temă.
```
### 4.2 Punctaj

```
Distribuirea punctajului:
```
- Markov is coming: 40p
- Linear Regression: 40p
- MNIST 101: 40p

ATENT,IE!Punctajul maxim pe temă este 100p. Acesta reprezintă 1p din nota finală la această
materie. La această temă se pot obt,ine până la 120p (există un bonus de 20p), adică un punctaj maxim de
1.2p din nota finală.

#### 4.2.1 Reguli s,i precizări

- Punctajul pe teste este cel acordat de scriptul dechecker.py(care urmeaza sa fie postat). Echipa
    de corectare îs,i rezervă dreptul de a depuncta pentru orice încercare de a trece testele fraudulos (de
    exemplu prin hardcodare).
- Punctajul pe calitatea explicat,iilor s,i a codului se acordă în mai multe etape:
    - Codul sursă trebuie să fie însot,it de un fis,ier README(.md) care trebuie s,ă cont,ină informat,iile
       utile pentru înt,elegerea funct,ionalit,ăt,ii, modului de implementare s,i utilizare a solut,iilor cerute.
       Acesta evaluează, de asemenea, abilitatea voastră de a documenta complet s,i concis programele pe
       care le producet,i s,i va fi evaluat de către echipa de asistent,i. In funct,ie de calitatea documentat,iei,
       se vor aplica depunctări sau bonusuri.
    - Deprinderea de a scrie cod sursă de calitate, este un obiectiv important al materiei. Sursele
       greu de înteles, modularizate neadecvat sau care prezintă hardcodări care pot afecta semnificativ
       mentenabilitatea programului cerut, pot fi depunctate adit,ional.


- În această etapă se pot aplica depunctări mai mari de 30p.
- Des,i nu impunem un anumit standard de coding style, ne as,teptăm să întâlnim cod lizibil, doc-
    umentat corespunzător. Erorile grave de coding style (cod ilizibil, variabile denumite nesugestiv,
    hardcodarea sau lipsa comentariilor de orice fel) vor fi depunctate corespunzător.

### 4.3 Alte precizări

- Implementarea se va face in limbajulMATLAB, iar tema testatăDOARîntr-un mediuLINUX.
    Nerespectarea acestor reguli aduce un punctajNUL.
- Tema trebuie trimisă sub forma unei arhive pe site-ul cursului curs.upb.ro.
- Tema poate fi submisă de oricâte ori fără depunctări până la deadline. Mai multe detalii se găsesc în
    regulamentul de pe ocw.
- Ultima temă submisă poate fi rulată de către responsabili de mai multe ori în vederea verificării faptului
    că nu avet,i buguri în sursă. Vă recomandăm să verificat,ilocaltema de mai multe ori pentru a verifica
    că punctajul este mereu acelas,i, apoi să încărcat,i tema.
- Temele vor fi testate antiplagiat. Este interzisă publicarea pe forum s,i în orice spat,iu public (GitHub) a
    întregului cod sau a unor port,iuni din cod care reprezintă solut,ii la task-urile propuse. Nu este permisă
    colaborarea de orice fel în vederea realizării temelor de casă. Solut,iile care nu respectă aceste criterii
    vor fi punctate cu 0 (zero) puncte.
- Preluarea de cod din resurse publice este permisă doar în contextul ment,ionării sursei în comentariis,i
    în README, cu except,ia resurselor care reprezintă rezolvări directe ale task-urilor din temă. Solut,iile
    care nu respectă aceste criterii vor fi punctate cu 0 (zero) puncte.
- Este interzisă folosirea ChatGPT sau a oricărei formă de LLM în rezolvarea temei de casă. Solut,iile
    care nu respectă acest criteriu vor fi punctate cu 0 (zero) puncte.


# Running the checker

## Through Docker

Use `./local.sh checker` to build the image and run the checker. This will take
some time (~700 secons). In order to build the image and get output, you can
do `./local.sh docker build` and then run the checker with `./local.sh checker`.

This is the environment used to automatically check your code.

## Manually

Go to the `checker` directory and run the `./checker.sh` script.
