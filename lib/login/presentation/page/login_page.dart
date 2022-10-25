import 'package:fit_tracker/injection.dart' as di;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with RouteAware {
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
          create: (_) => di.injector<LoginBloc>(),
          builder: (context, child) {
            context.read<LoginBloc>().add(HasLoginCheckedEvent());
            return CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child:
                        Text('Sign In Account', style: textSemiBoldBlack_20pt),
                  ),
                  const SizedBox(height: spacingLarger),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child: Text('Login to access your daily weight data.'),
                  ),
                  const SizedBox(height: spacingHuger),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                    child: EmailTextFieldWidget(),
                  ),
                  const SizedBox(height: spacingRegular),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacingRegular),
                      child: PasswordTextFieldWidget()),
                  Expanded(child: Container()),
                  const Padding(
                    padding: EdgeInsets.all(spacingRegular),
                    child: SignInButtonWidget(),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Do not have an account? '),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, registerPageRoute);
                            },
                          text: 'Sign Up',
                          style: textRegularPrimary_12pt,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spacingHuger),
                ]),
              ),
            ]);
          },
        ),
      ),
    );
  }
}

class PasswordTextFieldWidget extends StatelessWidget {
  const PasswordTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (_, current) =>
          current is PassValidState || current is PassNotValidState,
      builder: (context, state) {
        return PrimaryTextField(
          label: 'Password',
          inputType: const [TextFieldType.text, TextFieldType.password],
          errorMessage:
              (state is PassNotValidState) ? state.errorMessage : null,
          onChanged: (value) {
            context.read<LoginBloc>().add(PassValidateEvent(value));
          },
        );
      },
    );
  }
}

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginUserSucceedState ||
          current is LoginUserErrorState ||
          current is HasLoginState,
      listener: (context, state) {
        if (state is LoginUserSucceedState) {
          Navigator.pushReplacementNamed(context, homePageRoute);
        } else if (state is LoginUserErrorState) {
          showSnackBar(context, state.message);
        } else if (state is HasLoginState) {
          if (state.hasLogin) {
            Navigator.pushReplacementNamed(context, homePageRoute);
          }
        }
      },
      buildWhen: (previous, current) =>
          current is LoginUserLoadingState || current is LoginButtonState,
      builder: (context, state) {
        final isLoading = state is LoginUserLoadingState;
        final isEnabled =
            (state is LoginButtonState) ? state.isEnabled : false || isLoading;
        return PrimaryButton(
          text: 'SIGN IN',
          isLoading: isLoading,
          isEnabled: isEnabled,
          onPressed: () {
            context.read<LoginBloc>().add(LoginUserEvent());
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (_, current) =>
          current is EmailValidState || current is EmailNotValidState,
      builder: (context, state) {
        return PrimaryTextField(
          label: 'Email',
          inputType: const [TextFieldType.text, TextFieldType.email],
          errorMessage:
              (state is EmailNotValidState) ? state.errorMessage : null,
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailValidateEvent(value));
          },
        );
      },
    );
  }
}
