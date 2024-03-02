from faker import Faker
import random
from datetime import datetime, timedelta

f = Faker()
abbonamenti = [("Basic", 5), ("Premium", 7), ("Pro", 10), ("Deluxe", 9), ("Ultimate", 15)]
paesi = [("Sierra Leone", -36.8119, 66.6003, 1),("Yemen", -33.1587, -165.9156, 2),("Sri Lanka", 89.9951, -123.9046, 3),("Cambodia", 58.1884, 103.6873, 4),("Guam", 89.0494, -4.4677, 5),("Slovenia", 25.3208, 122.1536, 6),("Brazil", 57.982, 94.5708, 7),("Vietnam", 88.3744, -141.2968, 8),("Montenegro", 12.9345, 70.0759, 9),("Belarus", 71.1505, -97.209, 10),("American Samoa", 3.822, -68.8073, 11),("Burundi", 67.5203, -27.4586, 12),("Liberia", 77.2952, 93.6061, 13),("Comoros", 78.6316, 36.707, 14),("Croatia", 23.3739, -2.4558, 15),("Bermuda", -52.4864, -45.7225, 16),("Dominica", 17.3711, 56.0301, 17),("Netherlands", 13.3435, -105.639, 18),("Morocco", 25.4294, -134.026, 19),("Venezuela", 59.2426, 99.0532, 20),
         ("Maldives", -22.518, 114.7288, 21),("Eritrea", -61.8153, -1.4625, 22),("Nicaragua", 76.0036, -70.454, 23),("Malaysia", 74.8054, -20.8231, 24),("Saint Barthelemy", 49.2902, 101.3386, 25),("Bahrain", 45.2494, 95.9402, 26),("Rwanda", 39.1493, 89.7584, 27),("Argentina", -11.0425, -173.9352, 28),("Chile", -78.9196, -175.0417, 29),("Jersey", -29.3661, 53.8534, 30),("Mongolia", -6.0046, 54.0491, 31),("Malawi", 36.6162, 30.0938, 32),("Egypt", 2.8868, -86.307, 33),("Netherlands Antilles", -5.2489, -8.1189, 34),("Puerto Rico", 35.2169, 81.6494, 35),("Western Sahara", 78.9507, -115.2876, 36),("Afghanistan", 36.3092, -51.8533, 37),("Tajikistan", -65.0719, 173.756, 38),("Bolivia", 45.4393, 76.6563, 39),
         ("Cameroon", -57.0934, 28.1771, 40),("Faroe Islands", -45.4201, 169.7563, 41),("Christmas Island", -56.28, -20.3469, 42),("Gabon", -23.8703, -170.4683, 43),("Indonesia", -18.2142, -145.2607, 44),("Saint Helena", -15.6004, -106.1042, 45),("North Macedonia", -67.9909, 54.8589, 46),("Mali", -40.0128, -101.9131, 47),("Zambia", 21.5615, -81.9306, 48),("Dominican Republic", -81.4206, -19.29, 49),("Kyrgyz Republic", -79.5374, -127.5296, 50),("Benin", -11.7586, 0.9324, 51),("Greece", 55.617, -155.7908, 52),("Jamaica", 75.5682, 84.784, 53),("Uruguay", -50.2822, 178.8892, 54),("Barbados", 28.754, -100.9741, 55),("Tunisia", 34.298, -76.494, 56),("El Salvador", -25.1515, 106.6783, 57),("Cuba", 2.8686, -168.6801, 58),
         ("Belgium", -4.3788, -126.8095, 59),("Germany", 87.9755, -94.902, 60),("Congo", 65.7501, 34.6941, 61),("South Africa", 15.0578, -124.6145, 62),("Australia", -28.1648, -6.4204, 63),("Kiribati", -23.1331, -40.0564, 64),("Samoa", -32.0187, -163.4087, 65),("Solomon Islands", 71.3009, 146.8055, 66),("Suriname", -35.7165, 122.1398, 67),("Taiwan", 49.8541, 68.6352, 68),("United Arab Emirates", 80.3845, 2.3949, 69),("Cote d'Ivoire", -63.7189, 50.1919, 70),("Swaziland", 63.3744, -68.7936, 71),("Macao", -24.1264, -13.9336, 72),("Somalia", 43.8751, -107.6474, 73),("Monaco", 37.9852, -56.1643, 74),("Mexico", -50.1276, 151.176, 75),("Singapore", -25.0851, -86.2068, 76),("Syrian Arab Republic", 32.0982, 168.5806, 77),("Djibouti", -6.1674, 53.4817, 78),
         ("Togo", -41.2534, 78.2108, 79),("Martinique", -23.0509, 55.5984, 80),("Nepal", -38.4991, 112.7416, 81),("Madagascar", 79.8337, 157.4329, 82),("Latvia", -86.6328, -127.0801, 83),("Liechtenstein", 17.4756, 108.2528, 84),("Cayman Islands", 66.013, -16.7999, 85),("Russian Federation", -72.1085, -27.6623, 86),("Angola", 71.2498, 173.7014, 87),("Micronesia", -87.6009, -176.7387, 88),("Gambia", 87.0811, 106.7833, 89),("Kazakhstan", -55.8426, -80.6695, 90),("Algeria", 73.0217, -155.0861, 91),("Aruba", -89.4622, -52.211, 92),("Philippines", 28.1739, 1.471, 93),("Tuvalu", -52.7635, -44.6181, 94),("New Zealand", -60.1355, -163.1939, 95),("Grenada", -12.7073, 44.7485, 96),
         ("Malta", 89.6593, -2.0325, 97),("Israel", -42.8939, 72.8338, 98),("San Marino", -41.4289, -168.0831, 99),("Austria", -9.434, -71.5025, 100)]

