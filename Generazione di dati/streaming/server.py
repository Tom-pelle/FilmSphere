import random

memorie = [500, 1000, 1500, 2000]
bana = [3,4, 8, 9, 12, 17, 22, 24, 27, 29]
def associa_numeri():
    risultati = []
    for a in range(5):
        latitudine = round(random.uniform(-90,90),4)
        longitudine = round(random.uniform(-180,180), 4)
        banda = random.randint(0, 30)
        capacita = random.choice(memorie)
        banda = random.choice(bana)
        risultati.append((a+1, longitudine, latitudine, capacita, banda))
    return risultati

def stampa_risultati(risultati):
    for id, lat, long, ban, cap  in risultati:
        print(f'({id}, {lat}, {long}, {ban}, {cap} ),', end="")

if __name__ == "__main__":
    result = associa_numeri()
    stampa_risultati(result)