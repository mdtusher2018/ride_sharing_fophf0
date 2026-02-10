part of '../home_view.dart';

class PackageControllers {
  final TextEditingController weight = TextEditingController();
  final TextEditingController length = TextEditingController();
  final TextEditingController width = TextEditingController();
  final TextEditingController height = TextEditingController();
}

bool validateTripSearch({
  required BuildContext context,
  required (TextEditingController, LatLng?) pickup,
  required (TextEditingController, LatLng?) destination,
  required DateTime? dateTime,
  required bool isTravelSelected,
  required int count,
  required List<PackageControllers> packageControllers,
}) {
  if (pickup.$1.text.trim().isEmpty || pickup.$2 == null) {
    context.showErrorSnackbar(
      title: "Validation Error",
      message: "Pick up Location is required",
    );
    return false;
  }

  if (destination.$1.text.trim().isEmpty || destination.$2 == null) {
    context.showErrorSnackbar(
      title: "Validation Error",
      message: "Destination Location is required",
    );
    return false;
  }

  if (dateTime == null) {
    context.showErrorSnackbar(
      title: "Validation Error",
      message: "Travle Date is required",
    );
    return false;
  }

  if (isTravelSelected) {
    if (count <= 0) {
      context.showErrorSnackbar(
        title: "Validation Error",
        message: "Passengers count is required",
      );
      return false;
    }
  } else {
    if (count <= 0) {
      context.showErrorSnackbar(
        title: "Validation Error",
        message: "At least one package is required",
      );
      return false;
    }

    for (int i = 0; i < packageControllers.length; i++) {
      final c = packageControllers[i];

      if (c.weight.text.isEmpty ||
          c.length.text.isEmpty ||
          c.width.text.isEmpty ||
          c.height.text.isEmpty) {
        context.showErrorSnackbar(
          title: "Validation Error",
          message: "Package ${i + 1}: all fields are required",
        );
        return false;
      }

      if (double.tryParse(c.weight.text) == null ||
          double.tryParse(c.length.text) == null ||
          double.tryParse(c.width.text) == null ||
          double.tryParse(c.height.text) == null) {
        context.showErrorSnackbar(
          title: "Validation Error",
          message: "Package ${i + 1}: invalid number",
        );
        return false;
      }
    }
  }

  return true;
}
