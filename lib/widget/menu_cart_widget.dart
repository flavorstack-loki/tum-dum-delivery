import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';
import 'package:tumdum_delivery_app/widget/switch_widget.dart';

import '../model/menu_item.dart';

class MenuCartWidget extends StatelessWidget {
  const MenuCartWidget({required this.menuItem, super.key});
  final MenuItem menuItem;
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorUtil.primaryColor.withAlpha(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: (menuItem.itemImage?.isNotEmpty ?? false)
                ? SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        menuItem.itemImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : null,
            title: Text(
              menuItem.itemName ?? "",
              style: style,
            ),
            subtitle: Text(menuItem.itemDescription ?? ""),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    RouteGenerator.menuEditPage,
                    arguments: menuItem),
                icon: const Icon(
                  Icons.edit,
                  color: ColorUtil.primaryColor,
                  size: 30,
                )),
          ),
          Text(
            "Item original Price: ${menuItem.itemOriginalPrice}",
            style: style,
          ),
          Text(
            "Item discounted Price: ${menuItem.itemDiscountedPrice}",
            style: style,
          ),
          Text(
            "Item Category: ${menuItem.categoryName}",
            style: style,
          ),
          Text(
            "Item Type: ${menuItem.itemFoodType}",
            style: style,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Out of Stock",
                style: style,
              ),
              SwitchWidget(
                  value: menuItem.outofStock ?? false,
                  onChanged: (value) async => await FbDbService.updateMenuItem(
                      menuItem..outofStock = value))
            ],
          )
        ],
      ),
    );
  }
}
