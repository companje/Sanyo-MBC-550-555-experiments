#define DATA_PIN 2

void setup() {
  Serial.begin(115200);
  pinMode(DATA_PIN, INPUT_PULLUP);
}

bool checkEvenParity(uint8_t byte) {
  bool parity = 0;
  for (int i = 0; i < 8; i++) {
    if (byte & (1 << i)) parity = !parity;
  }
  return !parity;
}

void loop() {
  if (digitalRead(DATA_PIN) == LOW) {
    delayMicroseconds(400); // wacht halverwege het startbit om te centreren

    uint8_t data = 0;

    for (int i = 0; i < 8; i++) {
      delayMicroseconds(833);
      bool bit = digitalRead(DATA_PIN);
      data |= (bit << i);
    }

    delayMicroseconds(833);
    bool parityBit = digitalRead(DATA_PIN);

    delayMicroseconds(833);
    bool stopBit1 = digitalRead(DATA_PIN);

    delayMicroseconds(833);
    bool stopBit2 = digitalRead(DATA_PIN);

    bool evenParityOk = checkEvenParity(data);
    bool parityCorrect = (evenParityOk == (parityBit == 0));

    if (!stopBit1 || !stopBit2) {
      Serial.println("Fout: stopbits niet ontvangen");
      return;
    }

    if (!parityCorrect) {
      Serial.print("CTRL actief, toets: ");
    } else {
      Serial.print("Normale toets: ");
    }

    Serial.print((char)data);
    Serial.print(" (0x");
    Serial.print(data, HEX);
    Serial.println(")");
  }
}
