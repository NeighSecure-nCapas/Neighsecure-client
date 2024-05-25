import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationNotifier extends StateNotifier<List<Map<String, String>>> {
  UserInformationNotifier()
      : super([
          {
            'name': 'Victor Rene',
            'role': 'visitante',
            'email': 'caliente1@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Victor Jose',
            'role': 'visitante',
            'email': 'caliente2@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Alejandro Jose',
            'role': 'visitante',
            'email': 'caliente3@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Melvin Jose',
            'role': 'visitante',
            'email': 'caliente4@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Pamela Monica',
            'role': 'visitante',
            'email': 'caliente5@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Pamela Gomez'
          },
          {
            'name': 'Claudia Rosales',
            'role': 'visitante',
            'email': 'caliente6@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Diego Gomez'
          },
          {
            'name': 'Steve Rene',
            'role': 'visitante',
            'email': 'caliente7@gmail.com',
            'tipoOfTicket': 'true',
            'redeem': 'false',
            'inviteBy': 'Diego Gomez'
          },
          {
            'name': 'Billy Caliente',
            'role': 'visitante',
            'email': 'caliente8@gmail.com',
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
            'email': 'caliente9@gmail.com',
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
            'email': 'caliente10@gmail.com',
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
            'name': 'Juan Perez',
            'role': 'residente',
            'email': 'juanperez@gmail.com'
          },
          {
            'name': 'Pamela Perez',
            'role': 'residente',
            'email': 'pamelaperez@gmail.com'
          },
        ]);

  void removeUser(Map<String, String> user) {
    state = state.where((element) => element != user).toList();
  }

  //Update the user redeem
  void updateUserRedeem(Map<String, String> user) {
    state = state.map((element) {
      if (element == user) {
        return {
          ...element,
          'redeem': 'true',
        };
      }
      return element;
    }).toList();
  }

  //Update the user role to residente
  void updateUserRole(Map<String, String> user) {
    state = state.map((element) {
      if (element == user) {
        return {
          ...element,
          'role': 'residente',
        };
      }
      return element;
    }).toList();
  }

  //Return the user role to visitante
  void returnUserRole(Map<String, String> user) {
    state = state.map((element) {
      if (element == user) {
        return {
          ...element,
          'role': 'visitante',
        };
      }
      return element;
    }).toList();
  }

  //Add a new user
  void addUser(Map<String, String> user) {
    state = [...state, user];
  }
}

final userInformationProvider =
    StateNotifierProvider<UserInformationNotifier, List<Map<String, String>>>(
        (ref) {
  return UserInformationNotifier();
});
