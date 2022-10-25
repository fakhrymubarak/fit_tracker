import 'package:fit_tracker/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../bloc/profile/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with RouteAware {
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
          create: (_) => di.injector<ProfileBloc>(),
          builder: (context, child) => CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CustomAppBar(),
                  const SizedBox(height: spacingLarger),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child:
                        Text('Sign Up Account', style: textSemiBoldBlack_20pt),
                  ),
                  const SizedBox(height: spacingLarger),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child: Text(
                        'Register your account to track your daily weight.'),
                  ),
                  const SizedBox(height: spacingLarger),
                  // Padding(
                  //   padding:
                  //   const EdgeInsets.symmetric(horizontal: spacingRegular),
                  //   child: _widgetEmailTextField(),
                  // ),
                  const SizedBox(height: spacingRegular),
                  const SizedBox(height: spacingRegular),
                  Expanded(child: Container()),

                  const SizedBox(height: spacingLarger),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

// Widget _widgetConfPassTextField() => BlocBuilder<RegisterBloc, RegisterState>(
//   buildWhen: (_, current) =>
//   current is ConfirmPassValidState ||
//       current is ConfirmPassNotValidState,
//   builder: (context, state) {
//     return PrimaryTextField(
//       label: 'Confirm Password',
//       inputType: const [TextFieldType.text, TextFieldType.password],
//       errorMessage:
//       (state is ConfirmPassNotValidState) ? state.errorMessage : null,
//       onChanged: (value) {
//         context.read<RegisterBloc>().add(ConfirmPassValidateEvent(value));
//       },
//     );
//   },
// );
}
