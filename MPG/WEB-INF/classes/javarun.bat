@ECHO OFF
javac -cp C:\Users\vijay-pt4345\Desktop\MickeyLite\MickeyLite\lib\* *.java
ECHO Success
jar -cfm C:\Users\vijay-pt4345\Desktop\MickeyLite\MickeyLite\lib\Dream11.jar manifest.txt *.class
PAUSE


