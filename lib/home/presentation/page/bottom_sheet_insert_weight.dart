import 'package:flutter/material.dart';

class BottomSheetInsertWeight extends StatelessWidget {
  const BottomSheetInsertWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ),

      ],
    );
  }

  // Widget _widgetEmailTextField() => BlocBuilder<InsertWeightCubit, InsertWeightState>(
  //   buildWhen: (_, current) =>
  //   current is EmailValidState || current is EmailNotValidState,
  //   builder: (context, state) {
  //     return PrimaryTextField(
  //       label: 'Email',
  //       inputType: const [TextFieldType.text, TextFieldType.email],
  //       errorMessage:
  //       (state is EmailNotValidState) ? state.errorMessage : null,
  //       onChanged: (value) {
  //         context.read<LoginBloc>().add(EmailValidateEvent(value));
  //       },
  //     );
  //   },
  // );

}
