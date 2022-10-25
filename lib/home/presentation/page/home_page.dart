import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../injection.dart' as di;
import '../../../profile/profile.dart';
import 'bottom_sheet_insert_weight.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
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
            builder: (context, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: spacingRegular, vertical: spacingRegular),
                    child: _widgetHeaderProfile(context),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildBottomSheet(
              context: context,
              bottomSheetWidget: const BottomSheetInsertWeight());
        },
        backgroundColor: colorSecondary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _widgetHeaderProfile(BuildContext context) {
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
          return Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, profilePageRoute);
                  },
                  child: const CircleAvatar(
                      foregroundColor: colorPrimary, radius: 30.0)),
              const SizedBox(width: spacingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hi, ${state.profile.name ?? "User"}!'),
                    const SizedBox(height: spacingTiny),
                    const Text('Welcome Back!'),
                  ],
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
