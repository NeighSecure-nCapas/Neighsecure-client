import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationNotifier extends StateNotifier<List<Map<String, String>>> {
  UserInformationNotifier()
      : super([
          {
            'name': 'Victor Rene',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Victor Jose',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Alejandro Jose',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Melvin Jose',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Pamela Monica',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Claudia Rosales',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Diego Gomez'
          },
          {
            'name': 'Steve Rene',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Diego Gomez'
          },
          {
            'name': 'Billy Caliente',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'false',
            'entryhours': [
              '2024-04-25 10:00 am',
              '2024-04-25 11:00 am',
              '2024-04-25 12:00 pm',
              '2024-04-25 13:00 pm',
              '2024-04-25 14:00 pm',
              '2024-04-25 15:00 pm',
              '2024-04-25 16:00 pm',
              '2024-04-25 17:00 pm',
              '2024-04-25 18:00 pm',
            ].join(','),
            'redeem': 'true',
            'inviteBy': 'Diego Viana'
          },
          {
            'name': 'Melvin Diaz',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'false',
            'entryhours': [
              '2024-04-25 10:00 am',
              '2024-04-25 11:00 am',
              '2024-04-25 12:00 pm',
              '2024-04-25 13:00 pm',
              '2024-04-25 14:00 pm',
              '2024-04-25 15:00 pm',
            ].join(','),
            'redeem': 'true',
            'inviteBy': 'Diego Viana'
          },
          {
            'name': 'Alejandro Diaz',
            'role': 'visitante',
            'email': 'caliente@gmail.com',
            'tipoOfTicket': 'false',
            'entryhours': [
              '2024-04-25 10:00 am',
              '2024-04-25 11:00 am',
              '2024-04-25 12:00 pm',
              '2024-04-25 13:00 pm',
              '2024-04-25 14:00 pm',
              '2024-04-25 15:00 pm',
            ].join(','),
            'redeem': 'true',
            'inviteBy': 'Diego Viana'
          },
        ]);

  void removeUser(Map<String, String> user) {
    state = state.where((element) => element != user).toList();
  }
}

final userInformationProvider =
    StateNotifierProvider<UserInformationNotifier, List<Map<String, String>>>(
        (ref) {
  return UserInformationNotifier();
});
