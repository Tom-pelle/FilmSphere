import random

# Esempio di liste di nomi e cognomi casuali
nomi = ['Tommaso', 'Niccolo', 'Francesca', 'Luca', 'Anna', 'Davide',
         'Giulia', 'Matteo', 'Laura', 'Simone', 'Sara', 'Andrea', 'Elisa', 'Alessandro', 
         'Martina', 'Giovanni', 'Elena', 'Nicola', 'Federica', 'Filippo']
cognomi = [
    'Pellegrini', 'Franchi', 'Rossi', 'Bianchi', 'Ricci', 'Esposito', 'Romano', 'Colombo', 'Greco', 'Conti',
    'Gallo', 'Costa', 'De Luca', 'Mancini', 'Leone', 'Coppola', 'Ferrari', 'Marino', 'Santoro', 'Ferrara',
    'Rizzo', 'Lombardi', 'Moretti', 'Barbieri', 'Fontana'
]

for i, elem_a in enumerate(nomi, start=1):
    for j, elem_b in enumerate(cognomi, start=1):
        print(f'({(i-1) * len(cognomi) + j}, "{elem_a}", "{elem_b}"),', end ="")
