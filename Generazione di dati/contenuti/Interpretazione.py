import random
from datetime import datetime, timedelta

def genera_associazioni():
    associazioni = []
    for n in range(1, 101):
        numeri_a = random.sample(range(1, 501), 4)
        for a in numeri_a:
            associazioni.append((a, n))
    return associazioni

def stampa_associazioni(associazioni):
    for a, n in associazioni:
        print(f"({n}, {a}),", end = "")

if __name__ == "__main__":
    associazioni = genera_associazioni()
    stampa_associazioni(associazioni)