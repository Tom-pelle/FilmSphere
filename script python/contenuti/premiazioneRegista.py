import random

def genera_associazioni():
    associazioni = []
    for n in range(1, 21):
        prob = random.randint(0,100)
        if(prob > 60):
            anno_cas = random.randint(2010,2023)
            premio_cas = random.randint(1, 9)
            associazioni.append((n, premio_cas, anno_cas))
    return associazioni

def stampa_associazioni(associazioni):
    for film, premio, anno in associazioni:
        print(f"({film},{premio},'{anno}'),", end="")

if __name__ == "__main__":
    associazioni = genera_associazioni()
    stampa_associazioni(associazioni)