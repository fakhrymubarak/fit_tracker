import 'package:fit_tracker/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RouteAware {
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
          create: (_) => di.injector<RegisterBloc>(),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child: EmailTextFieldWidget(),
                  ),
                  const SizedBox(height: spacingRegular),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                      child: PassTextFieldWidget()),
                  const SizedBox(height: spacingRegular),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child: ConfPassTextFieldWidget(),
                  ),
                  Expanded(child: Container()),
                  const Padding(
                    padding: EdgeInsets.all(spacingRegular),
                    child: SignUpButtonWidget(),
                  ),
                  const SizedBox(height: spacingLarger),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) =>
          current is RegisterUserSucceedState ||
          current is RegisterUserErrorState,
      listener: (context, state) {
        if (state is RegisterUserSucceedState) {
          showSnackBar(
              context, 'Register success! Please login to your account.');
          Navigator.pop(context);
        } else if (state is RegisterUserErrorState) {
          showSnackBar(context, state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is RegisterUserLoadingState || current is RegisterButtonState,
      builder: (context, state) {
        final isLoading = state is RegisterUserLoadingState;
        final isEnabled = (state is RegisterButtonState)
            ? state.isEnabled
            : false || isLoading;
        return PrimaryButton(
          text: 'SIGN UP',
          isLoading: isLoading,
          isEnabled: isEnabled,
          onPressed: () {
            context.read<RegisterBloc>().add(RegisterUserEvent());
          },
        );
      },
    );
  }
}

class ConfPassTextFieldWidget extends StatelessWidget {
  const ConfPassTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (_, current) =>
          current is ConfirmPassValidState ||
          current is ConfirmPassNotValidState,
      builder: (context, state) {
        return PrimaryTextField(
          label: 'Confirm Password',
          inputType: const [TextFieldType.text, TextFieldType.password],
          errorMessage:
              (state is ConfirmPassNotValidState) ? state.errorMessage : null,
          onChanged: (value) {
            context.read<RegisterBloc>().add(ConfirmPassValidateEvent(value));
          },
        );
      },
    );
  }
}

class PassTextFieldWidget extends StatelessWidget {
  const PassTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (_, current) =>
          current is PassValidState || current is PassNotValidState,
      builder: (context, state) {
        return PrimaryTextField(
          label: 'Password',
          inputType: const [TextFieldType.text, TextFieldType.password],
          errorMessage:
              (state is PassNotValidState) ? state.errorMessage : null,
          onChanged: (value) {
            context.read<RegisterBloc>().add(PassValidateEvent(value));
          },
        );
      },
    );
  }
}

class EmailTextFieldWidget extends StatelessWidget {
  const EmailTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (_, current) =>
          current is EmailValidState || current is EmailNotValidState,
      builder: (context, state) {
        return PrimaryTextField(
          label: 'Email',
          inputType: const [TextFieldType.text, TextFieldType.email],
          errorMessage:
              (state is EmailNotValidState) ? state.errorMessage : null,
          onChanged: (value) {
            context.read<RegisterBloc>().add(EmailValidateEvent(value));
          },
        );
      },
    );
  }
}
