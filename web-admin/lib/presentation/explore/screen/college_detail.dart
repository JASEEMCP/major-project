import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class CollegeDetailView extends StatelessWidget {
  const CollegeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Container(
        padding: EdgeInsets.all(inset.sm),
        decoration: applyBorderRadius(context),
        child: Column(
          children: [
            const Row(
              children: [
                CustomText(
                  txt: 'Info',
                  fontSize: 20,
                ),
              ],
            ),
            Gap(inset.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowTitleText('Admin Name', 'Content Name'),
                Gap(inset.sm),
                const BuildEventHistory(),
                Gap(inset.sm),
                Container(
                  padding: EdgeInsets.all(inset.sm),
                  color: context.theme.indigoLight,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.add_box),
                          Gap(inset.xs),
                          const CustomText(
                            txt: 'Clubs',
                            color: Colors.green,
                          ),
                        ],
                      ),
                      Gap(inset.sm),
                      ListView.separated(
                        separatorBuilder: (context, index) => Gap(inset.xs),
                        shrinkWrap: true,
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(inset.sm),
                            decoration: applyBorderRadius(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  txt: 'IEDC',
                                  color: Colors.green,
                                ),
                                rowTitleText('Authorizer', 'Rahul'),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BuildEventHistory extends StatelessWidget {
  const BuildEventHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(inset.xs),
      shrinkWrap: true,
      itemCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.all(inset.sm),
          color: context.theme.indigoLight,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const CustomText(
                    txt: 'UI/UX Workshop',
                  ),
                  Gap(inset.xs),
                  const Spacer(),
                  rowTitleText('Date of Event', '01/11/2001'),
                ],
              ),
              Gap(inset.xs),
              rowTitleText('Fee', 'Content Name'),
              rowTitleText('Attended Count', 'Content Name'),
              rowTitleText('Category Name', 'Content Name'),
              rowTitleText('Credit Score', 'Content Name'),
              rowTitleText('Faculty Name', 'Content Name'),
              rowTitleText('Author', 'Author Name'),
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
                        rowTitleText('Student Name', 'Name'),
                        rowTitleText('Academic Year', 'Name'),
                        rowTitleText('Branch', 'CSE'),
                        rowTitleText('Credit Earned', '50'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
