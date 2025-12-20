import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  bool isChecked = false;
  String selectedCountry = 'United States';

  final List<String> countries = [
    'United States',
    'Canada',
    'Mexico',
    'India',
    'Germany',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: "Add Payment",
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add card',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Card information', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildTextField(
                      'Card information',
                      'Card number',
                      TextInputType.number,
                    ),
                    Divider(height: 0, color: Colors.black),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            'MM/YY',
                            'MM/YY',
                            TextInputType.number,
                          ),
                        ),
                        Container(height: 50, width: 1, color: Colors.black),
                        Expanded(
                          child: _buildTextField(
                            'CVC',
                            'CVC',
                            TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Billing address', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Country Dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildDropdown(
                        'Country or region',
                        selectedCountry,
                        (String? newValue) {
                          setState(() {
                            selectedCountry = newValue!;
                          });
                        },
                      ),
                    ),
                    Divider(height: 0, color: Colors.black),
                    // ZIP Code Field
                    _buildTextField('ZIP', 'ZIP Code', TextInputType.number),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    'Save this card for future payment',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CommonButton("Done"),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextInputType inputType) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String selectedValue,
    void Function(String?) onChanged,
  ) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      isExpanded: true,

      items: countries.map<DropdownMenuItem<String>>((String country) {
        return DropdownMenuItem<String>(value: country, child: Text(country));
      }).toList(),
    );
  }
}
