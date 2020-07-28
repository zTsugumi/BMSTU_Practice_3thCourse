import psycopg2
import csv

timeline = ['8:30', '10:15', '12:00', '13:45', '15:30', '17:15', '19:00']
day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
class_type = ['lab', 'sem', 'lec']

CLASSROOMS = {
            '101': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [4, 4, 5, 5, 3, 5]],
            '102': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '103': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]],
            '104': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [4, 4, 5, 5, 3, 5]],
            '105': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '201': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]],
            '202': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [4, 4, 5, 5, 3, 5]],
            '203': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '204': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]],
            '205': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [4, 4, 5, 5, 3, 5]],
            '301': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '302': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]],
            '303': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [4, 4, 5, 5, 3, 5]],
            '304': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '305': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]],
            '401': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '402': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]],
            '403': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [4, 4, 5, 5, 3, 5]],
            '404': [['12:00', '12:00', '8:30', '10:15', '10:15', '8:30'], [2, 3, 5, 5, 4, 6]],
            '405': [['8:30', '12:00', '8:30', '12:00', '8:30', '10:15'], [6, 1, 2, 1, 3, 4]]
            }


# FACULTY_SUBJECT TABLE
fac_sub = []
sub_id = 0
for fac_id in range(1, 21):
    for j in range(5):
        sub_id += 1
        fac_sub.append(str(fac_id) + "," + str(sub_id))


# RETURN THE INDEX OF THE ELEMENT IN ARRAY
def get_index(elem, array):
    found = None
    for i in range(len(array)):
        if array[i] == elem:
            found = i

    return found


# CLASSROOM SCHEDULE DURING THE WEEK
classroom_schedule = []
for key in CLASSROOMS:
    for i in range(6):
        start = get_index(CLASSROOMS[key][0][i], timeline)
        for j in range(CLASSROOMS[key][1][i]):
            classroom_schedule.append([key, day[i], timeline[start]])
            start += 1


# WRITE DATA TO CLASS TABLE
with open("out.csv", 'w', newline='') as csvfile:
    fieldnames = ['subject_id', 'classroom_id', 'group_id', 'day', 'start_time', 'class_type']
    writer =csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

    for row in classroom_schedule:
        writer.writerow({'subject_id':'_', 
                        'classroom_id': row[0], 
                        'group_id': '_', 
                        'day': row[1], 
                        'start_time': row[2],
                        'class_type': '_'})
