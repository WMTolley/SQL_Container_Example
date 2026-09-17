from sql_project.sql_commands import (
    add_student_safely,
    connect_and_init,
    remove_student_safely,
    show_students,
)


def test_show_initial(capsys):
    connection = connect_and_init("Data/init.sql")
    show_students(connection)
    captured = capsys.readouterr()
    assert captured.out == "\n--- Students ---\nAlice Smith\nBob Johnson\n"


def test_show_addition(capsys):
    connection = connect_and_init("Data/init.sql")
    add_student_safely(connection, "John", "Wick", "donotrespond@ghost")
    show_students(connection)
    captured = capsys.readouterr()
    assert captured.out == "\n--- Students ---\nAlice Smith\nBob Johnson\nJohn Wick\n"


def test_show_removal(capsys):
    connection = connect_and_init("Data/init.sql")
    remove_student_safely(connection, 2)
    show_students(connection)
    captured = capsys.readouterr()
    assert (
        captured.out
        == "Successfully removed Student ID 2 and all their linked profiles/enrollments.\n\n--- Students ---\nAlice Smith\n"
    )
