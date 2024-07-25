import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:like_image_app/modal/item_modal.dart';
import 'package:like_image_app/provider/item_provider.dart';
import 'package:provider/provider.dart';

class SwipeBody extends StatelessWidget {
  const SwipeBody({
    super.key, required this.isFavorite
  });

  final isFavorite;
  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<ItemProvider>(context);
    final items = isFavorite ? dataItem.showItemFavorite() : dataItem.items;

    return items.isNotEmpty ? Swiper(
      layout: SwiperLayout.STACK,
      itemHeight: 550,
      itemWidth: 350,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: items[index],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: Image.network(
                items[index].image,
                fit: BoxFit.cover,
              ),
              footer: GridTileBar(
                backgroundColor: Colors.white12,
                title: Consumer<Item>(
                  builder: (context, item, child) {
                    return InkWell(
                      onTap: (() {
                        item.toggleIsFavorite();
                        Provider.of<ItemProvider>(context, listen: false).handleCountItemFav();
                      }),
                      child: Icon(
                        Icons.favorite,
                        size: 30,
                        color: item.isFavorite? Colors.red:Colors.white,
                      ),
                    );
                  },
                ),
                subtitle: Text('Like Image'),
                trailing: Text(
                  items[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ): Container(
        child: Center(
          child: Text('No items to display'),
        ),
    );
  }
}
