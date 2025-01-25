import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: context.theme.indigoLight,
        title: const CustomText(txt: 'Home'),
        bottom: PreferredSize(
          preferredSize: const Size(double.maxFinite, 20),
          child: Row(
            children: [
              Gap(inset.sm),
              const Expanded(
                child: CustomTextField(
                  hint: 'Search here..',
                ),
              ),
              Gap(inset.sm),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: 5,
        padding: EdgeInsets.all(inset.xs),
        separatorBuilder: (context, index) => Gap(inset.xs),
        itemBuilder: (ctx, index) {
          return ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: context.theme.kWhite,
            title: const CustomText(txt: 'Event Name'),
            subtitle: rowTitleText("Fee", "\$ 500"),
            trailing: const Text('2001-11-23'),
          );
        },
      ),
    );
  }
}
