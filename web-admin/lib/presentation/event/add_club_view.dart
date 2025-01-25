import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class AddClubView extends StatelessWidget {
  const AddClubView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            txt: 'Verify Club',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: inset.xs,
                            children: [
                              CustomText(
                                txt: 'Club Name',
                                color: context.theme.indigo,
                              ),
                              rowTitleText('Authorizer', 'Name')
                            ],
                          ),
                          rowTitleText('Email', 'Name'),
                          rowTitleText('Website', 'Name'),
                          CustomButton(
                            width: 80,
                            name: 'Verify',
                            radius: 30,
                            color: Colors.green,
                            onTap: () {
                              
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
