10 OPEN "O",#1,"asmsound.bin"
20 FOR A=&h100 TO &h13B;:READ D$:PRINT #1,CHR$(VAL("&h"+D$));:NEXT
30 CLOSE #1
40 DATA eb,2,0,0,fa,8b,ec,1e,c5,5e,8,8b,f,c5,5e,4,8b,17,e,1f,2e,89,e,2,1,b8,35,0,34,8,e6,3a,fe,cc,75,3,4a,74,9,e2,f7,2e,8b,e,2,1,eb,ec,34,8,3c,35,75,2,e6,3a,1f,ca,8,0
