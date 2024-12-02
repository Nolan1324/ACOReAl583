int main(int argc, char *argv[]) {
  if (argc != 2) {
    return -1; // Ensure the program gets exactly one argument (apart from the program name)
  }

  // Ensure the argument has exactly 100 characters
  char *input = argv[1];
  int len = 0;
  while (input[len] != '\0') len++;
  if (len != 100) {
    return -1; // Return an error if input length is not 100
  }

  // Assign each character to a separate variable
  char c1 = input[0], c2 = input[1], c3 = input[2], c4 = input[3], c5 = input[4];
  char c6 = input[5], c7 = input[6], c8 = input[7], c9 = input[8], c10 = input[9];
  char c11 = input[10], c12 = input[11], c13 = input[12], c14 = input[13], c15 = input[14];
  char c16 = input[15], c17 = input[16], c18 = input[17], c19 = input[18], c20 = input[19];
  char c21 = input[20], c22 = input[21], c23 = input[22], c24 = input[23], c25 = input[24];
  char c26 = input[25], c27 = input[26], c28 = input[27], c29 = input[28], c30 = input[29];
  char c31 = input[30], c32 = input[31], c33 = input[32], c34 = input[33], c35 = input[34];
  char c36 = input[35], c37 = input[36], c38 = input[37], c39 = input[38], c40 = input[39];
  char c41 = input[40], c42 = input[41], c43 = input[42], c44 = input[43], c45 = input[44];
  char c46 = input[45], c47 = input[46], c48 = input[47], c49 = input[48], c50 = input[49];
  char c51 = input[50], c52 = input[51], c53 = input[52], c54 = input[53], c55 = input[54];
  char c56 = input[55], c57 = input[56], c58 = input[57], c59 = input[58], c60 = input[59];
  char c61 = input[60], c62 = input[61], c63 = input[62], c64 = input[63], c65 = input[64];
  char c66 = input[65], c67 = input[66], c68 = input[67], c69 = input[68], c70 = input[69];
  char c71 = input[70], c72 = input[71], c73 = input[72], c74 = input[73], c75 = input[74];
  char c76 = input[75], c77 = input[76], c78 = input[77], c79 = input[78], c80 = input[79];
  char c81 = input[80], c82 = input[81], c83 = input[82], c84 = input[83], c85 = input[84];
  char c86 = input[85], c87 = input[86], c88 = input[87], c89 = input[88], c90 = input[89];
  char c91 = input[90], c92 = input[91], c93 = input[92], c94 = input[93], c95 = input[94];
  char c96 = input[95], c97 = input[96], c98 = input[97], c99 = input[98], c100 = input[99];

  // Add all characters together
  int sum = c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8 + c9 + c10 +
            c11 + c12 + c13 + c14 + c15 + c16 + c17 + c18 + c19 + c20 +
            c21 + c22 + c23 + c24 + c25 + c26 + c27 + c28 + c29 + c30 +
            c31 + c32 + c33 + c34 + c35 + c36 + c37 + c38 + c39 + c40 +
            c41 + c42 + c43 + c44 + c45 + c46 + c47 + c48 + c49 + c50 +
            c51 + c52 + c53 + c54 + c55 + c56 + c57 + c58 + c59 + c60 +
            c61 + c62 + c63 + c64 + c65 + c66 + c67 + c68 + c69 + c70 +
            c71 + c72 + c73 + c74 + c75 + c76 + c77 + c78 + c79 + c80 +
            c81 + c82 + c83 + c84 + c85 + c86 + c87 + c88 + c89 + c90 +
            c91 + c92 + c93 + c94 + c95 + c96 + c97 + c98 + c99 + c100;

  int prod = c1 * c2 * c3 * c4 * c5 * c6 * c7 * c8 * c9 * c10 *
            c11 * c12 * c13 * c14 * c15 * c16 * c17 * c18 * c19 * c20 *
            c21 * c22 * c23 * c24 * c25 * c26 * c27 * c28 * c29 * c30 *
            c31 * c32 * c33 * c34 * c35 * c36 * c37 * c38 * c39 * c40 *
            c41 * c42 * c43 * c44 * c45 * c46 * c47 * c48 * c49 * c50 *
            c51 * c52 * c53 * c54 * c55 * c56 * c57 * c58 * c59 * c60 *
            c61 * c62 * c63 * c64 * c65 * c66 * c67 * c68 * c69 * c70 *
            c71 * c72 * c73 * c74 * c75 * c76 * c77 * c78 * c79 * c80 *
            c81 * c82 * c83 * c84 * c85 * c86 * c87 * c88 * c89 * c90 *
            c91 * c92 * c93 * c94 * c95 * c96 * c97 * c98 * c99 * c100;

  return sum + prod; // Return the sum as the program's exit code
}