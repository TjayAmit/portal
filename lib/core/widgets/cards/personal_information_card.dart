import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class PersonalInformationCard extends ConsumerWidget {
  const PersonalInformationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 25,
                    child: Text(
                      user?.name.isNotEmpty == true 
                        ? user!.name[0].toUpperCase() 
                        : 'G',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.employeeId ?? '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                        Text(user?.name ?? '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),),
                        Text(user?.designation.jobPosition.name ?? '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),),  
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/personal-information'), 
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white)),
          ]),
      ),
    );
  }
}