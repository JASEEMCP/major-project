import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class EventVerifyView extends StatelessWidget {
  const EventVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            txt: 'Verify Event',
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
                      padding: EdgeInsets.all(inset.sm),
                      decoration: applyBorderRadius(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                txt: "Organizer Detail",
                                fontSize: 20,
                                color: context.theme.indigo,
                              ),
                              CustomButton(
                                width: 80,
                                name: 'Verify',
                                color: Colors.green,
                                radius: 30,
                                onTap: () {},
                              )
                            ],
                          ),
                          const CustomText(
                            txt: 'Organization Name',
                            color: Colors.green,
                          ),
                          Gap(inset.xs),
                          rowTitleText('Email', "content"),
                          rowTitleText('Authorizer Name', "content"),
                          rowTitleText('Strength', "content"),
                          rowTitleText('Website', "content"),
                          Gap(inset.xs),
                          CustomText(
                            txt: "Event Detail",
                            fontSize: 20,
                            color: context.theme.indigo,
                          ),
                          Gap(inset.xs),
                          rowTitleText('Organizer', "iEDC"),
                          rowTitleText('Post date', "content"),
                          rowTitleText('Expire Date', "content"),
                          rowTitleText('Slot Available', "content"),
                          rowTitleText('Fee', "content"),
                          rowTitleText('Credit Score', "content"),
                          rowTitleText('Category', "WorkShop"),
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
