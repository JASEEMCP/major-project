import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class HostEventView extends StatelessWidget {
  const HostEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                txt: 'My Events',
                fontSize: 20,
              ),
              CustomCircleBtn(
                iconColor: Colors.green,
                icon: Icons.add,
                onTap: () {
                  context.go(ScreenPath.createEvent());
                },
              )
            ],
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
                      padding: EdgeInsets.all(inset.sm),
                      decoration: applyBorderRadius(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txt: 'Event Name',
                                color: context.theme.indigo,
                              ),
                              rowTitleText('Category', "content")
                            ],
                          ),
                          rowTitleText('Date', "2022-11-24"),
                          rowTitleText('Fee', "\$300"),
                          rowTitleText('Credit', "50"),
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