carte = []
utenti = []
fatture = []
def associa():
    for a in range(500):
        intestatario = f.name()
        parti = intestatario.split()
        nome = parti[0]
        cognome = parti[1]
        email = f.email()
        pwd = f.password()
        abbo = random.choice(abbonamenti)
        data_nascita = datetime.now() - timedelta(days=18*365) - timedelta(days=random.randint(0, 32850))
        ann = random.randint(2025, 2040)
        mes = random.randint(1, 12)
        data_emis = datetime.now() - timedelta(days= random.randint(0,365))
        data_scad = data_emis + timedelta(days = 30)
        ncarta = f.bothify(text="################")
        codicvv = f.bothify(text="###")
        numeropaese = random.randint(1, 99)
        pa = paesi[numeropaese][0]
        utenti.append((a+1, cognome, nome, email, data_nascita.strftime('%Y-%m-%d'), pwd, abbo[0], pa))
        carte.append((ncarta, codicvv, intestatario, ann, mes, a+1))
        fatture.append((a+1, abbo[1], data_emis.strftime('%Y-%m-%d'), data_scad.strftime('%Y-%m-%d'), a+1, ncarta))
    return

def stampa_utenti():
    for codice, cognome, nome, email, data ,password, abb, paese in utenti:
        print(f'({codice}, "{cognome}", "{nome}", "{email}", "{data}", "{password}", "{abb}", "{paese}"),', end="")
        if(codice % 50 == 0):
            print(" ")
    print(" ")

def stampa_carte():
    for numero, cvv, intestatario, annoscad, mesescad, user in carte:
        print(f'("{numero}", {cvv}, "{intestatario}", {annoscad}, {mesescad}, TRUE, {user}),', end="")
        if(user % 50 == 0):
            print(" ")
    print(" ")

def stampa_fatture():
    for numero, saldo, emissione, scad, user, carta in fatture:
        print(f'({numero}, {saldo}, {emissione}, {scad}, {user}, "{carta}"),', end="")
        if(numero % 50 == 0):
            print(" ")
    print(" ")

if __name__ == "__main__":
    associa()
    print("utenti:")
    stampa_utenti()
    print("carte:")
    stampa_carte()
    print("fatture:")
    stampa_fatture()

 
