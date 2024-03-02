import random

def associa_numeri(vettore_nomi):
    risultati = []
    for i in range(300):
        numero = random.randint(1, 100)
        genere = random.choice(vettore_nomi)
        da_verif = (genere, numero)
        if da_verif in risultati:
            i = i-1
            continue
        risultati.append((genere, numero))
    return risultati

def stampa_risultati(risultati):
    i = 0
    for nome, numero in risultati:
        i = i+1
        print(f'("{nome}", {numero}),', end="")

if __name__ == "__main__":
    nomi = [ "Azione", "Avventura", "Animazione","Commedia","Crime","Documentario","Drammatico","Family","Fantasy","Storico","Horror","Musicale","Mistero","Romantico","Fantascienza","Thriller","Guerra","Western","Biografico","Sportivo","Supereroi","Favola","Parodia"];  
    risultati = associa_numeri(nomi)
    stampa_risultati(risultati)
