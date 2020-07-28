import psycopg2
import csv

timeline = ['8:30', '10:15', '12:00', '13:45', '15:30', '17:15', '19:00']
day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
class_type = ['lab', 'sem', 'lec']

subjects = [1, 2, 3, 4, 5]
groups = [1, 2, 3, 4]

# EXTRACT SUBJECT_GROUPS_VIEW FROM DB
try:
    connection = psycopg2.connect(user = "postgres",
                                  password = "postgres",
                                  host = "127.0.0.1",
                                  port = "5432",
                                  database = "schedule_db")

    cursor = connection.cursor()
    sub_group_view = "select * from subject_groups_view"
    cursor.execute(sub_group_view)
    view_record = cursor.fetchall()

except(Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL", error)
finally:
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")


print("Sub_id, Group_id")
for row in view_record:
    print(row)




# for i in range(len(groups)):
#     for j in range(len(subjects)):
#         for k in range(len(class_type)):
#             print(f'Group_id = {groups[i]} has {class_type[k]} in subject {subjects[j]}')


List of [group_id, class_type, subject_id]
timetable = []
temp_timetable = []
for group in groups:
    temp_gr = group
    temp_gr += 4
    for subject in subjects:
        temp_sub = subject
        temp_sub += 5
        for _type in class_type:
            # print(f'Group_id = {group} has {_type} in subject {subject}')
            timetable.append([group, _type, subject])
            temp_timetable.append([temp_gr, _type, temp_sub])







