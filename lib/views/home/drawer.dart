part of 'view.dart';

class DrawerItem {
  final Widget icon;
  final Widget? screen;
  final String title;
  final bool haveSwitch;
  final Color fillColor;

  DrawerItem({required this.title, required this.icon, this.haveSwitch = false, required this.fillColor, this.screen});
}

final drawerItems = [
  DrawerItem(
    title: "About Us",
    icon: const AppImage(image: "us.svg"),
    fillColor: const Color(0xFF284243).withValues(alpha: 0.05),
    screen: const AboutUsView(),
  ),
  DrawerItem(
    title: "Rate Our App",
    icon: const AppImage(image: "rate.svg"),
    fillColor: const Color(0xFF284243).withValues(alpha: 0.05),
  ),
  DrawerItem(
    title: "Suggestions",
    icon: const AppImage(image: "suggestion.svg"),
    fillColor: const Color(0xFF284243).withValues(alpha: 0.05),
    screen: const SuggestionsView(),
  ),
  DrawerItem(
    title: "Enable Easy Login",
    icon: const AppImage(image: "finger_print.svg"),
    haveSwitch: true,
    fillColor: const Color(0xFF284243).withValues(alpha: 0.05),
  ),
  DrawerItem(
    title: "Logout",
    icon: const AppImage(image: "logout.svg"),
    fillColor: const Color(0xFFFF3A3A).withValues(alpha: 0.05),
    screen: const LoginView(),
  ),
];

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key, required this.item, required this.index, this.onSwitchTap, this.isSwitched = false});

  final DrawerItem item;
  final int index;
  final bool? isSwitched;
  final ValueChanged<bool>? onSwitchTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsetsGeometry.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(8), color: item.fillColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              item.icon,
              const SizedBox(width: 16),
              AppText(
                item.title,
                maxLines: 1,
                style: index != drawerItems.length - 1
                    ? theme.textTheme.labelLarge
                    : theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.error),
              ),
            ],
          ),
          if (item.haveSwitch)
            CupertinoSwitch(
              trackOutlineColor: const WidgetStatePropertyAll(null),
              trackOutlineWidth: const WidgetStatePropertyAll(0),
              activeTrackColor: const Color(0xFF2F65F0),
              inactiveTrackColor: const Color(0xFFC0C0C0),
              value: isSwitched ?? false,
              onChanged: onSwitchTap,
            ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isSwitched = false;
  Data? user;
  @override
  void initState() {
    isSwitched = CashHelper.getUserData()?.isEasyLoginEnabled ?? false;
    user = CashHelper.getUserData();
    super.initState();
  }

  Future<void> _toggleSwitch<T>(bool value) async {
    final CustomResponse<T> response = await DioHelper.postData(endpoint: "api/Profile/toggle-easy-login");
    if (response.isSuccess) {
      isSwitched = value;
      await CashHelper.setEasyLoginEnabled(value);
    } else {
      showMsg(response.msg);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsetsGeometry.only(top: kToolbarHeight, bottom: kToolbarHeight / 2),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AppImage(image:  user?.imageUrl??"", height: 200, width: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 14),
                AppText(
                  user?.name??"USER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontVariations: const [FontVariation("wght", 400)],
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
                const SizedBox(height: 6),
                AppText(
                  user?.email??"email@example.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontVariations: const [FontVariation("wght", 400)],
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: drawerItems.length,
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 24),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                return InkWell(
                  onTap: () async {
                    switch (item.title) {
                      case "About Us":
                        goto(const AboutUsView(), canPop: true);
                        break;
                      case "Suggestions":
                        goto(const SuggestionsView(), canPop: true);
                        break;
                      case "Enable Easy Login":
                        await _toggleSwitch(!isSwitched);
                        break;
                      case "Logout":
                        CashHelper.removeUserData();
                        goto(const LoginView(), canPop: false);
                        break;
                    }
                  },
                  child: index != 3
                      ? DrawerItems(item: item, index: index)
                      : DrawerItems(item: item, index: index, isSwitched: isSwitched, onSwitchTap: _toggleSwitch),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
