void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(3, OUTPUT);
}

void loop() {
//  int a = ;
//  int a = digitalRead(2);
//  Serial.println(a);
//  Serial.print(" ");
//  Serial.println(b);
  digitalWrite(3,digitalRead(2));
  delay(100);
}
