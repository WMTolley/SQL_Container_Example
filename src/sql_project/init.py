"""Modifies the SQL database, after reinitializing the database"""

from sql_project.sql_commands import (
    add_student_safely,
    connect_and_init,
    demonstrate_relationships,
    show_students,
)

if __name__ == "__main__":
    connection = connect_and_init("Data/init.sql")
    show_students(connection)

    add_student_safely(connection, "Todd", "Howard", "terribleExample@help.org")

    show_students(connection)
    demonstrate_relationships(connection)

    connection.close()
