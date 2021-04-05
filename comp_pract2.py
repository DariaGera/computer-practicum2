import psycopg2
from config import config
import csv


# 5 варіант
# Порівняти середній бал з Історії України у кожному регіоні у 2020 та 2019 роках серед тих, кому було зараховано тест


def write_result(conn):
    cursor = conn.cursor()
    with open("Task_var5_CPract2.csv", "w", newline="") as file:
        writer = csv.writer(file)
        query_task = """
            select place.regname, test_result.exam_year, AVG(test_result.Ball100) as avgBall100
            from test_result
            join indwelling on indwelling.person_outid = test_result.exam_outid
            join place on place.place_id = indwelling.place_place_id
            where test_result.exam_test = 'Історія України' and 
                test_result.Ball100 is not null and
                test_result.Ball100 > 0.0
            group by place.regname, test_result.exam_year 
        """
        cursor.execute(query_task)
        writer.writerow(["regname", "zno_year", "avgBall100"])
        for regname, zno_year, avgball in cursor:
            writer.writerow([regname, zno_year, avgball])
    cursor.close()


def connect():
    """ Connect to the PostgreSQL database server """
    connection = None
    try:
        """ Connect to the PostgreSQL database server """
        params = config()
        # connect to the PostgreSQL server
        connection = psycopg2.connect(**params)
        connection.autocommit = False
        # create a cursor
        write_result(connection)
        print("result has just been written")

    except psycopg2.OperationalError:
        print("OperationalError")
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()
            print("Database connection closed.")


if __name__ == '__main__':
    connect()