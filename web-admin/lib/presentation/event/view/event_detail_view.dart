import 'package:app/presentation/event/event_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomCircleBtn(
                onTap: () {
                  context.pop();
                },
              ),
              Gap(inset.xs),
              const CustomText(
                txt: "Event Detail",
                fontSize: 20,
              ),
            ],
          ),
          Gap(inset.sm),
          Container(
            padding: EdgeInsets.all(inset.sm),
            decoration: applyBorderRadius(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txt: "Event Name",
                  fontSize: 18,
                  color: context.theme.indigo,
                ),
                Gap(inset.xs),
                rowTitleText("Organizer", "College"),
                rowTitleText("Post Date", "College"),
                rowTitleText("Expire Date", "College"),
                rowTitleText("Slot Available", "College"),
                rowTitleText("Fee", "40"),
                rowTitleText("Session Count", "College"),
                rowTitleText("Credit Score", "College"),
                rowTitleText("Category", "College"),
                rowTitleText("Description", "College"),
              ],
            ),
          ),
          Gap(inset.sm),
          const CustomText(
            txt: "Registered Students",
            fontSize: 20,
          ),
          Gap(inset.sm),
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
                          txt: 'Student Name',
                          color: context.theme.indigo,
                        ),
                        rowTitleText('Academic Year', '2001-2005')
                      ],
                    ),
                    rowTitleText('Branch', 'Name'),
                    rowTitleText('Attended', 'Yes'),
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
