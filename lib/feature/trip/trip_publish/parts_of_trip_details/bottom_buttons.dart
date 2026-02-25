part of '../published_trip_details_view.dart';

class _BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            AppLocalizations.of(context)!.cancel_trip,
            color: Colors.transparent,
            textColor: Colors.red,
            boarder: Border.all(color: Colors.red, width: 2),
            onTap: () {},
            height: 35,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CommonButton(
            AppLocalizations.of(context)!.start_trip,
            color: Colors.green,
            onTap: () {},
            height: 35,
          ),
        ),
      ],
    );
  }
}
