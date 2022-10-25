import 'package:fit_tracker/home/presentation/bloc/get_weight/list_weight_cubit.dart';
import 'package:fit_tracker/home/presentation/widgets/item_weight_widget.dart';
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
        child: MultiProvider(
          providers: [
            BlocProvider(create: (_) => di.injector<ProfileBloc>()),
            BlocProvider(create: (_) => di.injector<ListWeightCubit>()),
          ],
          builder: (_, __) {
            return Column(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: spacingRegular, vertical: spacingRegular),
                  child: HeaderProfileWidget(),
                ),
                Expanded(child: ListWeight())
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // todo check is profile completed?
          buildBottomSheet(
              context: context,
              bottomSheetWidget: const BottomSheetInsertWeight());
        },
        backgroundColor: colorSecondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({Key? key}) : super(key: key);

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

class ListWeight extends StatelessWidget {
  const ListWeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ListWeightCubit>().fetchUserWeights();

    return BlocConsumer<ListWeightCubit, ListWeightState>(
      listenWhen: (previous, current) => current is ListWeightErrorState,
      listener: (context, state) {
        if (state is ListWeightErrorState) {
          showSnackBar(context, state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is ListWeightLoadingState ||
          current is ListWeightHasDataState,
      builder: (context, state) {
        if (state is ListWeightLoadingState) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is ListWeightHasDataState) {
          final weights = state.weights;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
                vertical: spacingSmall, horizontal: spacingRegular),
            itemCount: weights.length,
            itemBuilder: (context, index) {
              final weight = weights[index];
              return ItemWeightWidget(item: weight);
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
