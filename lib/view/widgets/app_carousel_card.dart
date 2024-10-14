import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/offer_model/offer_model.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_rounded_offer_card.dart';

class AppCarouselCard extends StatefulWidget {
  final List<OfferModel> offers;

  const AppCarouselCard({
    super.key,
    required this.offers,
  });

  @override
  State<AppCarouselCard> createState() => _AppCarouselCardState();
}

class _AppCarouselCardState extends State<AppCarouselCard> {
  final CarouselSliderController _controller = CarouselSliderController();

  final ValueNotifier<int> _current = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.offers
              .map((offer) {
                return AppRoundedOfferCard(
                    image: offer.image,
                  );
              })
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            initialPage: 0,
            onPageChanged: (index, reason) {
              _current.value = index;
            },
            height: SizeConfig.isMobile()?150:SizeConfig.screenHeight*0.5,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            padEnds: false,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _current,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.offers
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        _current.value=widget.offers.indexOf(e);
                        _controller.animateToPage(_current.value);
                      },
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(
                                    widget.offers[_current.value] == e ? 0.9 : 0.4)),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        )
      ],
    );
  }
}
