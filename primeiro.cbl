








       IDENTIFICATION DIVISION.
       PROGRAM-ID. RESTCLIENT-EXAMPLE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-URL           PIC X(100) VALUE 
                    "https://api.github.com/users/GustavoGarciaPereira".
       01 WS-RESPONSE-XML  PIC X(10000).
       01 WS-RESPONSE-JSON PIC X(10000).
       01 WS-STATUS        PIC 9(3).
       01 WS-REQ-HEADERS.
          05 WS-ACCEPT      PIC X(50) VALUE "application/json".
          05 WS-USER-AGENT  PIC X(50) VALUE "COBOL RESTClient".
       01 WS-RESP-HEADERS.
          05 WS-CONTENT-TYPE PIC X(50).
       01 WS-REQUEST-TYPE  PIC X(10) VALUE "GET".
       
       PROCEDURE DIVISION.
       MAIN-LOGIC.
              CALL 'REST-INIT' USING BY REFERENCE WS-URL.
              CALL 'REST-SET-HEADER' USING WS-ACCEPT.
              CALL 'REST-SET-HEADER' USING WS-USER-AGENT.
              CALL 'REST-SET-REQUEST-TYPE' USING WS-REQUEST-TYPE.
              CALL 'REST-SEND-REQUEST' USING WS-STATUS.
              IF WS-STATUS = 200
                 CALL 'REST-GET-RESPONSE-HEADER' USING 'Content-Type'
                 WS-CONTENT-TYPE.
                 IF WS-CONTENT-TYPE = 'application/xml'
                    CALL 'REST-GET-RESPONSE-XML' USING WS-RESPONSE-XML.
                    DISPLAY "Response (XML): ", WS-RESPONSE-XML.
                 ELSE
                    CALL 'REST-GET-RESPONSE-JSON' USING WS-RESPONSE-JSON.
                    DISPLAY "Response (JSON): ", WS-RESPONSE-JSON.
                 END-IF
              ELSE
                 DISPLAY "Request failed. Status code: ", WS-STATUS.
              END-IF
              CALL 'REST-CLEANUP'.
       STOP RUN.
