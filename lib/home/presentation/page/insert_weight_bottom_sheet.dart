import 'package:fit_tracker/core/core.dart';
import 'package:fit_tracker/home/presentation/bloc/insert_weight/insert_weight_bloc.dart';
import 'package:fit_tracker/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InsertWeightBottomSheet extends StatelessWidget {
  const InsertWeightBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => di.injector<InsertWeightBloc>(),
      builder: (context, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(spacingRegular),
                  child: Text(
                    "Input weight records",
                    style: textSemiBoldBlack_20pt,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(spacingRegular),
                    child: _InputDate()),
                Padding(
                    padding: EdgeInsets.all(spacingRegular),
                    child: _InputWeight()),
                SizedBox(height: spacingHuge),
                Padding(
                  padding: EdgeInsets.all(spacingRegular),
                  child: _UpdateProfileButton(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _InputDate extends StatefulWidget {
  const _InputDate({Key? key}) : super(key: key);

  @override
  State<_InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<_InputDate> {
  final _dateController = TextEditingController();
  DateTime _activeDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DateTextField(
      controller: _dateController,
      labelHint: 'Date taken',
      ontap: () async {
        await showDatePicker(
                context: context,
                initialDate: _activeDateTime,
                firstDate: DateTime(1950),
                lastDate: DateTime.now())
            .then((value) {
          if (value != null) {
            final stringDate = DateFormat('yyyy-MM-dd').format(value);
            _activeDateTime = value;
            _dateController.text = stringDate;
            context.read<InsertWeightBloc>().add(InsertWeightDate(stringDate));
          }
        });
      },
    );
  }
}

class _InputWeight extends StatelessWidget {
  const _InputWeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryTextField(
              label: 'Weight',
              inputType: const [TextFieldType.digitsOnly],
              onChanged: (value) {
                context.read<InsertWeightBloc>().add(
                    InsertWeight((value.isNotEmpty) ? int.parse(value) : 0));
              }),
        ),
        const SizedBox(width: spacingSmall),
        const Expanded(child: Text("kg"))
      ],
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  const _UpdateProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InsertWeightBloc, InsertWeightState>(
      listenWhen: (previous, current) =>
          current is InsertWeightSucceedState ||
          current is InsertWeightErrorState,
      listener: (context, state) {
        if (state is InsertWeightSucceedState) {
          showSnackBar(context, 'Insert Data Success!');
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) =>
          current is InsertWeightLoadingState ||
          current is InsertWeightErrorState,
      builder: (context, state) {
        final isLoading = state is InsertWeightLoadingState;
        return Column(
          children: [
            PrimaryButton(
              text: 'ADD WEIGHT RECORD',
              isLoading: isLoading,
              onPressed: () {
                context.read<InsertWeightBloc>().add(InsertNewWeightEvent());
              },
            ),
            const SizedBox(height: spacingSmall),
            (state is InsertWeightErrorState)
                ? Text(state.message, style: textRegularRed_12pt)
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
