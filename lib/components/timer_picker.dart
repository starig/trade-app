import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_app/cubits/trade/trade_cubit.dart';

class TimerPickerDialog extends StatefulWidget {
  final int selectedMinutes;
  final int selectedSeconds;

  const TimerPickerDialog(
      {Key? key, required this.selectedSeconds, required this.selectedMinutes})
      : super(key: key);

  @override
  _TimerPickerDialogState createState() => _TimerPickerDialogState();
}

class _TimerPickerDialogState extends State<TimerPickerDialog> {
  late int selectedMinutes;
  late int selectedSeconds;

  List<int> minutesList = List.generate(60, (index) => index);
  List<int> secondsList = List.generate(60, (index) => index);

  @override
  void initState() {
    super.initState();
    selectedMinutes = widget.selectedMinutes;
    selectedSeconds = widget.selectedSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Time'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton<int>(
            value: selectedMinutes,
            onChanged: (value) {
              setState(() {
                selectedMinutes = value!;
              });
            },
            items: minutesList.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString().padLeft(2, '0')),
              );
            }).toList(),
          ),
          Text(':'),
          DropdownButton<int>(
            value: selectedSeconds,
            onChanged: (value) {
              setState(() {
                selectedSeconds = value!;
              });
            },
            items: secondsList.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString().padLeft(2, '0')),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Set'),
          onPressed: () {
            String timeString =
                '${selectedMinutes.toString().padLeft(2, '0')}:${selectedSeconds.toString().padLeft(2, '0')}';
            context.read<TradeCubit>().setTimerCount(
                Timer(minutes: selectedMinutes, seconds: selectedSeconds));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
