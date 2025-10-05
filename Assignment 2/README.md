Tema 2 - Metode Numerice
Costache Ovidiu-Stefan 313CC

Task 1:

1) stereo_to_mono.m:
Pentru fiecare esantion, calculez media valorilor de pe toate canalele.
Rezultatul este un vector cu acelasi numar de esantioane, dar cu o singura
coloana. La final, semnalul este normalizat, adica impartit la valoarea
absoluta maxima, pentru a preveni distorsiuni de redare.

2) spectogram.m:
Semnalul este impartit in bucati de dimensiune fixa "window_size". Daca
semnalul nu este multiplu de window_size, restul de la final se ignora.
Fiecare fragment este ponderat cu o fereastra Hann, pentru a reduce scurgerea
de frecventa. Se foloseste FFT de dimensiune dubla fata de fereastra pentru a
obtine o rezolutie mai fina pe axa de frecventa. Pentru fiecare transformare,
se pastreaza doar prima jumatate a rezultatului FFT, deoarece pentru semnalele
reale, spectrul este simetric si doar partea pozitiva contine informatia.
Am rulat functia pentru un sin de 300hz, iar spectograma arata o singura banda
orizontala stabila la frecventa respectiva. Rezolutia in timp si frecventa
depind de marimea ferestrei, o fereastra mica inseamna rezolutie buna in timp,
iar una mare rezolytie buna pe frecventa.

3) oscillator.m:
Se construieste un vector de timp de la zero cu pasul 1/fs. Fiecare element
corespunde unui moment de timp precis. Pentru fiecare moment de timp, se
calculeaza valoarea 2*pi*frecv*t, de unde rezulta o unda sinusoidala.
Envelope este impartit in 4 faze ca in cerinta. Apoi se realizeaza o inmultire
element cu element intre unda sinusoidala si vectorul envelope, de unde rezulta
sunetul final.

4) high_pass.m:
Aplic FFT pe semnal pentru a obtine spectrul frecvential. In frecventa, fiecare
coeficient FFT corespunde unei frecvente. Se construieste un vector de frecvente
care permite asocierea fiecarui coeficeint FFT cu frecventa sa corespunzatoare.
Apoi construiesc un vector masca cu 1 pentru frecvente mai mari decat
cutoff_frq si 0 pentru cele mai mici sau egale. Masca respecta simetria FFT.
Multiplic spectrul FFT cu masca si se pastreaza doar elementele dorite.
Apoi aplic IFFT pentru a reduce semnalul filtrat in domeniul timp. Rezultatul
este normalizat la amplitudinea maxima 1, astfel incat semnalul sa nu fie
distorsionat.

5) apply_reverb.m:
Folosesc functia stereo_to_mono pentru a transofrma impulsul intr-un singyr
canal audio, pentru a evita problemele de faza si de compatibilitate.
Se face convolutia dintre semnalul audio si impuls folosind functia conv.
Fiecare sunet este inmultit cu o copie intarziata. Semnalul final este
normalizat pentru a evita distorsiuni.

Task 2:

1) parse_data.m:
Folosesc fopen pentru a deschde fisierul in modul de citire. Citesc primul
numar din fiser, care indica cate intervale vor fi citite. Citesc n+1 valori
pentru abscise si ordonate, ca vectori linie. Ca sa lucrez cu ele le fac vector
coloana. Inchid fiserul cu fclose(fin).

2) spline_c2.m:
Se construieste o matrice A si un vector b pentru sistemul de ecutaii liniare
ce va determina coeficientii spline-ului. Impun conditiile ca spline-ul sa
treaca prin toate punctele date, conditiile de continuitate a valorii, a deri-
vatelor de ordin 1 si a derivatelor de ordin 2. Fiecare ecuatie se traduce prin
completarea corespunzatoare a coeficientilor in matricea A si a termenilor
liberi in b. Sistemul este rezolvat, iar rezultatul este coef ce contine toti
coeficeintii spline-ului pentru fiecare interval.

3) P_spline.m:
Se creeaza un vector coloana "y_interp" cu acelasi numar de elemente ca vectorul
de abscise unde dorim sa evaluam spline-ul. Pentru fiecare valoare din x_interp
se cauta intervalul [x(i), x(i+1)] in care se afla acel punct. Identific pozitia
coeficeintilor pentru intervalul obtinut in vectorul coef. Apoi se calculeaza
valoarea spline-ului. Pasii se reiau pentru fiecare element din x_interp, iar
rezultatele se stocheaza in y_interp.

4) vandermonde.m:
Gradul polinomului este n, iar n+1 numarul de puncte de interpolare. Se constru-
ieste o matrice patratica V, unde fiecare element este x(i)^(j-1), iar la final
se rezolva sistemul. V este matricea Vandermonde, iar coef este vectorul
necunoscut de coeficeinti ai polinomului.

5) P_vandermonde.m:
Creez un vector y_interp de aceeasi lungime cu numarul de puncte in care evaluez
polinomul x_interp. Pentru fiecare element din polinom se calculeaza valoarea
acestuia folosind coeficientii "coef" si formula:
suma = suma + coef(j) * x_interp(k)^(j-1). Operatiile sunt repetate pentru toate
punctele din x_interp, iar rezultatul se salveaza in vectorul coloana y_interp.

Task 3:

1) preprocess.m:
Creez un vector idx care va contine indecsii clientilor ce trebuie pastrati.
Pentru fiecare rand se numara cate review-uri a acordat clientul. Daca numarul
este mai mare sau egal cu min_reviews, indexul este adaugat in vectorul idx.
La final construiesc matricea redusa folosind doar randurile corespunzatoare
indicilor pastrati.

2) cosine_similarity.m:
Pentru fiecare componenta se inmultesc valorile corespunzatoare din cei doi
vectori, iar rezultatele se aduna. Pentru fiecare vector, se ridica la patrat
fiecare element, apoi se aduna rezultatele si se face radacina patrata a sumei.
Se imparte produsul scalaf la produsul normelor celor doi vectori. Rezultatul
este similaritatea cosinusului, cu valori intre -1 si 1.

3) read_mat.m:
Folosesc functia csvread ca in cerinta cu parametrii (path, 1, 1). "path" este
calea catre fisiserul .csv, iar 1, 1 inseamna ca se sare peste primul rand si
prima coloana.

4) recommendations.m:
Citesc matricea de recenzie din fisierul .csv folosind functia read_mat. Se
elimina clientii care nu au dat suficiente recenzii prin functia preprocess.
Aplic SVD redus (hint din cerinta) pe matricea filtrata si pastrez doar
num_features componente principale. Folosesc doar matricea V din SVD, care
contine reprezentari vectoriale pentru fiecare tema. Pentru tema preferata
calculez similaritatea cosinusului intre vectirul acesteia si vectorii tuturor
celorlalte teme, iar rezutatul este un vector de similaritati, in care valorile
mari indica teme asemanatoare. Temele sunt sortate descrescator dupa
similaritate. Tema preferata este eliminata din lista rezultata si se selecteaza
primele num_recoms teme. Functia returneaza indecsii temelor recomandate,
ordonate de la cea mai similara la cea mai putin similara.
