part of 'view.dart';

class DrawerItem {
  final Widget icon;
  final Widget? screen;
  final String title;
  final bool haveSwitch;
  final Color fillColor;
  

  DrawerItem({
    required this.title,
    required this.icon,
    this.haveSwitch = false,
    required this.fillColor,  this.screen,
  });
}

final drawerItems = [
  DrawerItem(
    title: "About Us",
    icon: const AppImage(image: "us.svg"),
    fillColor: const Color(0xFF284243).withValues(alpha: 0.05),
    screen: const AboutUsView()
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
    screen: const SuggestionsView()
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
  ),
];

class DrawerItems extends StatefulWidget {
  const DrawerItems({super.key, required this.item, required this.index});

  final DrawerItem item;
  final int index;

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsetsGeometry.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(8),
        color: widget.item.fillColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.item.icon,
              const SizedBox(width: 16),
              AppText(
                widget.item.title,
                maxLines: 1,
                style: widget.index != drawerItems.length - 1
                    ? theme.textTheme.labelLarge
                    : theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
          if (widget.item.haveSwitch)
            CupertinoSwitch(
              trackOutlineColor: const WidgetStatePropertyAll(null),
              trackOutlineWidth: const WidgetStatePropertyAll(0),
              activeTrackColor:const Color(0xFF2F65F0) ,
              inactiveTrackColor: const Color(0xFFC0C0C0),
              value: isSwitched,
              onChanged: (value) => setState(() {
                isSwitched = value;
              }),
            ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsetsGeometry.only(
              top: kToolbarHeight,
              bottom: kToolbarHeight / 2,
            ),

            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppImage(image: "profile.png", height: 160),
                const SizedBox(height: 14),
                AppText(
                  "Sara",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontVariations: const [FontVariation("wght", 400)],
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
                const SizedBox(height: 6),
                AppText(
                  "01027545631",
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
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                return InkWell(
                    onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => item.screen??const AboutUsView(),)),
                    child: DrawerItems(item: item, index: index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
