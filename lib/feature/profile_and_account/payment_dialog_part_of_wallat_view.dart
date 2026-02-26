part of 'wallet_view.dart';

void showPayCommissionDialog(
  WalletAndPaymentController controller,
  BuildContext context,
) {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),

            title: Row(
              children: const [
                Icon(
                  Icons.payments_outlined,
                  color: AppColors.primary,
                  size: 30,
                ),
                SizedBox(width: 8),
                CommonText("Pay Commission", isBold: true, size: 16),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Amount Field
                    TextFormField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: "Amount",
                        prefixText: "\$ ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter amount";
                        }
                        final parsed = double.tryParse(value);
                        if (parsed == null || parsed <= 0) {
                          return "Enter a valid amount";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    /// Description Field
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Buttons
            actions: [
              TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                child: CommonText("Cancel"),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;

                          setState(() => isLoading = true);

                          final amount = double.parse(
                            amountController.text.trim(),
                          );

                          await controller.payCommission(
                            amount: amount,
                            description: descriptionController.text.trim(),
                            midCallFunction: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : CommonText("Pay", color: AppColors.white),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
