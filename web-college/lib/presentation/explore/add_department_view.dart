import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class AddDepartmentView extends StatelessWidget {
  const AddDepartmentView({super.key});

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
                txt: 'Add Department',
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
                      txt: 'Computer Science',
                      color: context.theme.indigo,
                    ),
                    rowTitleText('Strength', '455'),
                    rowTitleText('Short Name', 'CSE'),
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
