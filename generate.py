import csv

# Generate data for fac_sub table
fac_sub = []
sub_id = 0
for fac_id in range(1, 21):
    for j in range(5):
        sub_id += 1
        fac_sub.append(str(fac_id) + "," + str(sub_id))

wtr = csv.writer(open ('fac_sub.csv', 'w'), delimiter=',', lineterminator='\n')
for x in fac_sub : wtr.writerow ([x])

# Generate data for classes
classes = []