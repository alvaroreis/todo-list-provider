import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.8))),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const SizedBox(
          //   width: 21,
          //   height: 21,
          // ),
          Text(
            '10 TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Text(
            'HOJE',
            style: context.titleStyle.copyWith(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: .4,
          )
        ],
      ),
    );
  }
}
