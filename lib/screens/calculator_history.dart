import 'package:calculator/models/model_calculation_history_item.dart';
import 'package:calculator/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculatorHistoryScreen extends StatefulWidget {
  final List<CalculationHistoryItem>? history;
  const CalculatorHistoryScreen({super.key, this.history});

  @override
  State<CalculatorHistoryScreen> createState() =>
      _CalculatorHistoryScreenState();
}

class _CalculatorHistoryScreenState extends State<CalculatorHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text(
          "Calculator",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 0,
      ),
      backgroundColor: color3,
      body: ListView.builder(
          itemCount: widget.history!.length,
          itemBuilder: (context, index) {
            final item = widget.history?[index];
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [background, color1]),
                      color: color1,
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          delete(item);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.black87,
                          size: 30,
                        )),
                    title: Text(
                      item!.result,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    subtitle: Text(item.equation,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ));
          }),
    );
  }

  delete(item) {
    widget.history?.remove(item);
  }
}
