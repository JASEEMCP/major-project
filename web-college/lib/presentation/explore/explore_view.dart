import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            txt: 'Colleges',
            fontSize: 20,
          ),
          Gap(inset.sm),
          Container(
            width: double.maxFinite,
            color: context.theme.indigoLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(inset.xs),
                  itemBuilder: (ctx, index) {
                    return Container(
                      padding: EdgeInsets.all(inset.xs),
                      decoration: applyBorderRadius(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(txt: 'College Name'),
                          CustomButton(
                            width: 80,
                            name: 'View',
                            radius: 30,
                            onTap: () {
                              context.go(ScreenPath.detail('id-college'));
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

BoxDecoration applyBorderRadius(BuildContext context) {
  return BoxDecoration(
    color: context.theme.kWhite,
    borderRadius: BorderRadius.circular(10),
  );
}
