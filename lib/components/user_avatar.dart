import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messagerie/cubits/profiles/profiles_cubit.dart';
import 'package:flutter_messagerie/utils/constants.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesCubit, ProfilesState>(
      builder: (context, state) {
        if (state is ProfilesLoaded) {
          final user = state.profiles[userId];
          return CircleAvatar(
            backgroundColor: Colors.blue,
            child: user == null
                ? preloader
                : Text(
                    user.username.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
          );
        } else {
          return const CircleAvatar(child: preloader);
        }
      },
    );
  }
}
