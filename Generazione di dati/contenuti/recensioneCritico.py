import random
from datetime import datetime, timedelta

def genera_associazioni():
    associazioni = []
    for n in range(1, 101):
        numeri_a = random.sample(range(1, 26), 5)
        for a in numeri_a:
            data_casuale = datetime.now() - timedelta(days=random.randint(0, 365))
            associazioni.append((a, n, random.randint(1, 5), data_casuale.strftime('%Y-%m-%d')))
    return associazioni

def stampa_associazioni(associazioni):
    for a, n, b, data in associazioni:
        print(f"({a}, {n}, {b}, '{data}'),", end="")

if __name__ == "__main__":
    associazioni = genera_associazioni()
    stampa_associazioni(associazioni)
