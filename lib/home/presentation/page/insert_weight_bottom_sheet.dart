import 'package:fit_tracker/core/core.dart';
import 'package:fit_tracker/home/presentation/bloc/insert_weight/weight_bloc.dart';
import 'package:fit_tracker/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum WeightAction { insert, update }

class InsertWeightBottomSheet extends StatelessWidget {
  final WeightAction action;
  final String id;
  final String date;
  final String weight;

  const InsertWeightBottomSheet(
      {super.key,
      required this.action,
      this.id = '',
      this.date = '',
      this.weight = ''});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => di.injector<WeightBloc>(),
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
              children: [
                const Padding(
                  padding: EdgeInsets.all(spacingRegular),
                  child: Text(
                    "Input weight records",
                    style: textSemiBoldBlack_20pt,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(spacingRegular),
                    child: _InputDate(date)),
                Padding(
                    padding: const EdgeInsets.all(spacingRegular),
                    child: _InputWeight(weight)),
                const SizedBox(height: spacingHuge),
                Padding(
                  padding: const EdgeInsets.all(spacingRegular),
                  child: _InsertWeightButton(action, id),
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
  final String _date;

  const _InputDate(this._date, {Key? key}) : super(key: key);

  @override
  State<_InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<_InputDate> {
  final _dateController = TextEditingController();
  DateTime _activeDateTime = DateTime.now();

  @override
  void initState() {
    _dateController.text = widget._date;
    super.initState();
  }

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
            context.read<WeightBloc>().add(EditWeightDate(stringDate));
          }
        });
      },
    );
  }
}

class _InputWeight extends StatefulWidget {
  final String _weight;

  const _InputWeight(this._weight, {Key? key}) : super(key: key);

  @override
  State<_InputWeight> createState() => _InputWeightState();
}

class _InputWeightState extends State<_InputWeight> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget._weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryTextField(
              label: 'Weight',
              controller: _textController,
              inputType: const [TextFieldType.digitsOnly],
              onChanged: (value) {
                context
                    .read<WeightBloc>()
                    .add(EditWeight((value.isNotEmpty) ? int.parse(value) : 0));
              }),
        ),
        const SizedBox(width: spacingSmall),
        const Expanded(child: Text("kg"))
      ],
    );
  }
}

class _InsertWeightButton extends StatelessWidget {
  final WeightAction _action;
  final String _id;

  const _InsertWeightButton(this._action, this._id, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeightBloc, WeightState>(
      listenWhen: (previous, current) =>
          current is WeightSucceedState || current is WeightErrorState,
      listener: (context, state) {
        if (state is WeightSucceedState) {
          showSnackBar(context, 'Insert Data Success!');
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) =>
          current is WeightLoadingState || current is WeightErrorState,
      builder: (context, state) {
        final isLoading = state is WeightLoadingState;
        return Column(
          children: [
            PrimaryButton(
              text: (_action == WeightAction.insert)
                  ? 'ADD WEIGHT RECORD'
                  : 'UPDATE WEIGHT RECORD',
              isLoading: isLoading,
              onPressed: () {
                context.read<WeightBloc>().add(
                      (_action == WeightAction.insert)
                          ? InsertNewWeightEvent()
                          : UpdateWeightEvent(_id),
                    );
              },
            ),
            const SizedBox(height: spacingSmall),
            (state is WeightErrorState)
                ? Text(state.message, style: textRegularRed_12pt)
                : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
