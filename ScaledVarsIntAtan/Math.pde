int scale = 10;

int myAtan(int x) {
  if (abs(x) > scale) {
    if (x > 0) {
      return 90 - myAtan(scale*scale / x);
    } else {
      return -90 - myAtan(scale*scale / x);
    }
  }

  int result = 0;
  int term = x;
  int x2 = (x * x) / scale;
  int sign = 1;

  for (int i = 1; i < 50; i += 2) {
    result += (sign * term) / i;
    term = (term * x2) / scale;
    sign *= -1;
  }
  return result * 180 / int(PI*scale);
}

int myAtan2(int y, int x) {
  if (x == 0) return y > 0 ? 90 : y < 0 ? -90 : 0;
  return myAtan((y * scale) / x) + (x > 0 ? 0 : y < 0 ? -180 : 180);
}
