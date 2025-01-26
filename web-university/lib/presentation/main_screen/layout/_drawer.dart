import 'package:app/presentation/main_screen/main_screen.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/debouncer.dart';
import 'package:app/resource/utils/extensions.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      backgroundColor: context.theme.kWhite,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Builder(builder: (context) {
          return ValueListenableBuilder(
            valueListenable: tabChangeNotifier,
            builder: (context, index, _) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Gap($style.insets.md),

                        /// Menu
                        Text(
                          pref.token.value.userType ?? 'N/A',
                          style: $style.text.textBold16.copyWith(
                            color: context.theme.kBlack,
                          ),
                        ),
                        Text(
                          pref.token.value.name ?? 'N/A',
                          style: $style.text.textBold12.copyWith(
                            color: context.theme.kBlack.withOpacity(0.5),
                          ),
                        ),
                        const Gap(20),
                        TileWidget(
                          tileName: 'Explore',
                          isSelected: index == 0,
                          icon: Icons.explore_outlined,
                          onTap: () {
                            tabChangeNotifier.value = 0;
                            context.go(ScreenPath.explore);
                          },
                        ),

                        TileWidget(
                          isSelected: index == 1,
                          tileName: 'College Validation',
                          icon: Icons.verified_outlined,
                          onTap: () {
                            tabChangeNotifier.value = 1;
                            context.go(ScreenPath.validation);
                          },
                        ),

                        const Gap(5),
                        TileWidget(
                          isSelected: index == 5,
                          tileName: 'Profile',
                          icon: Icons.account_circle_outlined,
                          onTap: () {
                            tabChangeNotifier.value = 5;
                            context.go(ScreenPath.profile);
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap($style.insets.sm),
                  TileWidget(
                    isSelected: true,
                    bgColor: context.theme.kWhite.withOpacity(0.3),
                    textColor: context.theme.kBlack,
                    tileName: 'Logout',
                    icon: Icons.exit_to_app,
                    onTap: () {
                      tokenCubit.logoutUser();
                      context.go(ScreenPath.login);
                    },
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  TileWidget({
    super.key,
    required this.tileName,
    required this.onTap,
    required this.icon,
    this.isSelected,
    this.bgColor,
    this.textColor,
  });
  final String tileName;
  final Function onTap;
  final IconData icon;
  final bool? isSelected;
  final Color? bgColor;
  final Color? textColor;
  final Debouncer _debouncer = Debouncer(const Duration(milliseconds: 100));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        dense: true,
        selectedTileColor:
            bgColor ?? context.theme.indigoLight.withOpacity(0.6),
        hoverColor: context.theme.kWhite.withOpacity(0.1),
        splashColor: context.theme.kWhite.withOpacity(0.1),
        enableFeedback: false,
        selected: isSelected ?? false,
        onTap: () {
          _debouncer.call(
            () {
              onTap();
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(
          icon,
          color: isSelected ?? false
              ? textColor ?? context.theme.indigo
              : textColor ?? context.theme.indigo,
          size: 18,
        ),
        title: Text(
          tileName,
          style: isSelected ?? false
              ? $style.text.textSBold12.copyWith(
                  color: textColor ?? context.theme.indigo,
                )
              : $style.text.textSBold12.copyWith(
                  color: textColor ?? context.theme.indigo,
                ),
        ),
      ),
    );
  }
}
