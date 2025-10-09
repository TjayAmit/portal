

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class ProfileAvatar extends ConsumerWidget {
  const ProfileAvatar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/personal-information'),
      child: Row(
        children: [
          CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.85),
              backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/79985747?v=4&size=64")
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(user?.name ?? "Guest User", style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),),
            Text(user?.designation.jobPosition.name ?? "Software Engineer", style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              fontSize: 10
            ),),
          ],)
      
        ],
      ),
    );
  }
}