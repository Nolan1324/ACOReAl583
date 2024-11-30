int main(int argc, char** argv) {
  int x = argv[1][0];
  int y = argv[1][1];
  int z = argv[1][2];

  x = y+z;
  y = x+y;
  y = z+x;

  return argc;
}