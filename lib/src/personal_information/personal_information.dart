import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/constants/personal_information.constant.dart';
import 'package:zcmc_portal/core/widgets/cards/detail_default_card.dart';
import 'package:zcmc_portal/src/authentication/model/contact_model.dart';
import 'package:zcmc_portal/src/authentication/model/designation_model.dart';
import 'package:zcmc_portal/src/authentication/model/personal_information_model.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class PersonalInformationPage extends ConsumerWidget{
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            _personalInformation(user?.personalInformation),
            const SizedBox(height: 20),
            _contact(user?.contact),
            const SizedBox(height: 20),
            _designation(user?.designation),
          ],),
        ),
      ),
    );
  }

  Widget Card({required Widget child, required String title}){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(19, 124, 6, 6),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 24),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _personalInformation(PersonalInformationModel? personalInformation) {
    return Card(
      title: 'Personal Information',
      child: 
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  DetailDefaultCard(
                    title: PersonalInformationConstant.fullName,
                    placeholder: PlaceholderValueConstant.fullName,
                    value: personalInformation?.name ?? '',
                  ),
                  const SizedBox(height: 10),
                  DetailDefaultCard(
                    title: PersonalInformationConstant.nameExtension,
                    placeholder: PlaceholderValueConstant.nameExtension,
                    value: personalInformation?.suffix ?? '-',
                  ),
                  const SizedBox(height: 10),
                  DetailDefaultCard(
                    title: PersonalInformationConstant.sex,
                    placeholder: null,
                    value: personalInformation?.sex ?? '-',
                  ),
                  const SizedBox(height: 10),
                  DetailDefaultCard(
                    title: PersonalInformationConstant.birthDate,
                    placeholder: null,
                    value: personalInformation?.birthDate.toString() ?? '-',
                  ),
                  const SizedBox(height: 10),
                  DetailDefaultCard(
                    title: PersonalInformationConstant.placeOfBirth,
                    placeholder: null,
                    value: personalInformation?.placeOfBirth ?? '-',
                  ),
                  const SizedBox(height: 10),
                  DetailDefaultCard(
                    title: PersonalInformationConstant.civilStatus,
                    placeholder: null,
                    value: personalInformation?.civilStatus ?? '-',
                  ),
                ],
              ),
            )
    );
  }

  Widget _contact(ContactModel? contact){
    return Card(title: 'Contact', child: SizedBox(child: Column(children: [
      DetailDefaultCard(title: 'Email', placeholder: null, value: contact?.email ?? '-'),
      const SizedBox(height: 10),
      DetailDefaultCard(title: 'Phone Number', placeholder: null, value: contact?.phoneNumber ?? '-'),
    ],),));
  }

  Widget _designation(DesignationModel? designation){
    return Card(title: 'Designation', child: SizedBox(child: Column(children: [
      DetailDefaultCard(title: 'Job Position', placeholder: null, value: designation?.jobPosition.name ?? '-'),
      const SizedBox(height: 10),
      DetailDefaultCard(title: 'Area Assign', placeholder: null, value: designation?.area.name ?? '-'),
    ],),));
  }
} 