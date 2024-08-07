import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neighsecure/controllers/permission_controller.dart';
import 'package:neighsecure/providers/dummyProviders/testnameprovider.dart';

import '../../../../../../../../models/entities/permissions.dart';
import '../../../../../../../../models/entities/user.dart';
import '../visitors_screen.dart';

class VisitorsStateScreen extends ConsumerStatefulWidget {
  VisitorsStateScreen(
      {super.key,
      this.isRedeem,
      required this.permissionsInformation,
      required this.userInformation});

  bool? isRedeem;

  final User userInformation;

  final List<Permissions> permissionsInformation;

  @override
  ConsumerState<VisitorsStateScreen> createState() =>
      _VisitorsStateScreenState();
}

class _VisitorsStateScreenState extends ConsumerState<VisitorsStateScreen> {
  final PermissionController _controller = PermissionController();

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(nameProvider.notifier).state;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //set name to empty
                        ref.read(nameProvider.notifier).updateName('');
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
                      'Administrar visitas',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Consumer(
                  builder: (context, watch, child) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        fillColor: Colors.grey[200], // background color
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none, // border color
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      obscureText: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref.read(nameProvider.notifier).updateName(value);
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Consumer(
                  builder: (context, watch, child) {
                    final name = ref.watch(nameProvider.notifier).state;
                    return VisitorsScreen(
                      userInformation: widget.userInformation,
                      permissionsInformation: name.isEmpty
                          ? widget.permissionsInformation
                          : widget.permissionsInformation
                              .where((item) => item.userAssociated.name == name)
                              .toList(),
                      isRedeem: widget.isRedeem,
                      displayeElements: widget.permissionsInformation.length,
                      onUserRemove: (removedPermission) {
                        _controller.deletePermission(removedPermission.id);
                        /*
                        ref
                            .read(permissionInformationProvider.notifier)
                            .removePermission(removedPermission);

                         */
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
