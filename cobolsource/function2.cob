000010 IDENTIFICATION DIVISION.
000050* THIS IS A COBOL PROGRAM THAT WILL RUN IN LAMBDA.
000060* It will run a loop 4 times, concatinate some strings.
000061* And add the expceted attributes for API Gateway.
000070 PROGRAM-ID. Cobol-Ledger.
000080 DATA DIVISION.
000090 WORKING-STORAGE SECTION.
000100 01 LOOP_COUNT PIC 9(1) VALUE 0.
000110 01 WS-MESSAGE PIC X(1500).
000120 01 WS-LAMBDA PIC X(1000).
000130 01 WS-COUNT PIC 99 VALUE 1.
000140 01 WS-COUNTR PIC 99 VALUE 1.
000150 01 WS-TMP PIC X(10).

000160 PROCEDURE DIVISION.
        A-PARA.
        MOVE 'Hi lambda from COBOL' TO WS-MESSAGE
        PERFORM B-LAMBDAFORMAT
        DISPLAY FUNCTION TRIM(WS-LAMBDA)
        STOP RUN.

        B-LAMBDAFORMAT.
        STRING '{'
                '"statusCode": 200,'
                '"body":'
                '"{\"message\":\"'
                FUNCTION TRIM(WS-MESSAGE)
                '\",'
                '\"runtime\":\"COBOL\",'
                '\"function\":\"Function: 2\"'
                '}"}'
                INTO WS-LAMBDA
                WITH POINTER WS-COUNT
                ON OVERFLOW DISPLAY 'OVERFLOW!'
        END-STRING.
