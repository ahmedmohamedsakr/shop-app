import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/utils/navigation.dart';
import 'package:shop_app/core/services/cache_helper.dart';
import 'package:shop_app/domain/entities/onboarding.dart';
import 'package:shop_app/presentation/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //todo : fill onboarding screen information.
  List<Onboarding> model = [
    Onboarding(
      image: 'assets/images/Online shopping.png',
      title: 'Order For Items',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      animation: 'assets/animations/dot-pattern-background.json',
      backgroundColor: Colors.deepPurple,
    ),
    Onboarding(
      image: 'assets/images/Payment Information.png',
      title: 'Payment Process',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      animation: 'assets/animations/Starry Background.json',
      backgroundColor: Colors.amber,
    ),
    Onboarding(
      image: 'assets/images/delivery.png',
      title: 'Items Delivery',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      animation: 'assets/animations/dot-pattern-background.json',
      backgroundColor: Colors.blueGrey,
    ),
  ];
  bool isLastPage = false;
  var onboardingController = PageController();
  Color background = Colors.deepPurple;
  String animation = 'assets/animations/dot-pattern-background.json';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Lottie.asset(
              animation,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: onboardingController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      if (index == model.length - 1) {
                        setState(() => isLastPage = true);
                      } else {
                        setState(() => isLastPage = false);
                      }
                      setState(() {
                        background = model[index].backgroundColor;
                        animation = model[index].animation;
                      });
                    },
                    itemBuilder: (context, index) =>
                        buildOnboardingItem(model[index]),
                    itemCount: model.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: onboardingController,
                    count: model.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      dotColor: Colors.white,
                      activeDotColor: Colors.white,
                      spacing: 5,
                      expansionFactor: 4.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                if (isLastPage)
                  MaterialButton(
                    onPressed: () {
                      buildNavigateAndRemove(context);
                    },
                    color: Colors.white,
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minWidth: double.infinity,
                    child: Text(
                      'Get Started',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            letterSpacing: 2.0,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                if (!isLastPage)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          buildNavigateAndRemove(context);
                        },
                        child: Text(
                          'Skip',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          onboardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(IconlyBold.arrowRight2,
                                color: Colors.white, size: 28.0),
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void buildNavigateAndRemove(BuildContext context) {
    CacheHelper.setData(key: 'onBoard', value: true);
    navigateAndRemove(context, LoginScreen());
  }

  Column buildOnboardingItem(Onboarding model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          model.title,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(
          height: 18.0,
        ),
        Text(
          model.body,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.white,
                fontSize: 18.0,
              ),
        ),
      ],
    );
  }
}
