class CalculationEarningHost {
  final double totalgeral = 1100;
  final double totalHost = 9.9;
  final double traficoInvalido = 22;
  final double dolar = 5.41;
  void call() {
    print(taxaTraficoInvalido);
    print((((totalHost * taxaTraficoInvalido) * dolar) * 0.30) * 0.985);
  }

  double get taxaTraficoInvalido => 1 - (traficoInvalido / totalgeral);
}
