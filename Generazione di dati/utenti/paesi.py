from faker import Faker
import random
import math

result = []
f = Faker()

def genera_paesi():
    for i in range(100):
        nome = f.unique.country()
        while(len(nome) > 20):
            nome = f.unique.country()
        latitudine = round(random.uniform(-90,90),4)
        longitudine = round(random.uniform(-180,180), 4)
        j = i+1
        ip = str(j).zfill(3)
        result.append((nome, latitudine, longitudine, ip))

def stampa_paesi():
    for nome, latitudine, longitudine, ip in result:
        print(f'("{nome}", {latitudine}, {longitudine}, {ip}),', end="")
    print(" ")

if __name__ == "__main__":
    genera_paesi()
    stampa_paesi()
