import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculationRecord {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationRecord({
    required this.expression,
    required this.result,
    required this.timestamp,
  });
}

enum AngleMode { deg, rad }

class CalculatorController extends ChangeNotifier {
  String _primaryDisplay = '0';
  String _expressionDisplay = '';
  String _lastResult = '0';
  bool _waitingForNewOperand = false;
  AngleMode _angleMode = AngleMode.deg;
  final List<CalculationRecord> _history = [];

  String get primaryDisplay => _primaryDisplay;
  String get expressionDisplay => _expressionDisplay;
  String get lastResult => _lastResult;
  bool get waitingForNewOperand => _waitingForNewOperand;
  AngleMode get angleMode => _angleMode;
  List<CalculationRecord> get history => List.unmodifiable(_history);

  void toggleAngleMode() {
    _angleMode = _angleMode == AngleMode.deg ? AngleMode.rad : AngleMode.deg;
    notifyListeners();
  }

  void onKeyPressed(String key) {
    switch (key) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        _handleDigit(key);
        break;
      case '.':
        _handleDecimal();
        break;
      case 'AC':
        clearAll();
        break;
      case 'C':
        clearEntry();
        break;
      case 'BACKSPACE':
      case '⌫':
        backspace();
        break;
      case '%':
        _handlePercent();
        break;
      case '()':
        _handleParentheses();
        break;
      case '+':
      case '−':
      case '-':
      case '×':
      case '*':
      case '÷':
      case '/':
        _handleOperator(key);
        break;
      case '=':
        evaluate();
        break;
      case '+/-':
        _toggleSign();
        break;
      case 'π':
        _insertConstant(math.pi.toString());
        break;
      case 'e':
        _insertConstant(math.e.toString());
        break;
      case 'sin':
      case 'cos':
      case 'tan':
      case 'ln':
      case 'log':
      case '√':
      case '^':
        _handleScientific(key);
        break;
      default:
        break;
    }
  }

  void _handleDigit(String digit) {
    if (_waitingForNewOperand || _primaryDisplay == '0' || _primaryDisplay == 'Error') {
      _primaryDisplay = digit;
      _waitingForNewOperand = false;
    } else {
      if (_primaryDisplay.replaceAll('.', '').replaceAll('-', '').length < 15) {
        _primaryDisplay += digit;
      }
    }
    notifyListeners();
  }

  void _handleDecimal() {
    if (_waitingForNewOperand || _primaryDisplay == 'Error') {
      _primaryDisplay = '0.';
      _waitingForNewOperand = false;
    } else if (!_primaryDisplay.contains('.')) {
      _primaryDisplay += '.';
    }
    notifyListeners();
  }

  void clearAll() {
    _primaryDisplay = '0';
    _expressionDisplay = '';
    _waitingForNewOperand = false;
    notifyListeners();
  }

  void clearEntry() {
    _primaryDisplay = '0';
    notifyListeners();
  }

  void clearTape() {
    _expressionDisplay = '';
    notifyListeners();
  }

  void backspace() {
    if (_primaryDisplay == 'Error' || _waitingForNewOperand) {
      _primaryDisplay = '0';
    } else if (_primaryDisplay.length > 1) {
      if (_primaryDisplay.length == 2 && _primaryDisplay.startsWith('-')) {
        _primaryDisplay = '0';
      } else {
        _primaryDisplay = _primaryDisplay.substring(0, _primaryDisplay.length - 1);
      }
    } else {
      _primaryDisplay = '0';
    }
    notifyListeners();
  }

  void _handlePercent() {
    try {
      final val = double.parse(_primaryDisplay);
      final result = val / 100.0;
      _primaryDisplay = _formatCleanNumber(result);
      notifyListeners();
    } catch (_) {}
  }

  void _toggleSign() {
    if (_primaryDisplay == '0' || _primaryDisplay == 'Error') return;
    if (_primaryDisplay.startsWith('-')) {
      _primaryDisplay = _primaryDisplay.substring(1);
    } else {
      _primaryDisplay = '-$_primaryDisplay';
    }
    notifyListeners();
  }

  void _handleParentheses() {
    if (_primaryDisplay.startsWith('(') && _primaryDisplay.endsWith(')')) {
      _primaryDisplay = _primaryDisplay.substring(1, _primaryDisplay.length - 1);
    } else {
      _primaryDisplay = '($_primaryDisplay)';
    }
    notifyListeners();
  }

  void _insertConstant(String val) {
    final doubleVal = double.tryParse(val);
    if (doubleVal != null) {
      _primaryDisplay = _formatCleanNumber(doubleVal);
      _waitingForNewOperand = true;
      notifyListeners();
    }
  }

  void _handleScientific(String func) {
    try {
      final val = double.parse(_primaryDisplay);
      double res = 0;
      if (func == '√') {
        if (val < 0) throw Exception('Negative square root');
        res = math.sqrt(val);
      } else if (func == 'sin') {
        final rad = _angleMode == AngleMode.deg ? (val * math.pi / 180.0) : val;
        res = math.sin(rad);
      } else if (func == 'cos') {
        final rad = _angleMode == AngleMode.deg ? (val * math.pi / 180.0) : val;
        res = math.cos(rad);
      } else if (func == 'tan') {
        final rad = _angleMode == AngleMode.deg ? (val * math.pi / 180.0) : val;
        res = math.tan(rad);
      } else if (func == 'ln') {
        if (val <= 0) throw Exception('Invalid ln input');
        res = math.log(val);
      } else if (func == 'log') {
        if (val <= 0) throw Exception('Invalid log input');
        res = math.log(val) / math.ln10;
      } else if (func == '^') {
        _expressionDisplay = '$_primaryDisplay ^ ';
        _waitingForNewOperand = true;
        notifyListeners();
        return;
      }
      _expressionDisplay = '$func($_primaryDisplay)';
      _primaryDisplay = _formatCleanNumber(res);
      _lastResult = _primaryDisplay;
      _history.insert(
        0,
        CalculationRecord(
          expression: _expressionDisplay,
          result: _primaryDisplay,
          timestamp: DateTime.now(),
        ),
      );
      _waitingForNewOperand = true;
      notifyListeners();
    } catch (_) {
      _primaryDisplay = 'Error';
      notifyListeners();
    }
  }

  void _handleOperator(String op) {
    final normOp = (op == '-' ? '−' : (op == '*' ? '×' : (op == '/' ? '÷' : op)));

    if (_expressionDisplay.isNotEmpty && !_waitingForNewOperand) {
      _evaluateInterim();
    }

    _expressionDisplay = '${formatForDisplay(_primaryDisplay)} $normOp ';
    _waitingForNewOperand = true;
    notifyListeners();
  }

  void _evaluateInterim() {
    try {
      final fullExpr = _expressionDisplay + _primaryDisplay;
      final clean = _sanitizeForEval(fullExpr);
      final p = ShuntingYardParser();
      final exp = p.parse(clean);
      final cm = ContextModel();
      final eval = exp.evaluate(EvaluationType.REAL, cm);
      if (eval.isInfinite || eval.isNaN) {
        _primaryDisplay = 'Error';
      } else {
        _primaryDisplay = _formatCleanNumber(eval as double);
        _lastResult = _primaryDisplay;
      }
    } catch (_) {}
  }

  void evaluate() {
    if (_primaryDisplay == 'Error') return;
    try {
      final fullExpr = _expressionDisplay + (_waitingForNewOperand ? '' : _primaryDisplay);
      if (fullExpr.trim().isEmpty) return;

      final clean = _sanitizeForEval(fullExpr);
      final p = ShuntingYardParser();
      final exp = p.parse(clean);
      final cm = ContextModel();
      final eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite || eval.isNaN) {
        _primaryDisplay = 'Error';
      } else {
        final res = _formatCleanNumber(eval as double);
        final fullTape = fullExpr;
        _primaryDisplay = res;
        _lastResult = res;

        _history.insert(
          0,
          CalculationRecord(
            expression: fullTape,
            result: res,
            timestamp: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      _primaryDisplay = 'Error';
    }
    _expressionDisplay = '';
    _waitingForNewOperand = true;
    notifyListeners();
  }

  void restoreFromHistory(CalculationRecord record) {
    _primaryDisplay = record.result;
    _expressionDisplay = record.expression;
    _waitingForNewOperand = true;
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  String _sanitizeForEval(String expr) {
    return expr
        .replaceAll(',', '')
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('−', '-');
  }

  String _formatCleanNumber(double val) {
    if (val.isInfinite || val.isNaN) return 'Error';
    final rounded = double.parse(val.toStringAsFixed(8));
    if (rounded == rounded.roundToDouble()) {
      return rounded.toInt().toString();
    }
    var str = rounded.toString();
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0+$'), '');
      str = str.replaceAll(RegExp(r'\.$'), '');
    }
    return str;
  }

  static String formatForDisplay(String value) {
    if (value.isEmpty) return '0';
    if (value == 'Error' || value == 'NaN') return value;
    final isNegative = value.startsWith('-');
    final cleanVal = isNegative ? value.substring(1) : value;

    final parts = cleanVal.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    final num = int.tryParse(integerPart);
    final formattedInt = num != null ? NumberFormat('#,##0', 'en_US').format(num) : integerPart;

    return '${isNegative ? '-' : ''}$formattedInt$decimalPart';
  }
}
