/*
class CustomColumn extends ConsumerStatefulWidget {
  final String title;
  final bool isRedeem;
  final Function onPressed;
  final User userInformation;
  final List<User> usersInformation;

  const CustomColumn({
    super.key,
    required this.title,
    required this.isRedeem,
    required this.onPressed,
    required this.userInformation,
    required this.usersInformation,
  });

  @override
  _CustomColumnState createState() => _CustomColumnState();
}

class _CustomColumnState extends ConsumerState<CustomColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => widget.onPressed(),
              child: const Text('Ver mas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Consumer(
          builder: (context, watch, child) {
            final name = ref.watch(nameProvider.notifier).state;
            final filteredUsers = name.isEmpty
                ? widget.usersInformation
                : widget.usersInformation
                    .where((item) => item.name == name)
                    .toList();
            return ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                var user = filteredUsers[index];
                var usersWithPermission = user.permissions
                    .where((p) => p.status == widget.isRedeem)
                    .map((p) => user)
                    .toList();
                return usersWithPermission.isEmpty
                    ? const SizedBox.shrink()
                    : VisitorsScreen(
                        userInformation: widget.userInformation,
                        usersInformation: usersWithPermission,
                        isRedeem: widget.isRedeem,
                        onUserRemove: (removedUser) {
                          ref
                              .read(userInformationProvider.notifier)
                              .removeUser(removedUser);
                        },
                      );
              },
            );
          },
        ),
      ],
    );
  }
}
*/
