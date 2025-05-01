    Task-1: Markov is coming

1) parse_labyrinth:

Functia citeste un labirint dintr-un fisier text si il transforma intr-o matrice
numerica. In "m" si "n" retin dimensiunile labirintului, iar apoi citesc pe rand,
in ordine, fiecare element al acestuia. Am facut citirea folosind fscanf.

2) get_adjacency_matrix

Functia transforma o matrice ce reprezinta un labirint intr-o matrice de adiacenta
care codfica conexiunile intre starile labirintului. Fiecare celula este mapata la
un nod al grafului. Se adauga doua noduri extra, pt starile WIN si LOSE. Pt fiecare
celula, daca nu exista un perete intr-o directie inseamna:
--in Nord si in Sud, cand celula este marginea superioara sau inferioara, lipsa
  peretelui indica o iesire spre WIN
--in Est si in Vest, lipsa peretelui indica o iesire spre LOSE
Asadar, se creeaza o conexiunie, adica o muchie, intre nodul celulei curente si nodul
corspunzator celulei vecine din directia deschisa.

3) get_link_matrix

Functia transforma matricea de adiacenta intr-o matrice de lagaturi.
Se obtine matricea de adiacenta folosind functia get_adjacency_matrix.
Pentru feicare nod, se calculeaza nr de tranzitii disponibile de la acel nod si pt
fiecare tranzitie in care valoarea este nenula, se atribuie probabilitatea 1/nr_tranzitii.

4) get_Jacobi_parameters

Din matricea de legaturi, functia elimina starile WIN si LOSE. Construieste matricea G,
extrasa din Link si reprezinta probabilitatile de tranzitie interne intre starile tranzitorii.
Functia construieste si vectorul c, extragand valoarea tranzitiei catre starea WIN.

5) perform_iterative

Functia rezolva iterativ ecuatia f = G*f + c. Pornind de la solutia initiala, se 
actualizeaza recurent solutia pana cand norma diferentei dintre solutiile 
consecutive, adica eroarea, devine mai mica decat toleranta sau pana se atinge nr
maxim de iteratii, adica max_iter.

6) heuristic_greedy

Functia incepe cu pozitia de start, care este marcata ca vizitata, iar calea contine
doar aceasta pozitie. Pentru starea curenta, adica ultimul eliment al caii, functia verifica
toti vecinii care sunt conectati printr-o legatura si care nu au fost deja vizitati.
Dintre acestia, se selecteaza vecinul cu cea mai mare probabilitate. Daca pt starea curenta
nu exista niciun vecin nevizitat, aceasta este eliminata din calea curenta, pt a permite
cautarea din stari anterioare. Cautarea se opreste cand se ajunge la WIN.

7) decode_path

Functia filtreaza vectorul de intrare pt a pastra indicii care se incadreaza in nr total
de celule ale labirintului. Pt fiecare indice valid, calculez linia si coloana asociata.

    Task-2: Linear regression

1) parse_data_set_file

Functia citeste un fisier text ce contine un set de date. Vectorul Y stocheaza
valorile de tip float asociate fiecarei inregistrari. Matricea InitialMatrix este
o matrice de celule cu dimensiunea m*n. Pt fiecare inregistrare, dupa citirea etichetei,
se citesc n stringuri care reprezinta atributele specifice acelei inregistrari.

2) prepare_for_regression

Pentru fiecare coloana din InitialMAtrix, se verifica daca atributul este unul
din cele trei tipuri "semi-furnished", "unfurnished" sau "furnished". Pentru aceste
atribute se adauga o coloana in plus pt a permite o codificare pe 2 coloane.
"semi-furnished" este codificat ca [1, 0].
"unfurnished" este codificat ca [0, 1].
"furnished" este codificat ca [0, 0].
"yes", se codifica ca 1.
"no", se codifica ca 0.
In orice alt caz se converteste valoarea in tipul double.

3) linear_regression_cost_function

Functia ignora primul coeficient, deoarece este zero. Pentru fiecare rand
din FeatureMatrix se calculeaza produsul scalar intre vectorul de atribute
si vectorul de coeficienti. Pentru firecare exemplu se calculeaza diferenta
dintre predictie si valoarea reala. Costul final este dat de suma tuturor erorilor
patratice, impartita la 2*m, unde m este nr total de exemple.

4) parse_csv_file

Functia citeste un fisier csv, ignora antetul fisierului. Fiecare rand reprezinta
o inregistrare, unde primul camp contine pretul pt inregistrare, care este ceonvertit
la un nr si stocat intr-un vector. Restul campurilor reprezinta alte atribute si sunt
stocate intr-o matrice de celule, fara prima coloana.

5) gradient_descent

La fiecare iteratie, se calculeaza h pt toate exemplele, se determina eroarea dintre
predictii si valorile reale, iar apoi se calculeaza gradientul functiei de cost. vectorul
de coeficienti se actualizeaza prin scaderea produsului dintre rata de invatare si gradient.
La final, se adauga zero la inceputul vectorului de coeficienti.

6) normal_equation

Functia calculeaza vectorul de coeficienti al unui model de regresie liniara folosind
ecuatia normala, care este data de formula: Theta = (X' * X) ^ (-1) * X' * Y

7) lasso_regression_cost_function

Se calculeaza predictia folosind produsul scalar al randului din FeatureMatrix si vectorul
de coeficienti, apoi se compara cu valoarea reala din Y. Erorile sunt patrate, insumate si
mediate. Se calculeaza suma valorilor absolute ale tuturor elementelor din vectorul Theta.
Aceasta suma este apoi inmultita cu lambda.

8) ridge_regression_cost_function

Se calculeaza predictia ca in formula, apoi se calculeaza suma patratelor tuturor elementelor
din vectorul Theta si apoi se multiplica cu lambda. Functia cost este definita ca:
Error = (suma erorilor la patrat / (2*m)) + lambda * (suma patratelor lui Theta)

    Task-3: MNIST 101

1) load_dataset

Functia incarca un set de date dintr-un fisier dat. X este matricea care contine
caracteristicile pt fiecare exemplu. y este vectorul de etichete.
Functia utilizeaza functia load pt a citi fisierul, apoi extrage campurile X si y din
structura rezultata.