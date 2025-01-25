import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({super.key});

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
                txt: "Create Event",
                fontSize: 20,
              ),
            ],
          ),
          Gap(inset.sm),
          Wrap(
            spacing: inset.xs,
            runSpacing: inset.xs,
            children: const [
              CustomTextField(hint: "Event Name"),
              CustomTextField(hint: "Expire Date"),
              CustomTextField(hint: "Start Date"),
              CustomTextField(hint: "Fee"),
              CustomTextField(hint: "Number of Slot"),
              CustomTextField(hint: "Category"),
              CustomTextField(hint: "Level"),
              CustomTextField(hint: "Organization Name (Optional)"),
              CustomTextField(hint: "Description"),
            ],
          ),
          Gap(inset.sm),
          const CustomText(
            txt: "Add Session",
            fontSize: 20,
          ),
          Gap(inset.sm),
          Wrap(
            spacing: inset.xs,
            runSpacing: inset.xs,
            children: [
              const CustomTextField(hint: "Session Date"),
              const CustomTextField(hint: "Start Time"),
              const CustomTextField(hint: "End Time"),
              const CustomTextField(hint: "Faconst culty Name"),
              const CustomTextField(hint: "Venue"),
              CustomCircleBtn(
                icon: Icons.add,
                iconColor: Colors.green,
                onTap: () {},
              )
            ],
          ),
          Gap(inset.sm),
          CustomButton(
            color: Colors.green,
            name: "Create",
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
