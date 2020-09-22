import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmountField extends StatefulWidget {
  final InputDecoration decoration;
  final void Function(String value) onChanged;

  const AmountField({
    Key key,
    this.decoration,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  final _controller = TextEditingController(text: '0.00');

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      var text = _controller.text;

      if (RegExp(r'[.,]$').hasMatch(text)) text += '00';

      final temp = double.tryParse(text.replaceAll(RegExp(r'[^\d]'), ''));
      text = temp != null ? (temp / 100).toStringAsFixed(2) : '0.00';

      final pos = text.length;

      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: pos, extentOffset: pos),
        composing: TextRange.empty,
      );

      widget.onChanged(text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: TextDirection.rtl,
      controller: _controller,
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      decoration: widget.decoration,
    );
  }
}
