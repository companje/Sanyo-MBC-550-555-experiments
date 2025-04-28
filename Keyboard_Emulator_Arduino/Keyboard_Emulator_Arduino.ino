#define DATA_OUT_PIN 3

bool ctrl = false;

void setup() {
  Serial.begin(115200);
  pinMode(DATA_OUT_PIN, OUTPUT);
  digitalWrite(DATA_OUT_PIN, HIGH);
  delay(1000);
}

bool calculateEvenParity(uint8_t byte) {
  bool parity = 0;
  for (int i = 0; i < 8; i++) {
    if (byte & (1 << i)) parity = !parity;
  }
  return parity;  // true als oneven aantal bits, false als even
}

void sendByte(uint8_t data, bool ctrl) {
  bool parity = calculateEvenParity(data);

  if (ctrl) {
    parity = !parity;
  }

  digitalWrite(DATA_OUT_PIN, LOW);
  delayMicroseconds(833);

  for (int i = 0; i < 8; i++) {
    bool bit = (data >> i) & 0x01;
    digitalWrite(DATA_OUT_PIN, bit ? HIGH : LOW);
    delayMicroseconds(833);
  }

  digitalWrite(DATA_OUT_PIN, parity ? HIGH : LOW);
  delayMicroseconds(833);

  digitalWrite(DATA_OUT_PIN, HIGH);
  delayMicroseconds(833);

  digitalWrite(DATA_OUT_PIN, HIGH);
  delayMicroseconds(833);
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();

    if (c == '^') {
      //TEST ME
      sendByte(Serial.read(), true);
    } else {
      sendByte(c, false);
    }

    // delay(100);
  }
}
