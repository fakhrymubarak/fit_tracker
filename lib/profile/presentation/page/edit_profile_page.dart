import 'package:fit_tracker/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../domain/entities/user_profile.dart';
import '../bloc/edit_profile/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with RouteAware {
  final _dateController = TextEditingController();

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Provider(
          create: (_) => di.injector<EditProfileBloc>(),
          builder: (context, child) => CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CustomAppBar(title: "Edit Profile"),
                  const SizedBox(height: spacingRegular),
                  Padding(
                    padding: const EdgeInsets.all(spacingRegular),
                    child: PrimaryTextField(
                        label: 'Name',
                        inputType: const [TextFieldType.text],
                        onChanged: (value) {
                          context
                              .read<EditProfileBloc>()
                              .add(EditProfileName(value));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacingRegular),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryTextField(
                              label: 'Height',
                              inputType: const [TextFieldType.digitsOnly],
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                    EditProfileHeight((value.isNotEmpty)
                                        ? int.parse(value)
                                        : 0));
                              }),
                        ),
                        const SizedBox(width: spacingSmall),
                        const Expanded(child: Text("cm"))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(spacingRegular),
                    child: GenderRadio(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacingRegular),
                    child: DateTextField(
                      controller: _dateController,
                      labelHint: 'Date of Birth',
                      ontap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2006))
                            .then((value) {
                          if (value != null) {
                            context.read<EditProfileBloc>().add(
                                EditProfileBirthDate(
                                    DateFormat('dd/MM/yyyy').format(value)));
                            _dateController.text =
                                DateFormat('dd/MM/yyyy').format(value);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: spacingRegular),
                  Expanded(child: Container()),
                  const SizedBox(height: spacingLarger),
                  const Padding(
                    padding: EdgeInsets.all(spacingRegular),
                    child: UpdateProfileButton(),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class GenderRadio extends StatefulWidget {
  const GenderRadio({Key? key}) : super(key: key);

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  Gender? gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Gender"),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Male'),
                contentPadding: EdgeInsets.zero,
                leading: Radio<Gender>(
                  value: Gender.male,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                    context
                        .read<EditProfileBloc>()
                        .add(EditProfileGender(value));
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Female'),
                leading: Radio<Gender>(
                  value: Gender.female,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                    context
                        .read<EditProfileBloc>()
                        .add(EditProfileGender(value));
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class UpdateProfileButton extends StatelessWidget {
  const UpdateProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) =>
          current is EditProfileSucceedState ||
          current is EditProfileErrorState,
      listener: (context, state) {
        if (state is EditProfileSucceedState) {
          showSnackBar(context, 'Update profile success!');
          Navigator.pop(context);
        } else if (state is EditProfileErrorState) {
          showSnackBar(context, state.message);
        }
      },
      buildWhen: (previous, current) => current is EditProfileLoadingState,
      builder: (context, state) {
        final isLoading = state is EditProfileLoadingState;
        return PrimaryButton(
          text: 'UPDATE PROFILE',
          isLoading: isLoading,
          onPressed: () {
            context.read<EditProfileBloc>().add(UpdateProfileEvent());
          },
        );
      },
    );
  }
}
