import 'package:fit_tracker/injection.dart' as di;
import 'package:fit_tracker/profile/presentation/bloc/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../bloc/profile/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with RouteAware {
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
              child: MultiProvider(
                  providers: [
                    BlocProvider(create: (_) => di.injector<ProfileBloc>()),
                    BlocProvider(create: (_) => di.injector<LogoutCubit>()),
                  ],
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        CustomAppBar(title: 'Profile'),
                        SizedBox(height: spacingLarger),
                        SizedBox(
                            width: double.infinity,
                            child: ProfileSectionWidget()),
                      ],
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileFetchEvent());
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) => current is ProfileErrorState,
      listener: (context, state) {
        if (state is ProfileErrorState) {
          showSnackBar(context, state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is ProfileLoadingState || current is ProfileHasDataState,
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileHasDataState) {
          final isProfileComplete = state.profile.isProfileComplete;
          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const CircleAvatar(
                      foregroundColor: colorPrimary, radius: 50.0),
                  Chip(
                      label: Text(
                        isProfileComplete
                            ? "Profile Completed"
                            : "Profile Not Complete",
                        style: textRegularWhite_10pt,
                      ),
                      backgroundColor:
                          isProfileComplete ? colorPrimary : colorRedError),
                ],
              ),
              const SizedBox(height: spacingRegular),
              Text(state.profile.email),
              const SizedBox(height: spacingSmall),
              (isProfileComplete)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: spacingRegular),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: spacingRegular),
                          Row(
                            children: [
                              const SizedBox(width: 100, child: Text("Name")),
                              Text(
                                state.profile.name ?? "User",
                                style: textMediumBlack_12pt,
                              ),
                            ],
                          ),
                          const SizedBox(height: spacingSmall),
                          Row(
                            children: [
                              const SizedBox(width: 100, child: Text("Height")),
                              Text(
                                '${state.profile.height ?? 0} cm',
                                style: textMediumBlack_12pt,
                              ),
                            ],
                          ),
                          const SizedBox(height: spacingSmall),
                          Row(
                            children: [
                              const SizedBox(width: 100, child: Text("Gender")),
                              Text(
                                state.profile.gender?.name ?? "-",
                                style: textMediumBlack_12pt,
                              ),
                            ],
                          ),
                          const SizedBox(height: spacingSmall),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 100, child: Text("Birth Date")),
                              Text(
                                state.profile.birthDate ?? "01-01-1970",
                                style: textMediumBlack_12pt,
                              ),
                            ],
                          ),
                          const SizedBox(height: spacingRegular),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: spacingRegular),
              const Divider(),
              const EditProfileButton(),
              const Divider(),
              const LogoutButtonWidget(),
              const Divider(),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, editProfilePageRoute);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: spacingRegular, vertical: spacingRegular),
        child: Row(
          children: const [
            Expanded(child: Text('Edit Profile')),
            Icon(Icons.arrow_forward_ios_rounded, size: 20)
          ],
        ),
      ),
    );
  }
}

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, loginPageRoute, (r) => false);
        }
      },
      child: InkWell(
        onTap: () {
          context.read<LogoutCubit>().logoutUser();
        },
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: spacingRegular, vertical: spacingRegular),
            child: Row(
              children: const [
                Expanded(child: Text('Logout')),
                Icon(Icons.logout, size: 20)
              ],
            )),
      ),
    );
  }
}
