import random
from datetime import datetime, timedelta

def genera_associazioni():
    associazioni = []
    for n in range(1, 501):
        data_casuale = datetime.now() - timedelta(days=random.randint(0, 365))
        associazioni.append((n, random.randint(1, 100), random.randint(1, 5), data_casuale.strftime('%Y-%m-%d')))
    return associazioni

def stampa_associazioni(associazioni):
    for a, n, b, data in associazioni:
        print(f"({a}, {n}, {b}, '{data}'),", end="")

if __name__ == "__main__":
    ass = genera_associazioni()
    stampa_associazioni(ass)
