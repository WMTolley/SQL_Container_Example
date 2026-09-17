"""Modifies the SQL database, without reinitializing the database"""

from sql_project.sql_commands import (
    add_student_safely,
    connect_and_init,
    get_studentids_from_firstname_safely,
    remove_student_safely,
    show_students,
)

if __name__ == "__main__":
    connection = connect_and_init("Data/continue.sql")

    add_student_safely(connection, "Alex", "Rider", "secret@email")

    indexes_named_bob = get_studentids_from_firstname_safely(connection, "Bob")
    if len(indexes_named_bob) > 0:
        index_to_remove = indexes_named_bob[0]
        print("There is a bob with ID: " + str(index_to_remove))
        remove_student_safely(connection, index_to_remove)
    else:
        print("There is no one named Bob")

    show_students(connection)

    connection.close()
