import 'package:day_picker/day_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neighsecure/components/text/custom_text.dart';
import 'package:neighsecure/components/text/date_text.dart';
import 'package:neighsecure/components/text/selected_days_text.dart';
import 'package:neighsecure/controllers/permission_controller.dart';
import 'package:neighsecure/screens/splashscreen/splash_screen.dart';

import '../../../../../../../../models/entities/user.dart';

enum DatePickerMode { single, range, multiple }

enum EntryType { single, multiple }

class AddingVisit extends ConsumerStatefulWidget {
  const AddingVisit({super.key, required this.user});

  final User user;

  @override
  ConsumerState<AddingVisit> createState() => _AddingVisitState();
}

class _AddingVisitState extends ConsumerState<AddingVisit> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';

  TimeOfDay? _timeStart;

  TimeOfDay? _timeStartRange;

  TimeOfDay? _timeEndRange;

  TimeOfDay? _timeEnd;

  DateTime? _dateStart;

  DateTime? _dateEnd;

  final bool _selectOnlyEntry = false;

  final bool _selectMultiEntry = false;

  DatePickerMode _datePickerMode = DatePickerMode.single;

  final customWidgetKey = GlobalKey<SelectWeekDaysState>();

  late List<int>? _selectDaysOfWeek = [];

  EntryType _entryType = EntryType.single;

  final PermissionController _controller = PermissionController();

  List<String> translateDaysToSpanish(List<int>? daysOfWeek) {
    if (daysOfWeek == null) {
      return [];
    }

    Map<int, String> daysInSpanish = {
      1: 'Lunes',
      2: 'Martes',
      3: 'Miercoles',
      4: 'Jueves',
      5: 'Viernes',
      6: 'Sabado',
      7: 'Domingo',
    };

    return daysOfWeek.map((day) => daysInSpanish[day]!).toList();
  }

  void _adjustTimeStart() {
    if (_timeStart != null) {
      int newMinute = _timeStart!.minute - 30;
      int newHour = _timeStart!.hour;

      if (newMinute < 0) {
        newMinute += 60; // Ajusta los minutos sumando 60
        newHour -= 1; // Decrementa la hora

        if (newHour < 0) {
          // Ajusta para el cambio de día hacia atrás
          newHour = 23;
        }
      }

      _timeStartRange = TimeOfDay(hour: newHour, minute: newMinute);
    }
  }

  void _adjustTimeEndRange() {
    if (_timeStart != null) {
      TimeOfDay? timeEnd = _timeStart;
      int newHour = timeEnd!.hour;
      int newMinute = timeEnd.minute + 30;

      if (newMinute >= 60) {
        newMinute -= 60; // Resta 60 para obtener los minutos restantes
        newHour += 1; // Incrementa la hora

        if (newHour >= 24) {
          // Ajusta para el cambio de día
          newHour = 0;
        }
      }

      _timeEndRange = TimeOfDay(hour: newHour, minute: newMinute);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    switch (_datePickerMode) {
      case DatePickerMode.single:
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );

        if (picked != null) {
          setState(() {
            _dateStart = picked;
            _dateEnd = picked;
          });
          if (kDebugMode) {
            print('Selected Date: ${picked.toString()}');
          }
        }
        break;
      case DatePickerMode.range:
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );

        if (picked != null) {
          setState(() {
            _dateStart = picked.start;
            _dateEnd = picked.end;
          });
          if (kDebugMode) {
            print('Start Date: ${picked.start.toString()}');
            print('End Date: ${picked.end.toString()}');
          }
        }
        break;

      case DatePickerMode.multiple:
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );

        if (picked != null) {
          setState(() {
            _dateStart = picked.start;
            _dateEnd = picked.end;
          });
        }

        List<int>? selectedDaysOfWeek = await showDialog<List<int>>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Selecciona los dias se la semana',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        for (var i = 1; i <= 7; i++)
                          CheckboxListTile(
                            title: Text(
                              DateFormat.E().format(DateTime(2024, 1, i)),
                            ),
                            value: _selectDaysOfWeek?.contains(i),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectDaysOfWeek?.add(i);
                                } else {
                                  _selectDaysOfWeek?.remove(i);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(_selectDaysOfWeek);
                  },
                ),
              ],
            );
          },
        );

        if (picked != null) {
          setState(() {
            _selectDaysOfWeek = selectedDaysOfWeek;
          });
        }

        break;
    }
  }

  Future<void> _selectTimeStart(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      if (kDebugMode) {
        print(picked.format(context));
      }
      setState(() {
        _timeStart = picked;
      }); // print the selected time in HH:MM format
    }
  }

  Future<void> _selectTimeEnd(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && mounted) {
      if (kDebugMode) {
        print(picked.format(context));
      }
      setState(() {
        _timeEnd = picked;
      }); // print the selected time in HH:MM format
    }
  }

  Future<void> _selectTimeRangeStart(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && mounted) {
      if (kDebugMode) {
        print(picked.format(context));
      }
      setState(() {
        _timeStartRange = picked;
      }); // print the selected time in HH:MM format
    }
  }

  Future<void> _selectTimeRangeEnd(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && mounted) {
      if (kDebugMode) {
        print(picked.format(context));
      }
      setState(() {
        _timeEndRange = picked;
      }); // print the selected time in HH:MM format
    }
  }

  void showErrorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 20),
            const Text('Error!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 20),
            const Text(
                'Por favor selecciona si la visita es de entrada única o múltiple.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF001E2C),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 28,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  'Listo',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showInvitationErrorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 20),
            const Text('Error!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 20),
            const Text(
                'No ha sido posible enviadar la invitación al correo electrónico que has proporcionado.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF001E2C),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 28,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  'Listo',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> getDaysInRange(DateTime? startDate, DateTime? endDate) {
    List<String> days = [];
    DateTime tempDate = startDate!;

    while (tempDate.isBefore(endDate!.add(const Duration(days: 1)))) {
      switch (tempDate.weekday) {
        case 1:
          days.add('Lunes');
          break;
        case 2:
          days.add('Martes');
          break;
        case 3:
          days.add('Miercoles');
          break;
        case 4:
          days.add('Jueves');
          break;
        case 5:
          days.add('Viernes');
          break;
        case 6:
          days.add('Sabado');
          break;
        case 7:
          days.add('Domingo');
          break;
      }
      tempDate = tempDate.add(const Duration(days: 1));
    }

    return days;
  }

  void showErrorModalTimeOfDate(BuildContext context, String errorMessage) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 20),
            Text(errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _submit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_timeStart != null && _timeEnd != null) {
      final startTimeInMinutes = _timeStart!.hour * 60 + _timeStart!.minute;
      final endTimeInMinutes = _timeEnd!.hour * 60 + _timeEnd!.minute;

      if (startTimeInMinutes >= endTimeInMinutes) {
        showErrorModalTimeOfDate(
            context, 'La hora de inicio debe ser menor que la hora de fin.');
        return false;
      }
    }

    if (_dateStart != null && _dateEnd != null) {
      if (_dateStart!.isAfter(_dateEnd!)) {
        showErrorModalTimeOfDate(
            context, 'La fecha de inicio debe ser menor que la fecha de fin.');
        return false;
      }
    }

    String formattedDateStart =
        _dateStart != null ? DateFormat('dd/MM/yyyy').format(_dateStart!) : '';

    String formattedDateEnd =
        _dateEnd != null ? DateFormat('dd/MM/yyyy').format(_dateEnd!) : '';

    String formattedTimeStart =
        _timeStart != null ? '${_timeStart!.hour}:${_timeStart!.minute}' : '';

    String formattedTimeEnd =
        _timeEnd != null ? '${_timeEnd!.hour}:${_timeEnd!.minute}' : '';

    List<String> formattedDaysOfWeek =
        translateDaysToSpanish(_selectDaysOfWeek);

    if (DatePickerMode.range == _datePickerMode ||
        _datePickerMode == DatePickerMode.single) {
      formattedDaysOfWeek = getDaysInRange(_dateStart, _dateEnd);
    }

    formattedTimeStart = formattedTimeStart.padLeft(5, '0');
    formattedTimeEnd = formattedTimeEnd.padLeft(5, '0');
    String days = formattedDaysOfWeek.join(',');

    if (isValid) {
      _formKey.currentState!.save();

      String visitor = _email;
      String grantedBy = widget.user.id!;
      String homeId = widget.user.homeId!;
      String type = _entryType == EntryType.single ? 'Unica' : 'Multiple';
      String startDate = formattedDateStart;
      String endDate = formattedDateEnd;
      String startTime = formattedTimeStart;
      String endTime = formattedTimeEnd;
      String daysOfWeek = days;

      if (kDebugMode) {
        print('Visitor: $visitor');
        print('Granted by: $grantedBy');
        print('Home ID: $homeId');
        print('Type: $type');
        print('Start Date: $startDate');
        print('End Date: $endDate');
        print('Start Time: $startTime');
        print('End Time: $endTime');
        print('Days of Week: $daysOfWeek');
      }

      try {
        bool success = await _controller.createPermission(type, startDate,
            endDate, startTime, endTime, days, homeId, visitor, grantedBy);

        if (success) {
          Navigator.pop(context);
          return true; // Regresa a la pantalla anterior si la creación fue exitosa
        } else {
          showInvitationErrorModal(context);
          return false;
        }
      } catch (e) {
        showInvitationErrorModal(context);
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _adjustTimeStart();
    _adjustTimeEndRange();

    return SafeArea(
        child: ValueListenableBuilder(
            valueListenable: _controller.isLoading,
            builder: (context, bool isLoading, child) {
              return isLoading
                  ? const SplashScreen()
                  : Scaffold(
                      body: SingleChildScrollView(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 36),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Agregar una visita',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 52),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                      SizedBox(width: 24),
                                      Expanded(
                                          child: Text(
                                        'Por favor ingresa el correo electrónico, de la persona que quieres agregar como visita.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ))
                                    ],
                                  )),
                              const SizedBox(height: 52),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Correo electrónico',
                                        fillColor: Colors
                                            .grey[200], // background color
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide:
                                              BorderSide.none, // border color
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      obscureText: false,
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _email = value!;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    ListTile(
                                      title: const Text('Entrada unica'),
                                      leading: Radio<EntryType>(
                                        value: EntryType.single,
                                        groupValue: _entryType,
                                        onChanged: (EntryType? value) {
                                          setState(() {
                                            _entryType = value!;
                                            _dateEnd = null;
                                            _dateStart = null;
                                            _timeEndRange = null;
                                            _timeStartRange = null;
                                            _datePickerMode =
                                                DatePickerMode.single;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Entrada multiple'),
                                      leading: Radio<EntryType>(
                                        value: EntryType.multiple,
                                        groupValue: _entryType,
                                        onChanged: (EntryType? value) {
                                          setState(() {
                                            _entryType = value!;
                                            _dateEnd = null;
                                            _dateStart = null;
                                            _timeEndRange = null;
                                            _timeStartRange = null;
                                          });
                                        },
                                      ),
                                    ),
                                    _entryType == EntryType.multiple
                                        ? const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    instruction:
                                                        'Entrada única',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ],
                                            ),
                                          )
                                        : Card(
                                            elevation: 0.0,
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(30),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomText(
                                                          instruction:
                                                              'Entrada única',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 24),
                                                    const CustomText(
                                                        instruction:
                                                            'Selecciona el dia de ingreso.',
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                    const SizedBox(height: 24),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        _selectDate(context);
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(
                                                          const Color(
                                                              0xFF001E2C),
                                                        ),
                                                        padding:
                                                            WidgetStateProperty
                                                                .all(
                                                          const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 24,
                                                          ),
                                                        ),
                                                        shape:
                                                            WidgetStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                      child: const CustomText(
                                                          instruction:
                                                              'Selecciona una fecha',
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    _dateStart != null
                                                        ? DateText(
                                                            date: _dateStart!,
                                                            label:
                                                                'Fecha de inicio')
                                                        : const SizedBox(),
                                                    const SizedBox(height: 24),
                                                    const CustomText(
                                                        instruction:
                                                            'Selecciona una hora específica.',
                                                        color: Colors.grey,
                                                        fontSize: 14),
                                                    const SizedBox(height: 24),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            _timeStart == null
                                                                ? 'Hora de ingreso'
                                                                : _timeStart!
                                                                    .format(
                                                                        context),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Transform.rotate(
                                                              angle: 90 *
                                                                  3.14159 /
                                                                  180,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  _selectTimeStart(
                                                                      context);
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 24,
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 24),
                                                    const CustomText(
                                                        instruction:
                                                            'Rango de horas.',
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                    const SizedBox(height: 24),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Expanded(
                                                          child: Divider(
                                                            color: Colors.grey,
                                                            height: 50,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 24),
                                                        Container(
                                                          width: 12,
                                                          height: 12,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border
                                                                .fromBorderSide(
                                                              BorderSide(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 24),
                                                        const Expanded(
                                                          child: Divider(
                                                            color: Colors.grey,
                                                            height: 50,
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16,
                                                                  right: 16),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                _timeStartRange ==
                                                                        null
                                                                    ? 'Hora de inicio'
                                                                    : _timeStartRange!
                                                                        .format(
                                                                            context),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Transform.rotate(
                                                                  angle: 90 *
                                                                      3.14159 /
                                                                      180,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      /*
                                                                      _selectTimeRangeStart(
                                                                          context);

                                                                       */
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 24,
                                                                    ),
                                                                  )),
                                                              const SizedBox(
                                                                  width: 24),
                                                              Text(
                                                                _timeEndRange ==
                                                                        null
                                                                    ? 'Hora de fin'
                                                                    : _timeEndRange!
                                                                        .format(
                                                                            context),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Transform.rotate(
                                                                  angle: 90 *
                                                                      3.14159 /
                                                                      180,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      /*
                                                                      _selectTimeRangeEnd(
                                                                          context);

                                                                       */
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 24,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ]),
                                            ),
                                          ),
                                    _entryType == EntryType.single
                                        ? const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    instruction:
                                                        'Entrada multiple',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ],
                                            ),
                                          )
                                        : Card(
                                            elevation: 0.0,
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(30),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomText(
                                                            instruction:
                                                                'Entrada multiple',
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 24),
                                                    const CustomText(
                                                        instruction:
                                                            'Selecciona un rango de horas.',
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                    const SizedBox(height: 24),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16,
                                                                  right: 16),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                _timeStart ==
                                                                        null
                                                                    ? 'Hora de inicio'
                                                                    : _timeStart!
                                                                        .format(
                                                                            context),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Transform.rotate(
                                                                  angle: 90 *
                                                                      3.14159 /
                                                                      180,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      _selectTimeStart(
                                                                          context);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 24,
                                                                    ),
                                                                  )),
                                                              const SizedBox(
                                                                  width: 24),
                                                              Text(
                                                                _timeEnd == null
                                                                    ? 'Hora de fin'
                                                                    : _timeEnd!
                                                                        .format(
                                                                            context),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Transform.rotate(
                                                                  angle: 90 *
                                                                      3.14159 /
                                                                      180,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      _selectTimeEnd(
                                                                          context);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 24,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 24),
                                                    const CustomText(
                                                        instruction:
                                                            'Selecciona el dia o rango de dias.',
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                    const SizedBox(height: 24),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        DropdownButton<
                                                            DatePickerMode>(
                                                          value:
                                                              _datePickerMode,
                                                          onChanged:
                                                              (DatePickerMode?
                                                                  newValue) {
                                                            setState(() {
                                                              _datePickerMode =
                                                                  newValue!;
                                                            });
                                                          },
                                                          items: const <DropdownMenuItem<
                                                              DatePickerMode>>[
                                                            DropdownMenuItem<
                                                                DatePickerMode>(
                                                              value:
                                                                  DatePickerMode
                                                                      .single,
                                                              child: Text(
                                                                'Single',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem<
                                                                DatePickerMode>(
                                                              value:
                                                                  DatePickerMode
                                                                      .range,
                                                              child: Text(
                                                                'Range',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem<
                                                                DatePickerMode>(
                                                              value:
                                                                  DatePickerMode
                                                                      .multiple,
                                                              child: Text(
                                                                'Multiple',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              _selectDate(
                                                                  context);
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                const Color(
                                                                    0xFF001E2C),
                                                              ),
                                                              padding:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      12,
                                                                ),
                                                              ),
                                                              shape:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                const CustomText(
                                                              instruction:
                                                                  'Selecciona una fecha',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ],
                                                    ),
                                                    _dateStart != null
                                                        ? DateText(
                                                            date: _dateStart!,
                                                            label:
                                                                'Fecha de inicio')
                                                        : const SizedBox(),
                                                    _dateEnd != null
                                                        ? DateText(
                                                            date: _dateEnd!,
                                                            label:
                                                                'Fecha de fin')
                                                        : const SizedBox(),
                                                    _selectDaysOfWeek!
                                                            .isNotEmpty
                                                        ? SelectedDaysText(
                                                            selectedDays:
                                                                _selectDaysOfWeek)
                                                        : const SizedBox(),
                                                  ]),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      bottomNavigationBar: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: !_controller.isLoading.value
                                ? () async {
                                    bool success = await _submit();
                                    if (success) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Mensaje'),
                                            content:
                                                const Text('Permiso creado.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      Navigator.pop(context);
                                    }
                                  }
                                : null,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                !_controller.isLoading.value
                                    ? const Color(0xFF001E2C)
                                    : const Color(0xFF4E4E4E),
                              ),
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 28,
                                ),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: _controller.isLoading,
                              builder: (context, isLoading, child) {
                                if (isLoading) {
                                  return const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  );
                                } else {
                                  return const Text(
                                    'Listo',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
            }));
  }
}
