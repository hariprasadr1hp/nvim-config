       IDENTIFICATION DIVISION.
       PROGRAM-ID. ExampleProgram.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile ASSIGN TO 'input.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OutputFile ASSIGN TO 'output.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  InputFile.
       01  InputRecord.
           05  InputID          PIC 9(5).
           05  InputName        PIC A(20).

       FD  OutputFile.
       01  OutputRecord.
           05  OutputID         PIC 9(5).
           05  OutputName       PIC A(20).
           05  OutputSalary     PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01  WS-Variables.
           05  WS-Salary        PIC 9(7)V99 VALUE 0.
           05  WS-Total         PIC 9(7)V99 VALUE 0.
           05  WS-Count         PIC 9(3) VALUE 0.

       01  WS-Employee-ID       PIC 9(5).
       01  WS-Employee-Name     PIC A(20).

       01  EndOfFile            PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-LOGIC SECTION.
           PERFORM INITIALIZATION.
           PERFORM PROCESS-FILE UNTIL EndOfFile = 'Y'.
           PERFORM TERMINATION.
           STOP RUN.

       INITIALIZATION.
           OPEN INPUT InputFile.
           OPEN OUTPUT OutputFile.

       PROCESS-FILE.
           READ InputFile INTO InputRecord
               AT END
                   MOVE 'Y' TO EndOfFile
               NOT AT END
                   PERFORM PROCESS-RECORD
           END-READ.

       PROCESS-RECORD.
           MOVE InputID TO WS-Employee-ID.
           MOVE InputName TO WS-Employee-Name.
           COMPUTE WS-Salary = 5000.00 + (WS-Employee-ID * 10).
           COMPUTE WS-Total = WS-Total + WS-Salary.
           ADD 1 TO WS-Count.

           MOVE WS-Employee-ID TO OutputID.
           MOVE WS-Employee-Name TO OutputName.
           MOVE WS-Salary TO OutputSalary.

           WRITE OutputRecord.

       TERMINATION.
           CLOSE InputFile.
           CLOSE OutputFile.
           DISPLAY 'Total Employees Processed: ' WS-Count.
           DISPLAY 'Total Salaries: ' WS-Total.

       END PROGRAM ExampleProgram.

