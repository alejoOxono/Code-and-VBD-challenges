7
11 6
4 4
11 7
6 3
4 11
10 3
11 3

295526 70 2783891 76 381304 340 451

11pow5-->161051
134475
26576

2 6

000000
111111
100000
110000
111000
111100
111110
101010
110111
110011
110110
110100
111011
111001


maximo comun divisor entre contador y bolitas y devolver el segundo numero
devolver mcd mientras que el contador sea menor a bolitas
por cada ciclo realizar una potencia de los colores por el mcd


int maximumComDiv (int firstNum, int secondNum) {
  int aux = firstNum % secondNum;
  if (aux > 0) {
    firstNum = secondNum;
    secondNum = aux;
    return maximumComDiv (firstNum, secondNum);
  }
  else {
    return secondNum;
  }
}

double necklaceCount (String? inputLine, int cont, double result) {
  int colors = int.parse(inputLine!.split(" ")[0]);
  int beads = int.parse(inputLine.split(" ")[1]);
  if (cont < beads) {
    var aux = pow(colors, maximumComDiv(cont, beads));
    result = result + aux;
    return necklaceCount(inputLine, cont + 1, result);
  }
  else {
    return result / beads;
  }
}


2 2   -1 2 (1)-   -2 2 (2)-
       {1}            {4} 
      5/2   2

2 6   -1 6 (1)-  -2 6 (2)-  -3 6 (3)-  -4 6 (2)-  -5 6 (1)-  -6 6 (6)- 
        {2}        {4}          {8}        {4}      {2}        {64}      
      14

2 4   -1 4 (1)-  -2 4 (2)-  -3 4 (3)-  -4 4 (2)-
        {2}        {4}          {8}     {4}
      
3 3   -1 3 (1)-  -2 3 (1)-  -3 3 (3)-
        {3}         {3}         {27}
        33/3
        11