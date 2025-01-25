import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class AddStaffView extends StatelessWidget {
  const AddStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                txt: 'Add Staff',
                fontSize: 20,
              ),
              CustomCircleBtn(
                icon: Icons.add,
                onTap: () {},
              ),
            ],
          ),
          Gap(inset.md),
          ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Gap(inset.xs),
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.all(inset.sm),
                decoration: applyBorderRadius(context),
                child: Column(
                  spacing: inset.xs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txt: 'Name of Staff',
                      color: context.theme.indigo,
                    ),
                    rowTitleText('Email', 'abc@gmail.com'),
                    rowTitleText('Department', 'abc@gmail.com'),
                    rowTitleText('Gender', 'abc@gmail.com'),
                    rowTitleText('Academic Year', '2021-2025')
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
