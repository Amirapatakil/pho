import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';

class BudgetSelector extends StatelessWidget {
  final int? selectedBudget;
  final ValueChanged<int> onBudgetSelected;

  const BudgetSelector({
    super.key,
    required this.selectedBudget,
    required this.onBudgetSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [5, 10, 20, 30].map((budget) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 9.9.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedBudget == budget
                    ? PHOColor.blue4674FF
                    : PHOColor.white.withOpacity(0.1),
              ),
              onPressed: () => onBudgetSelected(budget),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('\$$budget',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: PHOColor.white)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
