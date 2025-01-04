import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == '⌫') {
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(Expression.parse(expressao), {});
  }

  Widget _botao(String valor, {Color? corTexto}) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.deepPurple.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          valor,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: corTexto ?? Colors.white),
        ),
        onPressed: () => _pressionarBotao(valor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.deepPurple.shade300,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Área de exibição de expressão e resultado
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade300, Colors.purple.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expressao,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                  Text(
                    _resultado.isEmpty ? '0' : _resultado,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Teclado de botões
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.all(10),
                children: [
                  _botao('('),
                  _botao(')'),
                  _botao('⌫', corTexto: Colors.red),
                  _botao('÷'),
                  _botao('7'),
                  _botao('8'),
                  _botao('9'),
                  _botao('x'),
                  _botao('4'),
                  _botao('5'),
                  _botao('6'),
                  _botao('-'),
                  _botao('1'),
                  _botao('2'),
                  _botao('3'),
                  _botao('+'),
                  _botao('0'),
                  _botao('.'),
                  _botao('='),
                  _botao(_limpar, corTexto: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
