import 'package:flutter/material.dart';
import 'package:neighsecure/components/text/selected_days_text.dart';

import '../buttons/custom_elevated_button.dart';
import '../text/custom_text.dart';
import '../text/date_text.dart';

import '../../enums/date_picker_mode.dart' as datepickermodeenum;

class MultipleEntryCard extends StatefulWidget {
  final TimeOfDay? timeStart;
  final TimeOfDay? timeEnd;
  final DateTime? dateStart;
  late final datepickermodeenum.DatePickerMode datePickerMode;
  final DateTime? dateEnd;
  final List<int>? selectDaysOfWeek;
  final Function selectTimeStart;
  final Function selectTimeEnd;
  final Function selectDate;

  MultipleEntryCard({super.key,
    required this.timeStart,
    required this.timeEnd,
    required this.dateStart,
    required this.datePickerMode,
    required this.dateEnd,
    required this.selectDaysOfWeek,
    required this.selectTimeStart,
    required this.selectTimeEnd,
    required this.selectDate,
  });

  @override
  _MultipleEntryCardState createState() => _MultipleEntryCardState();
}

class _MultipleEntryCardState extends State<MultipleEntryCard> {

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(bottom: 30),
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  CustomText(
                    instruction: 'Entrada multiple',
                    fontSize: 16,
                      color: Colors.grey
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomText(
                  instruction:
                  'Selecciona un rango de horas.',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          widget.timeStart == null
                              ? 'Hora de inicio'
                              : widget.timeStart!
                              .format(context),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Transform.rotate(
                            angle: 90 * 3.14159 / 180,
                            child: IconButton(
                              onPressed: () {
                                widget.selectTimeStart(context);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 24,
                              ),
                            )),
                        const SizedBox(width: 24),
                        Text(
                          widget.timeEnd == null
                              ? 'Hora de fin'
                              : widget.timeEnd!.format(context),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Transform.rotate(
                            angle: 90 * 3.14159 / 180,
                            child: IconButton(
                              onPressed: () {
                                widget.selectTimeEnd(context);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 24,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomText(
                  instruction:
                  'Selecciona el dia o rango de dias.',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  DropdownButton<datepickermodeenum.DatePickerMode?>(
                    value: widget.datePickerMode,
                    onChanged: (datepickermodeenum.DatePickerMode? newValue) {
                      setState(() {
                        widget.datePickerMode = newValue!;
                      });
                    },
                    items: const <DropdownMenuItem<datepickermodeenum.DatePickerMode?>>[
                      DropdownMenuItem<datepickermodeenum.DatePickerMode>(
                        value: datepickermodeenum.DatePickerMode.single,
                        child: Text(
                          'Single',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      DropdownMenuItem<datepickermodeenum.DatePickerMode>(
                        value: datepickermodeenum.DatePickerMode.range,
                        child: Text(
                          'Range',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      DropdownMenuItem<datepickermodeenum.DatePickerMode>(
                        value: datepickermodeenum.DatePickerMode.multiple,
                        child: Text(
                          'Multiple',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(onPressed: () {
                    widget.selectDate(context);
                  }, text: 'Seleccionar fechas'),
                ],
              ),
              widget.dateStart != null
                  ? DateText(
                  date: widget.dateStart!,
                  label: 'Fecha de inicio')
                  : const SizedBox(),
              widget.dateEnd != null
                  ? DateText(
                  date: widget.dateEnd!,
                  label: 'Fecha de fin')
                  : const SizedBox(),
              widget.selectDaysOfWeek!.isNotEmpty
                  ? SelectedDaysText(
                  selectedDays: widget.selectDaysOfWeek)
                  : const SizedBox(),
            ]),
      ),
    );
  }
}