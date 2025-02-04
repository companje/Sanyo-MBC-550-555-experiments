%include "sanyo.asm"

setup:
  println "The year 2674, Aliens from an other"
  println "galaxy came into our galaxy and"
  println "wanted to destroy the earth."
  hlt


times (180*1024)-($-$$) db 0
