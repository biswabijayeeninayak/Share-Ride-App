import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showActionButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final bool isHome;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.centerTitle = false,
    this.showActionButton = true,
    this.isHome = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150.0),
      child: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 160, 3, 32),
        automaticallyImplyLeading: false,
        flexibleSpace: isHome
            ? GestureDetector(
                onTap: () =>
                    Get.to(() => const MapScreen(fromScreen: 'location')),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    70,
                    70,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeExtraSmall,
                  ),
                  child: Row(
                    children: [],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        centerTitle: centerTitle,
        excludeHeaderSemantics: true,
        // leading: showBackButton
        //     ? IconButton(
        //         icon: const Icon(Icons.arrow_back),
        //         color: const Color.fromARGB(255, 13, 5, 5),
        //         onPressed: () => onBackPressed != null
        //             ? onBackPressed!()
        //             : Navigator.pop(context),
        //       )
        //     : SizedBox.shrink(),
        title:Row(
  mainAxisAlignment: MainAxisAlignment.start, // Add your desired alignment
  children: [
    Padding(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Images.icon,
              fit: BoxFit.contain,
              height: 50,
            ),
            SizedBox(width: 55),
            Image.asset(
              Images.munsridename,
              fit: BoxFit.contain,
              height: 30,
            ),
          ],
        ),
      ),
    ),
  ],
)

        ),
      );
    
  }

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 150);
}








//to be continued.....

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showBackButton;
//   final bool showActionButton;
//   final Function()? onBackPressed;
//   final bool centerTitle;
//   final bool isHome;

//   const CustomAppBar({
//     Key? key,
//     required this.title,
//     this.showBackButton = true,
//     this.onBackPressed,
//     this.centerTitle = false,
//     this.showActionButton = true,
//     this.isHome = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(150.0),
//       child: AppBar(
//         toolbarHeight: 50,
//         backgroundColor: const Color.fromARGB(255, 160, 3, 32),
//         automaticallyImplyLeading: false,
//         // flexibleSpace: isHome
//         //     ? GestureDetector(
//         //         onTap: () =>
//         //             Get.to(() => const MapScreen(fromScreen: 'location')),
//         //         child: Padding(
//         //           padding: const EdgeInsets.fromLTRB(
//         //             70,
//         //             70,
//         //             Dimensions.paddingSizeDefault,
//         //             Dimensions.paddingSizeExtraSmall,
//         //           ),
//         //           child: Row(
//         //             children: [],
//         //           ),
//         //         ),
//         //       )
//         //     : const SizedBox.shrink(),
//         // centerTitle: centerTitle,
//         excludeHeaderSemantics: true,
//         leading:Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
        
           
        
//         // showBackButton
//         //     ? IconButton(
//         //         icon: const Icon(Icons.arrow_back),
//         //         color: const Color.fromARGB(255, 13, 5, 5),
//         //         onPressed: () => onBackPressed != null
//         //             ? onBackPressed!()
//         //             : Navigator.pop(context),
//         //       )
//         //     :const SizedBox.shrink(),
//          IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 color: const Color.fromARGB(255, 13, 5, 5),
//                 onPressed: () => onBackPressed != null
//                     ? onBackPressed!()
//                     : Navigator.pop(context),
//               ),
//         SizedBox(width: 10,),
        
//               Image.asset(
//               Images.icon,
//               fit: BoxFit.contain,
//               height: 50,
//               width: 60,
//             ),
//         ],) ,

//        centerTitle: true,
//         title:
//          Image.asset(
          
//               Images.munsridename,
//               fit: BoxFit.contain,
//               height: 30,
            
            
//             ),
// //         Row(
// //   mainAxisAlignment: MainAxisAlignment.start, // Add your desired alignment
// //   children: [
// //     Padding(
// //       padding: const EdgeInsets.all(0),
// //       child: SingleChildScrollView(
// //         scrollDirection: Axis.horizontal,
// //         child: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             // Image.asset(
// //             //   Images.icon,
// //             //   fit: BoxFit.contain,
// //             //   height: 50,
// //             // ),
// //             SizedBox(width: 55),
// //             Image.asset(
// //               Images.munsridename,
// //               fit: BoxFit.contain,
// //               height: 30,
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //   ],
// // )

//         ),
//       );
    
//   }

//   @override
//   Size get preferredSize => const Size(Dimensions.webMaxWidth, 150);
// }
