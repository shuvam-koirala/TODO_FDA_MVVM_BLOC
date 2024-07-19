import 'package:todo_fda_mvvm_bloc/barrel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _getPreviousBrightness();
    _getPreviousLocale();
    super.initState();
  }

  _getPreviousBrightness() async {
    final bool hasLightTheme =
        await SharedPreferenceHelper().getBool("hasLightTheme");
    if (!mounted) return;
    context.read<ThemeChangerCubit>().changeTheme(
        brightness: hasLightTheme ? Brightness.light : Brightness.dark);
  }

  _getPreviousLocale() async {
    final String? languageCode =
        await SharedPreferenceHelper().getString("languageCode");
    if (!mounted) return;
    context
        .read<LocalizationBloc>()
        .add(ChangeLanguage(languageCode: languageCode ?? "en"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.splashpage_title,
                textAlign: TextAlign.center,
              ),
              const Gap(24),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, NavigationRoutes.todoPage);
                  },
                  child: Text(
                      AppLocalizations.of(context)!.splashpage_get_started)),
            ],
          ),
        ),
      ),
    );
  }
}
