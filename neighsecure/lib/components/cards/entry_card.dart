import 'package:flutter/material.dart';
import 'package:neighsecure/components/text/custom_text.dart';

import '../text/date_text.dart';

class EntryCard extends StatelessWidget {
  final VoidCallback onPressed;
  final DateTime? dateStart;
  final TimeOfDay? timeStart;
  final TimeOfDay? timeStartRange;

  const EntryCard({
    super.key,
    required this.onPressed,
    required this.dateStart,
    required this.timeStart,
    required this.timeStartRange,
  });

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                      instruction: 'Entrada única',
                      fontSize: 16,
                      color: Colors.grey),
                ],
              ),
              const SizedBox(height: 24),
              const CustomText(
                  instruction: 'Selecciona el dia de ingreso.',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF001E2C),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const CustomText(
                    instruction: 'Selecciona una fecha',
                    fontSize: 14,
                    color: Colors.grey),
              ),
              dateStart != null
                  ? DateText(date: dateStart!, label: 'Fecha de inicio')
                  : const SizedBox(),
              const SizedBox(height: 24),
              const CustomText(
                  instruction: 'Selecciona una hora específica.',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      timeStart == null
                          ? 'Hora de ingreso'
                          : timeStart!.format(context),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    Transform.rotate(
                        angle: 90 * 3.14159 / 180,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const CustomText(
                instruction: 'Selecciona un rango de horas.',
                fontSize: 14,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 50,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          timeStartRange == null
                              ? 'Hora de inicio'
                              : timeStartRange!.format(context),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Transform.rotate(
                            angle: 90 * 3.14159 / 180,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 24,
                              ),
                            )),
                        const SizedBox(width: 24),
                        const CustomText(
                            instruction: 'Hora de fin',
                            fontSize: 14,
                            color: Colors.grey),
                        Transform.rotate(
                            angle: 90 * 3.14159 / 180,
                            child: IconButton(
                              onPressed: () {},
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
              )
            ]),
      ),
    );
  }
}
