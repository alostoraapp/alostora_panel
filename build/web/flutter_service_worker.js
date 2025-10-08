'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "9fea258854c3cd1099055c2c45ed5cf1",
"assets/AssetManifest.bin.json": "60d8572e40fe031e5b9325162065e679",
"assets/AssetManifest.json": "e62e0fc5a192fdade475b37c8ee4b547",
"assets/assets/app_icons/app_icon_main.png": "2e11604bac4e7929d37e5f77b090f275",
"assets/assets/images/sidebar_icons/ai.svg": "88e50c314605803de5a71c4a6d03f41c",
"assets/assets/images/sidebar_icons/alert-octagon.svg": "c1a4d976715185fdd7811a5d4a8f9fdc",
"assets/assets/images/sidebar_icons/arrows-move.svg": "dda026f1530f615c845c7b277faf5ba8",
"assets/assets/images/sidebar_icons/calendar.svg": "63068f77fc4900f238c17a57075a16ce",
"assets/assets/images/sidebar_icons/cart.svg": "0c49601c3f5a765d262cb41c38b49429",
"assets/assets/images/sidebar_icons/chat-text.svg": "b2db319fd9b397cb44ae3a6857825829",
"assets/assets/images/sidebar_icons/checkbox-square-fill.svg": "7eb9729a72045cd3c853bff6e6db1757",
"assets/assets/images/sidebar_icons/clipboard-text.svg": "97a396d53129ab495f99fc53467d47e5",
"assets/assets/images/sidebar_icons/copy-check.svg": "7782cb67615cd86eda7b51b4f22e57a3",
"assets/assets/images/sidebar_icons/cursor-click.svg": "a11ddd72db9a057059bb29e64b4e75f8",
"assets/assets/images/sidebar_icons/diamond-exclamation.svg": "d7b32029141f5aa5b880a8b0f2bcf4af",
"assets/assets/images/sidebar_icons/envelope.svg": "aa7ebfb6782693dfe6ac4cb1587c3f02",
"assets/assets/images/sidebar_icons/exclamation-circle.svg": "2cce22ef35c47cf4f4b4d30b0e918a5a",
"assets/assets/images/sidebar_icons/home-dash-star.svg": "8fd455c3c9edeb87a72cf330c50667f4",
"assets/assets/images/sidebar_icons/image-gallery.svg": "952880f2cf4d57ec46b31c78486f1b1b",
"assets/assets/images/sidebar_icons/kanban.svg": "e7205f309f4489e8ccc891b83efd1c1e",
"assets/assets/images/sidebar_icons/Language.svg": "8313ac6e9060994d1cb99b1c3f2c67da",
"assets/assets/images/sidebar_icons/laptop.svg": "96463b403e2121cd1c798d59fe57d239",
"assets/assets/images/sidebar_icons/map-location.svg": "76c3e21ef016e8c9327b5beaa9dedfab",
"assets/assets/images/sidebar_icons/money-bills.svg": "fa1e61533cfb0aa9f034886da31d97f6",
"assets/assets/images/sidebar_icons/note-list.svg": "89cdcca7c8de23a6832a9df39bba3b04",
"assets/assets/images/sidebar_icons/palette.svg": "d420e99be7202324eaab7933a8c3973c",
"assets/assets/images/sidebar_icons/pos.svg": "121562e0d59e205d28d4db93f97bdc45",
"assets/assets/images/sidebar_icons/question-square.svg": "ce8c9d2dcbb961e46dfacbb43714adc6",
"assets/assets/images/sidebar_icons/triangle-exclamation.svg": "a08a416446f375531c98f7afa650e96b",
"assets/assets/images/sidebar_icons/user.svg": "da7eb9f31c8d8dbd435772d2612ddf82",
"assets/assets/images/sidebar_icons/users-group.svg": "411850cb7c1cfe05d93774278ed6ec7c",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_01.png": "fba0a409b0a73f7ead6a71a15e6e9c9d",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_02.png": "9566b254cca04bafea733ee70ba9365f",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_03.png": "55520505edb1fb18c932bc2d1a738579",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_04.png": "bdcee754f121874ca20d6c7c106c6ac2",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_05.png": "27809cfd3dc2f1a2f652a2841e7874b4",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_06.png": "0a452e2be1a67e68cc1925a874441133",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_07.png": "e656e9b126b8ca45d5671616738a4e96",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_08.png": "f1cda0c96354aa7a74a64fb0b2f6fe91",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_09.png": "e6529109bad4dacc015bf3695975b6ef",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_10.png": "8c2ff9139dd11b34bcd66afb93c8bbf3",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_11.png": "b27904c7636bdc802309616f037e8d40",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_12.png": "a4ed5aa864e0b601ad6ee49cbced3b4f",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_13.png": "9af7473e0684c3134e9b561f4f9e4c8d",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_14.png": "e4672499be06f5ad7c95c097fc9d1cab",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_15.png": "b959a57af0e1b31fc9385cd1c75c0724",
"assets/assets/images/static_images/ai_generated/images/ai_generated_image_16.png": "04417cdd0ee70ebb24572bb265b706c7",
"assets/assets/images/static_images/avatars/person_images/person_image_01.jpeg": "434bbd3e282c813d1ccecd722381cad0",
"assets/assets/images/static_images/avatars/person_images/person_image_02.jpeg": "add9278645fc5d888e96f11130fc0b28",
"assets/assets/images/static_images/avatars/person_images/person_image_03.jpeg": "472124d76da07619ea1ef1b4ffc2cf7b",
"assets/assets/images/static_images/avatars/person_images/person_image_04.jpeg": "e8d328086402c5da8021e7561e287de9",
"assets/assets/images/static_images/avatars/person_images/person_image_05.jpeg": "416dac96f292482a1c7b0f6dc64cc216",
"assets/assets/images/static_images/avatars/person_images/person_image_06.jpeg": "a7258c2c25589b93f42926117b244d3a",
"assets/assets/images/static_images/avatars/person_images/person_image_07.jpeg": "a2fb3f7b3760d73a22dc7b86a615c190",
"assets/assets/images/static_images/avatars/person_images/person_image_08.jpeg": "42f0c434f09be2d3a794630a233a167d",
"assets/assets/images/static_images/avatars/person_images/person_image_09.jpeg": "2674ff182611d6f3d9ca8ad39d08869b",
"assets/assets/images/static_images/avatars/person_images/person_image_10.jpeg": "c44fbb40054e312e4e9c0133c11f9e3d",
"assets/assets/images/static_images/avatars/person_images/person_image_11.jpeg": "36e53db7e688ce1168bf663667077ee3",
"assets/assets/images/static_images/avatars/person_images/person_image_12.jpeg": "1bcbe869d7ae3c8bbabadeef987d6b3f",
"assets/assets/images/static_images/avatars/person_images/person_image_13.jpeg": "3536ff11dbf7424f10baaaf133228090",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_01.png": "e97901834ada00480673928707c37372",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_02.jpeg": "0b2d409a83aa239e35937749042152af",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_03.png": "dc135fc73369f36008f3a5de71f5953b",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_04.png": "4c8e16eeeac215ddb1865b7e778d0731",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_05.png": "b4dcfb2c57b8869108e8935b19b1c5b1",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_06.png": "ef236f25181ff91dd449d247128cfb3c",
"assets/assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_07.png": "33fa88443a105f7c8d5f436ea50adc61",
"assets/assets/images/static_images/background_images/background_image_01.png": "7f74d56516f195aaa52345e13f1e51f5",
"assets/assets/images/static_images/background_images/background_image_02.png": "1d3ed016086bcb43a18be4d94eb55e77",
"assets/assets/images/static_images/background_images/background_image_03.png": "c1bfc626acbd0f3357241060a87569d6",
"assets/assets/images/static_images/background_images/background_image_04.png": "c03d0c8c389731016ab6b89a3206474e",
"assets/assets/images/static_images/background_images/background_image_05.png": "1794fec8b77ca09ea1fc0c4441059edf",
"assets/assets/images/static_images/background_images/background_image_06.png": "592af38a2d81a670f0afe1b6f1d4c119",
"assets/assets/images/static_images/background_images/background_image_07.png": "98a9dbec03dc2d85f7a97c6a6d21d9ed",
"assets/assets/images/static_images/background_images/background_image_08.png": "a4874f4ab8b7362f786f93b8af972a7c",
"assets/assets/images/static_images/background_images/background_image_09.jpeg": "75312da0d24f5f6736c955c42cd53509",
"assets/assets/images/static_images/background_images/background_image_09.png": "6a763540121553c54191115229ed6eb0",
"assets/assets/images/static_images/background_images/background_image_10.png": "190cd5b90e6af662a2a8fc157ba48e6b",
"assets/assets/images/static_images/background_images/background_image_11.png": "63334a93eafa85dac8e9ca64aec6544a",
"assets/assets/images/static_images/background_images/background_image_12.png": "ecfdb9a4a65adaa2c83ea6d479b54744",
"assets/assets/images/static_images/background_images/background_image_13.png": "85251e2f18f0c8917cca9b7568a3f629",
"assets/assets/images/static_images/background_images/background_image_14.png": "fd22252375e5038b0cf260bffb5a5066",
"assets/assets/images/static_images/background_images/background_image_15.png": "35b3eea6a8fd5f7e2301eab1ca20fc70",
"assets/assets/images/static_images/background_images/background_image_16.png": "25659cc411f58d6a6e9a84e2facbf225",
"assets/assets/images/static_images/background_images/background_image_17.png": "63a4c2a6116968de6b2a325636ec959d",
"assets/assets/images/static_images/background_images/background_image_18.png": "3199c1c3e3b88b81edcbdcb07124bd5e",
"assets/assets/images/static_images/background_images/background_image_19.png": "e1ce465fef898a0877b38d3d55f8e2f3",
"assets/assets/images/static_images/icons/crypto_icons/bitcoin_icon.svg": "70b4eb38c3e32b72c8770573f7a5372a",
"assets/assets/images/static_images/icons/crypto_icons/ethereum_icon.svg": "9c230f26f35193e55c97dfb1786ca825",
"assets/assets/images/static_images/icons/crypto_icons/solana_icon.svg": "e7064d43cb44661f63194629169b34a4",
"assets/assets/images/static_images/icons/social_icons/cloud.svg": "aae5358bae6212a4ceb1cfe3af98dc55",
"assets/assets/images/static_images/icons/social_icons/email.svg": "00524a8d9e11e257c0204083991a12ba",
"assets/assets/images/static_images/icons/social_icons/facebook.svg": "b17e34fe6c6709f595c4526e50915b7e",
"assets/assets/images/static_images/icons/social_icons/share.svg": "320af28f5c276a4ef4d2ca7b7845f440",
"assets/assets/images/static_images/icons/social_icons/telegram.svg": "c5acf98726ea06748988bc012cd32aa7",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_01.png": "39ba1938b4de3b11c3053ede73866aa0",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_02.png": "59f2bf491fd4746fbe5385edf0befdc0",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_03.png": "b399998bd63c6bd8337e8671085bb9dd",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_04.png": "6800708d5541b38f05e56e6bb102c254",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_05.png": "1628cec720ad9fbf3338762ce6afd097",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_06.jpeg": "8f79cda677eb4b0dbaea5f1017840d87",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_07.jpeg": "ca689d7d619ab7ffcc4a05e1c0721532",
"assets/assets/images/static_images/placeholder_images/random_placeholders/placeholder_08.png": "08642ce8445b7ffff93e9d73d3c4c7b3",
"assets/assets/images/static_images/product_images/product_image_01.png": "920c96f2962068af67c7f8a51170e0e1",
"assets/assets/images/static_images/product_images/product_image_02.png": "a55ff02a21cc305ba37168820e5dddf9",
"assets/assets/images/static_images/product_images/product_image_03.jpeg": "380ab3a8d862b69356495db4eee99a65",
"assets/assets/images/static_images/product_images/product_image_04.png": "d3909a3fd0e949d9723c829f66891329",
"assets/assets/images/static_images/product_images/product_image_05.png": "debdcd63d30f5cc7a061075d56a4d838",
"assets/assets/images/static_images/product_images/product_image_06.png": "5885eacd2bfc9ae94f404c8e71186b0f",
"assets/assets/images/static_images/product_images/product_image_07.png": "9715e477056538d5e29a1a64722f1ee6",
"assets/assets/images/static_images/product_images/product_image_08.png": "d335c11eb25ea8cc437981ecc9b4d821",
"assets/assets/images/static_images/product_images/product_image_09.png": "0d469d86fd61cc0e9c90ed489af04cc5",
"assets/assets/images/static_images/product_images/product_image_10.png": "c28263e712052585436dbe5b3eae3bfb",
"assets/assets/images/static_images/product_images/product_image_11.png": "e66c4f18fd225855160f9816622a49d1",
"assets/assets/images/static_images/product_images/product_image_12.png": "9b03bd3f52cc68926baca92d56364300",
"assets/assets/images/static_images/product_images/product_image_13.png": "e68c7812a8bb5df066cc30bf6a378019",
"assets/assets/images/static_images/product_images/product_image_14.png": "1a3a3c8634836a30222e2f63fa1ad41e",
"assets/assets/images/static_images/product_images/product_image_15.jpeg": "2430663175ce82ef41193afc675797df",
"assets/assets/images/static_images/product_images/product_image_16.png": "905cc8c00793abf6882931c1c9159f80",
"assets/assets/images/static_images/product_images/product_image_17.png": "3eadd58185b31efd374b2210dc931d63",
"assets/assets/images/static_images/product_images/product_image_18.jpeg": "583e2074b8c6a2d42c07c9239d50cb14",
"assets/assets/images/static_images/product_images/product_image_19.png": "d52e67ad16f05ad5d45129333c5f38d6",
"assets/assets/images/static_images/product_images/product_image_20.png": "ae7ea508b900fceea457d23e793e363f",
"assets/assets/images/static_images/product_images/product_image_21.png": "ae5be029fa230d4ac0e8e94c1e1b8334",
"assets/assets/images/static_images/product_images/product_image_22.png": "e96a4684d3e961bf20a5b47f5bd55b54",
"assets/assets/images/static_images/product_images/product_image_23.jpeg": "78781ee9d4c3fb6f544b2df507681830",
"assets/assets/images/static_images/product_images/product_image_24.png": "f62ff7616b2cebe642bfe7bebc33b396",
"assets/assets/images/static_images/product_images/product_image_25.png": "b5cd8b3c02ed124f70c2d3cf811242bb",
"assets/assets/images/static_images/product_images/product_image_26.png": "419478c361c32a75cc4e54f7dfea355e",
"assets/assets/images/static_images/product_images/product_image_27.png": "8c0eabc3facc13b4624df45dffd818c8",
"assets/assets/images/static_images/product_images/product_image_28.png": "3d958054d6903def10911dc35f917f51",
"assets/assets/images/static_images/product_images/product_image_29.png": "3c04bee007b3a49dcce308d80f5e791b",
"assets/assets/images/static_images/product_images/product_image_30.png": "7f6308e919e216c3ba3932800f4ff493",
"assets/assets/images/static_images/product_images/product_image_31.png": "64881d16d89ecb68254ad7e40a4c4566",
"assets/assets/images/static_images/product_images/product_image_32.png": "881dedfe1f3bd400761a76fde96b5101",
"assets/assets/images/static_images/product_images/product_image_33.png": "99322219bf2f6d6c8ece510a7eaa72d6",
"assets/assets/images/static_images/product_images/product_image_34.png": "31b224e8f0d23fc638b42402b84ca6ff",
"assets/assets/images/static_images/product_images/product_image_35.png": "644dca7ae982813c0535558962fdeb8a",
"assets/assets/images/widget_images/authentication_images/apple_icon.svg": "5fa2bfd41d5c7f484832f40390dba8a7",
"assets/assets/images/widget_images/authentication_images/google_icon.svg": "459202d51ea61e4edcf74a368ffce4b8",
"assets/assets/images/widget_images/authentication_images/signin_cover.svg": "d8298c2575481b183b52d8bf14efd5e7",
"assets/assets/images/widget_images/authentication_images/signup_cover.svg": "139e94c6f2e5d1ca71ef7d8b682feefd",
"assets/assets/images/widget_images/banner_images/banner_image01.png": "737e516b2f8ba65074c94f6b7c864bb7",
"assets/assets/images/widget_images/card_images/feature_card/feature_card_bg.png": "8730128ff4b5e31ff2f3138e66a9258e",
"assets/assets/images/widget_images/card_images/feature_card/feature_card_icon_01.svg": "3ce48a24a6b2927962626fc0862afb38",
"assets/assets/images/widget_images/card_images/feature_card/feature_card_icon_02.svg": "99e747ee74e06e809107b9655d911aae",
"assets/assets/images/widget_images/card_images/feature_card/feature_card_icon_03.svg": "903f7ce49cee6407eb2bbafdd2682678",
"assets/assets/images/widget_images/card_images/feature_card/feature_card_icon_04.svg": "53ce33e839f1ee6ed43e86bb295521db",
"assets/assets/images/widget_images/card_images/feature_card/star_badge.svg": "ce843d6f837b1ae666d589c23f8eb0de",
"assets/assets/images/widget_images/country_image/bd.png": "99d0837b4f3e9837584e2f594597cded",
"assets/assets/images/widget_images/country_image/in.png": "5af3416d2caf74f8ec0cd3f5fbc5e32d",
"assets/assets/images/widget_images/country_image/pakisthan.png": "771b846242129d6b21ec284b9f853c47",
"assets/assets/images/widget_images/country_image/saudi.png": "fe9aeac3e6707138eaef54e04ab10c1b",
"assets/assets/images/widget_images/country_image/us.png": "9931bd80bac82b712fd2f6e7609a4070",
"assets/assets/images/widget_images/dashboard_icon/article.svg": "7c34272c32c8908aba4c52a8352b5790",
"assets/assets/images/widget_images/dashboard_lms_management_icons/marketing.svg": "46fd1b718ee901a7d5cea80d9d3f6ed4",
"assets/assets/images/widget_images/dashboard_lms_management_icons/mathmatics.svg": "961b7ebcc780bd2cb16eaefb31a58896",
"assets/assets/images/widget_images/dashboard_lms_management_icons/philosopy.svg": "f13328bd56b736221fa86e55c20e7c63",
"assets/assets/images/widget_images/dashboard_lms_management_icons/uiux.svg": "08dbd9a7c813ad8fc4dfb7ed591ac564",
"assets/assets/images/widget_images/dashboard_lms_management_icons/web.svg": "eb2c27f698914d42514a87ecb9d2bfd2",
"assets/assets/images/widget_images/dashboard_overview_icon/approved_withdraw.svg": "b913f90c099f50c769119d8b751de817",
"assets/assets/images/widget_images/dashboard_overview_icon/code_icon.png": "17aca7a9078e7546a278c9f06af6f0cf",
"assets/assets/images/widget_images/dashboard_overview_icon/credit_card_icon.png": "ba9e23995d6f528c6ad0ddd74749bae5",
"assets/assets/images/widget_images/dashboard_overview_icon/document_icon.png": "9a63109f357fef33683a72d475f05d20",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/cancelled_orders.svg": "a4961538263919892bba74a161651426",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/all_category.svg": "a18ed18cfdaaba46f83c263b40737437",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/computer.svg": "1390b643c4ed3739ca8ef55347c40800",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/fresh_food.svg": "ffba07acfa80781dc3faa74ac0ef253e",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/shoes.svg": "bd8e9e18f16151209a9f246aa3577acf",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/smart_phone.svg": "b4145450c0c21eeaacc8fc2a327a0e50",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/sunglass.svg": "b4b7dc066efd35d3bacf04b324c414cd",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/t_shirts.svg": "b9121274e79d54365213656a02678a1b",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/woman_bag.svg": "1003a77ad99f9aaecfbc6ba7295b478a",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/category_icons/woman_dress.svg": "8d431c72058159c57444a3e4b143c404",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/coupon_icon.svg": "c7a0d81d7e13df749e092ed496afdfca",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/delivered_orders.svg": "aa88726d164bc25ee0923667fb1927cd",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/out_of_delivery_orders.svg": "e98bcf51d300a577c0a696c050be4beb",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/pending_orders.svg": "e389e4eaa0efd2710e5894027a675731",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/processing_orders.svg": "0afe97f29e4662f1ec23526fe9068830",
"assets/assets/images/widget_images/dashboard_overview_icon/ecommerce_admin_icons/shipped_orders.svg": "be0e12a5111f6539a6767988c3ef40a9",
"assets/assets/images/widget_images/dashboard_overview_icon/edit_icon.png": "c896070e5d8215dd68af04c769740b73",
"assets/assets/images/widget_images/dashboard_overview_icon/image_icon.png": "2b22ece941f029c696ab095f6dd98335",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/active_client.svg": "76f3f43c116f96f5f349f4e20071aa17",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/active_influencer.svg": "669778ca7946dc3f72c8830fba4f9fbb",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/total_client.svg": "3a28a2f234e4bc5cc39c3bf8ed76685a",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/total_expense.svg": "daaa527c77876c3a9aa84d2b4fa8a382",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/total_income.svg": "90802daa1740502666ae64985b16b43b",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/total_influencer.svg": "f45d903b74bce108af46675602c73b2d",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/total_service.svg": "323bf58e3ee8a645a3dc21ac56d27edf",
"assets/assets/images/widget_images/dashboard_overview_icon/influencer_admin_icons/total_user.svg": "9cd8c6546b3b169156c7975a7c3f1a89",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/ad_spaces.svg": "e609af99a9abe91854a663851a916083",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/breaking_news.svg": "4fd7941f4bd8db092e672e413702e530",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/breaking_news1.svg": "e609af99a9abe91854a663851a916083",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/category.svg": "2823ef593efbfb24acc5e80d956cbf32",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/draft_news.svg": "67175c02ec0f3c963e9ac69fe4ba00e3",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/featured_section.svg": "8fcdfce75acf5f67e6a0a6a26c94bdc8",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/language.svg": "d0668fcbc9a24885ffccffc875b711ab",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/news_readers.svg": "4625b2a2e0a42fb6be30603834c540ff",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/published_news.svg": "8154314038fb0616228833cbf304e93e",
"assets/assets/images/widget_images/dashboard_overview_icon/news_admin_icons/total_blogs.svg": "91de074cb38a843018f78e590c7076ce",
"assets/assets/images/widget_images/dashboard_overview_icon/pdf_icon.png": "e5047126c7ec40d6ed532e625304de5d",
"assets/assets/images/widget_images/dashboard_overview_icon/pending_withdraw.svg": "9d56f448ed54e76d436b1fb393beea91",
"assets/assets/images/widget_images/dashboard_overview_icon/rejected_withdraw.svg": "0c0efc19854eed341b907c226b2458ec",
"assets/assets/images/widget_images/dashboard_overview_icon/speech_to_text.png": "05c6f8add31b1f5b783eedddf46a5d89",
"assets/assets/images/widget_images/dashboard_overview_icon/total_currency.svg": "62545152d1ebd78971188f2ab7930d87",
"assets/assets/images/widget_images/dashboard_overview_icon/total_delivery_boy.svg": "bbb355b42816ae5f488708d3a60ba2bd",
"assets/assets/images/widget_images/dashboard_overview_icon/total_orders.svg": "2f2189d870921965bb044d063b386f10",
"assets/assets/images/widget_images/dashboard_overview_icon/total_products.svg": "dd3f9c264923ffe3fab62350fc15c9d7",
"assets/assets/images/widget_images/dashboard_overview_icon/total_questions.svg": "31eca2c674d27a73416bd766b497afea",
"assets/assets/images/widget_images/dashboard_overview_icon/total_quizzes.svg": "814da0f39d7ad0942d5bf120b385eee0",
"assets/assets/images/widget_images/dashboard_overview_icon/total_quiz_category.svg": "0faffb5b52376a0ec25edea53e2754e1",
"assets/assets/images/widget_images/dashboard_overview_icon/total_revenue.svg": "a83c16e4be561c97882f9744098adee8",
"assets/assets/images/widget_images/dashboard_overview_icon/total_rewards.svg": "908ec0a2f8a9c433208e95a6a6673a1a",
"assets/assets/images/widget_images/dashboard_overview_icon/total_stores.svg": "54b65dbf075992a66212fe29dbe5d22a",
"assets/assets/images/widget_images/dashboard_overview_icon/total_user.svg": "0d8b2b07f13ae6f4b08caefeba8b21ed",
"assets/assets/images/widget_images/dashboard_overview_icon/total_withdraw.svg": "471aadce445bb037e41d3fd2c53782a0",
"assets/assets/images/widget_images/dashboard_overview_icon/voiceover_icon.png": "ed698201d7d1c12870feccfa6be619cd",
"assets/assets/images/widget_images/delivery_dashboard_icons/bicycle.svg": "46715eec98a8aa32aad5464530096314",
"assets/assets/images/widget_images/delivery_dashboard_icons/bike.svg": "84456912c7520d84d5911cb79bcda1af",
"assets/assets/images/widget_images/delivery_dashboard_icons/car.svg": "3458c3159c8934bc2fa00637e3d2e801",
"assets/assets/images/widget_images/delivery_dashboard_icons/cost.svg": "5e3ab383cd5c17d4e5a4639bdf69daf6",
"assets/assets/images/widget_images/delivery_dashboard_icons/income.svg": "9e9da3d69f0dd81929d278134d5648de",
"assets/assets/images/widget_images/delivery_dashboard_icons/location.svg": "1efb4066502a9b9fdb4718f78674c60a",
"assets/assets/images/widget_images/delivery_dashboard_icons/order_cancelled.svg": "1dfaa1151e1c71dc847f024cb80d0a38",
"assets/assets/images/widget_images/delivery_dashboard_icons/order_confirm.svg": "0e9d0aba7f3051afa04e7f7a04f896b0",
"assets/assets/images/widget_images/delivery_dashboard_icons/order_delivered.svg": "93fd5dce2e680031071a102efa3cd9aa",
"assets/assets/images/widget_images/delivery_dashboard_icons/order_pending.svg": "0af650c8d0ee2c6efe4e21b34eb46885",
"assets/assets/images/widget_images/delivery_dashboard_icons/revenues.svg": "c43ebeff09d5af9b634fc06a0ba2e833",
"assets/assets/images/widget_images/delivery_dashboard_icons/sender.svg": "97d7e58f38abaaecf96881291d4cd8a7",
"assets/assets/images/widget_images/delivery_dashboard_icons/sold.svg": "5a0d279b76df797ee800056970459882",
"assets/assets/images/widget_images/not_found_images/not_found.svg": "eab8e1c2a30febc072901e632e8073ca",
"assets/assets/images/widget_images/sm_icon/facebok.png": "3e4043083bb01eb06cc98585248e97fd",
"assets/assets/images/widget_images/sm_icon/instagram.png": "f9d50ec3871c7f44bc13ae983da8ac1d",
"assets/assets/images/widget_images/sm_icon/linkedIn.png": "1c01c28b9e9bf09e84ada0d9293ece1d",
"assets/assets/images/widget_images/sm_icon/pinterest.png": "bf55473f94427ee1b9abbe4c3d1256e6",
"assets/assets/images/widget_images/sm_icon/twitter.png": "17ffd89ff1959e6d66a1123897c558ca",
"assets/assets/images/widget_images/sm_icon/youtube.png": "e0a502bda09efb50b8fc8d17cb6ed5af",
"assets/assets/images/widget_images/svg_icons/amount.svg": "7ad5c3dad12a1cc19a8cfc71d56140bb",
"assets/assets/images/widget_images/svg_icons/approved.svg": "0e172c1d7da83c15b6a93bc3c0f3fa8b",
"assets/assets/images/widget_images/svg_icons/bar.svg": "414d1dbcfe224714734e5e72ec439ee6",
"assets/assets/images/widget_images/svg_icons/book01.svg": "f3008cab1e5922c1e13e26ac2f3eeb25",
"assets/assets/images/widget_images/svg_icons/building01.svg": "7bf27e3669863435a99027096c6aadea",
"assets/assets/images/widget_images/svg_icons/bus_transit01.svg": "d747c0fe20aefb0bf99ae4707e8ec118",
"assets/assets/images/widget_images/svg_icons/cart_checked.svg": "b04dabc11105fa8fccf1fa78e4fb4924",
"assets/assets/images/widget_images/svg_icons/copy_icon.svg": "5fb4f3da94af93cafb05c2a8a057b4d9",
"assets/assets/images/widget_images/svg_icons/csv_icon.svg": "a638c356ba3545834da70663272b2507",
"assets/assets/images/widget_images/svg_icons/discount_ticket01.svg": "d165aece7da4d156bdf1d76a9fb9b2dc",
"assets/assets/images/widget_images/svg_icons/dollar_out_square.svg": "d3855c03756432e58ac228fcd4b5c646",
"assets/assets/images/widget_images/svg_icons/dollar_sack.svg": "df8e3f12a9f8e5b8c2fd971187d26cd2",
"assets/assets/images/widget_images/svg_icons/edit.svg": "1ca2e5d30e130b08113a3c863c2833da",
"assets/assets/images/widget_images/svg_icons/edite.svg": "fa51e02169673756f99b9251d4120372",
"assets/assets/images/widget_images/svg_icons/excel_icon.svg": "f5d125281b8387257414fa31329299df",
"assets/assets/images/widget_images/svg_icons/expired.svg": "7e5de4ab86ee8f221b4e2caf6eeaafcd",
"assets/assets/images/widget_images/svg_icons/flow.svg": "fca2d311a71ab8adb2e1a1b3be70d387",
"assets/assets/images/widget_images/svg_icons/gallery_icon.svg": "0e90a8800398b53eec0735cebf7a45ec",
"assets/assets/images/widget_images/svg_icons/group.svg": "6f999b8c832c1212e038b76dff716aff",
"assets/assets/images/widget_images/svg_icons/package_checked.svg": "4a5d82ca8629f364621a657f252fd6d6",
"assets/assets/images/widget_images/svg_icons/parent01.svg": "72e4c78ce48e21be6add86d99a679f93",
"assets/assets/images/widget_images/svg_icons/pdf_icon.svg": "f3ba3757f8fe8224100db9a84dac5480",
"assets/assets/images/widget_images/svg_icons/pending.svg": "2d39f8d0c2fc6b9a73ad6b57bc30c827",
"assets/assets/images/widget_images/svg_icons/print_icon.svg": "b85dc2fe978bf2caaf235bec2c2c0e34",
"assets/assets/images/widget_images/svg_icons/property.svg": "bc42f8a4b9e6aa797288da308c501426",
"assets/assets/images/widget_images/svg_icons/refunds.svg": "a1409959f493e499e6db035417999dd1",
"assets/assets/images/widget_images/svg_icons/rejected.svg": "f55d020205d71e5d62ec40ee6e00372c",
"assets/assets/images/widget_images/svg_icons/send.svg": "d618128bb77b494d87fff95ca8267f48",
"assets/assets/images/widget_images/svg_icons/shop.svg": "e0796aaf03479eaf00c0b5e09a573832",
"assets/assets/images/widget_images/svg_icons/star.svg": "9962ff7ee4ff931d9982b4bed2e7c681",
"assets/assets/images/widget_images/svg_icons/stock_medicine.svg": "a602c381604a0739fa8e825540484702",
"assets/assets/images/widget_images/svg_icons/students01.svg": "215606a789865578d3ff68a09ee8dedb",
"assets/assets/images/widget_images/svg_icons/students02.svg": "dac1b9b7fc55116bbcce4a7467c4b354",
"assets/assets/images/widget_images/svg_icons/supplier.svg": "879ca8e6b851c63deaed0f11d1c2b110",
"assets/assets/images/widget_images/svg_icons/tag_dollar.svg": "c92ec725d3a16b973f92c15eaa0f3523",
"assets/assets/images/widget_images/svg_icons/teacher01.svg": "708da04ccebbacb5d299a672d66250e7",
"assets/assets/images/widget_images/svg_icons/trash.svg": "9638fcf613df53a5763062140d547b06",
"assets/assets/images/widget_images/svg_icons/tutor.svg": "0fe618ed84e6c4bcc90c7bdfc0f02c6e",
"assets/assets/images/widget_images/svg_icons/upload_cloud.svg": "b4953f77ec4c8723736cc55640922807",
"assets/assets/images/widget_images/svg_icons/user.svg": "b3873d792696c1af7e29acf53df48c80",
"assets/assets/images/widget_images/svg_icons/users.svg": "98922f29611db0df88d90a28fa5d227b",
"assets/assets/images/widget_images/svg_icons/withdrawal.svg": "98505dd968035a0bbd28584ead56231b",
"assets/FontManifest.json": "1b12ebf3ddb5524ebf43a0b37b5783fb",
"assets/fonts/Inter/Inter-Black.ttf": "118c5868c7cc1370fcf5a1fc2f569883",
"assets/fonts/Inter/Inter-Bold.ttf": "ba74cc325d5f67d0efbeda51616352db",
"assets/fonts/Inter/Inter-ExtraBold.ttf": "72ac147c98056996b2a31e95a56d6e66",
"assets/fonts/Inter/Inter-ExtraLight.ttf": "7a177fa21fece72dfaa5639d8f1c114a",
"assets/fonts/Inter/Inter-Light.ttf": "a3fe4e0f9fdf3119c62a34b1937640dd",
"assets/fonts/Inter/Inter-Medium.ttf": "cad1054327a25f42f2447d1829596bfe",
"assets/fonts/Inter/Inter-Regular.ttf": "ea5879884a95551632e9eb1bba5b2128",
"assets/fonts/Inter/Inter-SemiBold.ttf": "465266b2b986e33ef7e395f4df87b300",
"assets/fonts/Inter/Inter-Thin.ttf": "4558ff85abeab91af24c86aab81509a7",
"assets/fonts/MaterialIcons-Regular.otf": "82352d7d9235bcb48b031901f244868c",
"assets/NOTICES": "72158a191e37851ac7f44ca174717d23",
"assets/packages/country_flags/res/si/ac.si": "084b17449dd0ba76474f133039ee68d3",
"assets/packages/country_flags/res/si/ad.si": "c3ccb8e3cf8b3ce384280c687c94ed53",
"assets/packages/country_flags/res/si/ae.si": "600a0ce358d82ca58155a6298524084f",
"assets/packages/country_flags/res/si/af.si": "9fb0d66778b5afe46c5750f6b2de0a06",
"assets/packages/country_flags/res/si/ag.si": "f2607a0fcfd1aeecb45e1ea7d17979a0",
"assets/packages/country_flags/res/si/ai.si": "98108de6fc34688b9281b6040f855730",
"assets/packages/country_flags/res/si/al.si": "3a10d259f602c6832ed5316403f6fe91",
"assets/packages/country_flags/res/si/am.si": "f1c0decc96d76ecce7dda29e1b0a3048",
"assets/packages/country_flags/res/si/ao.si": "042c2a03c013acf928449dbaf2a4affe",
"assets/packages/country_flags/res/si/aq.si": "e15ec1a740dfd94250faaf3a04c3e009",
"assets/packages/country_flags/res/si/ar.si": "4ce98d701be0d5607ec3f0d62e5c7ff8",
"assets/packages/country_flags/res/si/as.si": "f12705f23ac102cc4fa8e85c3a780040",
"assets/packages/country_flags/res/si/at.si": "da9709351758847fbf187e9947fd44a5",
"assets/packages/country_flags/res/si/au.si": "93810e1a767ca77d78fa8d70ef89878a",
"assets/packages/country_flags/res/si/aw.si": "bac854c7bbf50dd71fc643f9197f4587",
"assets/packages/country_flags/res/si/ax.si": "a456e36511e13498fa3d610a026d79b8",
"assets/packages/country_flags/res/si/az.si": "203fdb6be0df02e0b86e1ab468a84588",
"assets/packages/country_flags/res/si/ba.si": "6719180c7b4f5d76a1c41fd76668cc69",
"assets/packages/country_flags/res/si/bb.si": "a0f7ccd01c2e5eee48607b53d0791941",
"assets/packages/country_flags/res/si/bd.si": "18bcbe7c5cd7ef99faf8e581dcf6f2db",
"assets/packages/country_flags/res/si/be.si": "6d9dd724fd5dd06b3cff71955bf03728",
"assets/packages/country_flags/res/si/bf.si": "36c828d75ffb1b1ee0c074f08dbd162e",
"assets/packages/country_flags/res/si/bg.si": "75bcf4b187601813fcf6008da5ef3625",
"assets/packages/country_flags/res/si/bh.si": "637d8c9177fdc8bf98d2afb4de3a3cbe",
"assets/packages/country_flags/res/si/bi.si": "4e22a5fa7d3657998c6424ee89ba328f",
"assets/packages/country_flags/res/si/bj.si": "e356b737969b4d0413d0d17781f5476f",
"assets/packages/country_flags/res/si/bl.si": "b319560213233391af1170881595344f",
"assets/packages/country_flags/res/si/bm.si": "2c1effe65d4c9c6ea846536f9ebcac93",
"assets/packages/country_flags/res/si/bn.si": "1334a282f886a35989ab2d1fee8b3acc",
"assets/packages/country_flags/res/si/bo.si": "1491a562f1ee0f5fdf512a72821dc3b1",
"assets/packages/country_flags/res/si/bq.si": "130b5b1f64baa8e002dc668b0d3d589f",
"assets/packages/country_flags/res/si/br.si": "dc32cd1c578da0b7106bd15a74434692",
"assets/packages/country_flags/res/si/bs.si": "5818730530c519e134452e41830a7d4b",
"assets/packages/country_flags/res/si/bt.si": "9b9f54fdaeb57d27628dd7318c23d632",
"assets/packages/country_flags/res/si/bv.si": "d2e12ff6011d4fc76d0044e61abbd8a1",
"assets/packages/country_flags/res/si/bw.si": "50b6724787e9b206d8998f747748f133",
"assets/packages/country_flags/res/si/by.si": "045e4e447111a76bb834bd9e969756b4",
"assets/packages/country_flags/res/si/bz.si": "3fad74bf2e5948e1556c8048e65e084e",
"assets/packages/country_flags/res/si/ca.si": "a911aefa8694f795f4066047492134be",
"assets/packages/country_flags/res/si/cc.si": "831df80000b0c6d12f0c37f696a11e31",
"assets/packages/country_flags/res/si/cd.si": "092862ef3f988f301bf81d937d0b2251",
"assets/packages/country_flags/res/si/cefta.si": "4a619e7166e3a91fd3333a0aa9a7f212",
"assets/packages/country_flags/res/si/cf.si": "00cce9e9924e59417fd640f22ff3c068",
"assets/packages/country_flags/res/si/cg.si": "a9df20410076c50e9abbd11b324712c3",
"assets/packages/country_flags/res/si/ch.si": "25b5af40c1ed5254d8a5c9286a235a78",
"assets/packages/country_flags/res/si/ci.si": "2dd6886cd9b611e8301f347233f275db",
"assets/packages/country_flags/res/si/ck.si": "30d75fc50470f00d7fc590c058b7a4c1",
"assets/packages/country_flags/res/si/cl.si": "1765b8d051900505b51ca7149756b62e",
"assets/packages/country_flags/res/si/cm.si": "d89b50b2a1e7c5814a53894ddf6842f6",
"assets/packages/country_flags/res/si/cn.si": "a629d6ea2863bc2e2783ed86427fccdf",
"assets/packages/country_flags/res/si/co.si": "471a020ee0695a4be6867c76e3e4fcdf",
"assets/packages/country_flags/res/si/cp.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/cr.si": "7385af5d3c967dad1c62027ece383dd6",
"assets/packages/country_flags/res/si/cu.si": "b561ce782460b38c99795d3891be4bd8",
"assets/packages/country_flags/res/si/cv.si": "1d61ed1ebf59c2a571f54da09340b52b",
"assets/packages/country_flags/res/si/cw.si": "8c2327f9686e6183f85b4141294f7944",
"assets/packages/country_flags/res/si/cx.si": "8d7a59ff653f34ab3323c39c5c5b2f75",
"assets/packages/country_flags/res/si/cy.si": "f4f95412e75e3e82b62b140f1fb4d327",
"assets/packages/country_flags/res/si/cz.si": "722387eee039fb858312120170af2ba7",
"assets/packages/country_flags/res/si/de.si": "aaabd585b21d0960b60d05acf4c54cd3",
"assets/packages/country_flags/res/si/dg.si": "3469f709b852fa25f3d735d4e7ee88a2",
"assets/packages/country_flags/res/si/dj.si": "c39ebb82ae2414d5b42b0c78d7db1626",
"assets/packages/country_flags/res/si/dk.si": "23b9112d01b91326804b173427d0a991",
"assets/packages/country_flags/res/si/dm.si": "114b039b7de692af992aa75bdfd324d9",
"assets/packages/country_flags/res/si/do.si": "0c12349ea290f3e7d6bd3c7eba8ec556",
"assets/packages/country_flags/res/si/dz.si": "74f32a3036da03823454cf8c2fbcc22f",
"assets/packages/country_flags/res/si/ea.si": "c59363bf0d9a595df07cfe238f9cc16a",
"assets/packages/country_flags/res/si/ec.si": "87d4beb1830c8746d02bd3eb81daa1cf",
"assets/packages/country_flags/res/si/ee.si": "d1d0e6c483ec14291ccafc69c4390f07",
"assets/packages/country_flags/res/si/eg.si": "eb6351aaa487d5e422ecd8f1160ada0d",
"assets/packages/country_flags/res/si/eh.si": "99373a71bd21ee4d5ce37dd840fa8bc5",
"assets/packages/country_flags/res/si/er.si": "1f32851695ad06a33b607cbfe96cbe5c",
"assets/packages/country_flags/res/si/es-ct.si": "9d497fc098e8ac8eb94576ca2b72a65a",
"assets/packages/country_flags/res/si/es-ga.si": "c128cec2feffaff7aab7940dadcd9ccd",
"assets/packages/country_flags/res/si/es.si": "c59363bf0d9a595df07cfe238f9cc16a",
"assets/packages/country_flags/res/si/et.si": "6020d43892ed1096172d0d01a00afe89",
"assets/packages/country_flags/res/si/eu.si": "0c7acf5338eb131940e6a2d53022fda7",
"assets/packages/country_flags/res/si/fi.si": "6ed37987c4dee7606f35b1f3ef2f4352",
"assets/packages/country_flags/res/si/fj.si": "5315abdde8d2a5274a621a7d1fdb92a6",
"assets/packages/country_flags/res/si/fk.si": "bcdc2242f7af2a72255f8d89d2642fe8",
"assets/packages/country_flags/res/si/fm.si": "d195abb2e8d6961f6ffa0da23d8b2813",
"assets/packages/country_flags/res/si/fo.si": "c074164f5875cc2ac648caa3461a4ffa",
"assets/packages/country_flags/res/si/fr.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/ga.si": "863042bec1c7781b8245d2fec2961835",
"assets/packages/country_flags/res/si/gb-eng.si": "c23da032fa2a18ca5390c2cab903ac80",
"assets/packages/country_flags/res/si/gb-nir.si": "70756040e8747ea10547485c1b5493dd",
"assets/packages/country_flags/res/si/gb-sct.si": "c1e2452023ede8ca68306f9360bec03f",
"assets/packages/country_flags/res/si/gb-wls.si": "bb7216967d97426e1d684b2745118f89",
"assets/packages/country_flags/res/si/gb.si": "b875cc97c8e2a1a41fd3ccbbdb63d291",
"assets/packages/country_flags/res/si/gd.si": "2bd89cc35d9a35aa6b5c7dfa8888e769",
"assets/packages/country_flags/res/si/ge.si": "6f700846562325e1e647946a9b7e26f6",
"assets/packages/country_flags/res/si/gf.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/gg.si": "57b684be8b0e0fa86e1dae5100f3c0ee",
"assets/packages/country_flags/res/si/gh.si": "21e46cb3743f96b4e47de0c0b277c604",
"assets/packages/country_flags/res/si/gi.si": "1d4b7516dbef91dd53a3223786433468",
"assets/packages/country_flags/res/si/gl.si": "f447d0f9f9e95027def4b4a333f59393",
"assets/packages/country_flags/res/si/gm.si": "b764f5bed08b62f0c908d224b61c62ce",
"assets/packages/country_flags/res/si/gn.si": "ebb9409ab8449de9d040549ffcef1321",
"assets/packages/country_flags/res/si/gp.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/gq.si": "e8e087ae91048f042fa212b5f79a496c",
"assets/packages/country_flags/res/si/gr.si": "a7ffe39d3dbd0f7e2d7cf03b38ebce8b",
"assets/packages/country_flags/res/si/gs.si": "d6e2a1be23c5e70fced629d467e0a1f7",
"assets/packages/country_flags/res/si/gt.si": "2841eca17a032575b20e97e3c4c0977e",
"assets/packages/country_flags/res/si/gu.si": "f47c5abf0b2dd4b8b717e87c82e1f328",
"assets/packages/country_flags/res/si/gw.si": "9c6f62e2963f012b571dad989416a1f3",
"assets/packages/country_flags/res/si/gy.si": "6373d2b94878202fd94563aeea4fd8ca",
"assets/packages/country_flags/res/si/hk.si": "cdc28623f40113eb4227c9ed796b6201",
"assets/packages/country_flags/res/si/hm.si": "93810e1a767ca77d78fa8d70ef89878a",
"assets/packages/country_flags/res/si/hn.si": "bf1d541bc8c0b4826c3cf7f2d36e1b87",
"assets/packages/country_flags/res/si/hr.si": "dc0efaf40fb58a21f52fd9a86c7ddfdc",
"assets/packages/country_flags/res/si/ht.si": "2f82778ff6d4910a677170a08545bfd6",
"assets/packages/country_flags/res/si/hu.si": "379f70d867e53920ef1105ae9d3dc5e1",
"assets/packages/country_flags/res/si/ic.si": "5459bbd72389b2300c7da170cd528f23",
"assets/packages/country_flags/res/si/id.si": "9cf3c91fee39a1ff1d93cbbe385d7bbf",
"assets/packages/country_flags/res/si/ie.si": "58082f0739794c2562fbd21b9700a0a9",
"assets/packages/country_flags/res/si/il.si": "5926479ae8ffa09647b9c20feceb9415",
"assets/packages/country_flags/res/si/im.si": "3bca9cb89673cd2c1837c69f72038bde",
"assets/packages/country_flags/res/si/in.si": "335a5837f0d2b45527db4e60087b4221",
"assets/packages/country_flags/res/si/io.si": "3469f709b852fa25f3d735d4e7ee88a2",
"assets/packages/country_flags/res/si/iq.si": "a0be6279c1905893dcbcbe0c7ce44302",
"assets/packages/country_flags/res/si/ir.si": "84eb55b574dd390d8fc86b185d182578",
"assets/packages/country_flags/res/si/is.si": "6a75ef472e3b3674cb992a6c1a2d8656",
"assets/packages/country_flags/res/si/it.si": "c472c6bc7844cc6633d4e41d139b282c",
"assets/packages/country_flags/res/si/je.si": "5fb5c37d3e7469ad537882debd8c4f33",
"assets/packages/country_flags/res/si/jm.si": "db4e387e95c824cefb80b16ae8f8af9f",
"assets/packages/country_flags/res/si/jo.si": "3c4f0683e2fe5e5d9b1424a5865c1e59",
"assets/packages/country_flags/res/si/jp.si": "ee22ac07312690001d82c27ed0fab0a8",
"assets/packages/country_flags/res/si/ke.si": "87ce4c55414a8c5d29f23ca16310a01c",
"assets/packages/country_flags/res/si/kg.si": "1f1f0daac400da3f36e873982f002844",
"assets/packages/country_flags/res/si/kh.si": "711d8494963708be2a01a1dfc5a002db",
"assets/packages/country_flags/res/si/ki.si": "80c4adc8b03b18055be571a612fa3f79",
"assets/packages/country_flags/res/si/km.si": "6cc50d7456a351984bae778298741591",
"assets/packages/country_flags/res/si/kn.si": "cd16cb0ce86ecb131422414a132352bb",
"assets/packages/country_flags/res/si/kp.si": "863f41ba80f1b3f9c794aaeafafb02d6",
"assets/packages/country_flags/res/si/kr.si": "0fc0217454ce0fac5d5b0ed0e19051ce",
"assets/packages/country_flags/res/si/kw.si": "fae7c5f1138fcb68b76b6bf1ecb5f422",
"assets/packages/country_flags/res/si/ky.si": "498424ad28f6c9e005ae14e8d66c3e2f",
"assets/packages/country_flags/res/si/kz.si": "f5aad35a9ce49a2a17f165d4761d8ace",
"assets/packages/country_flags/res/si/la.si": "161dccf57b198768b6c95fd585966156",
"assets/packages/country_flags/res/si/lb.si": "d2268cc1967d63699bb1ff2a87264c75",
"assets/packages/country_flags/res/si/lc.si": "981c9cb18294152ac0423aa64039f6e0",
"assets/packages/country_flags/res/si/li.si": "08d65db7ba158c62f8b70240985fbbe9",
"assets/packages/country_flags/res/si/lk.si": "c8f0c394d54b1618603d89307e6cd127",
"assets/packages/country_flags/res/si/lr.si": "8ea704b8b395abcb8dbd13a7fb738b3e",
"assets/packages/country_flags/res/si/ls.si": "f469f1632ad300b4fb00db8328f9b844",
"assets/packages/country_flags/res/si/lt.si": "8ef10e2712fa997ca06742fc1d79c095",
"assets/packages/country_flags/res/si/lu.si": "0ac3af11df6af8b90ca8f8078902fc9a",
"assets/packages/country_flags/res/si/lv.si": "d61111f2dcbc8b2c84e644f7288b1fd7",
"assets/packages/country_flags/res/si/ly.si": "b99bf6af3ded37ca4b35c612bfe98721",
"assets/packages/country_flags/res/si/ma.si": "9ced8447a0a9b2e720d870bc5aef87cf",
"assets/packages/country_flags/res/si/mc.si": "0cb03fed360c4c1401b0e9cff5dea505",
"assets/packages/country_flags/res/si/md.si": "074b41437a23811d27d4db98bedd56d8",
"assets/packages/country_flags/res/si/me.si": "d87206186e9601dcfabdd0d38b655899",
"assets/packages/country_flags/res/si/mf.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/mg.si": "f6406a9d332acb29115b31235c49c920",
"assets/packages/country_flags/res/si/mh.si": "88c8196c37481de5021237e01ccb95a1",
"assets/packages/country_flags/res/si/mk.si": "0aee6cc90fb321101c9d4afd923c2d85",
"assets/packages/country_flags/res/si/ml.si": "e583b41ed5e4f9508970265999bf47bf",
"assets/packages/country_flags/res/si/mm.si": "3ab23c7fcc44e249de75e6019af32611",
"assets/packages/country_flags/res/si/mn.si": "d7d59010e2822958f8390d72bfbf0072",
"assets/packages/country_flags/res/si/mo.si": "4a369319962984183cfed7f0bf4d60a5",
"assets/packages/country_flags/res/si/mp.si": "48f591d6c4a1e7aab511bcc750536836",
"assets/packages/country_flags/res/si/mq.si": "b319560213233391af1170881595344f",
"assets/packages/country_flags/res/si/mr.si": "73d5e7f3158beeb1e09e294cc2cc3b79",
"assets/packages/country_flags/res/si/ms.si": "e04ef3545afb3927de3aff13640ff6b9",
"assets/packages/country_flags/res/si/mt.si": "2c7e94cc8b51a7ce1c1958a00f880398",
"assets/packages/country_flags/res/si/mu.si": "9f4070ad133e7380edb48cb11cffaef1",
"assets/packages/country_flags/res/si/mv.si": "47d6de70a92bb16bc0284187d12dfb47",
"assets/packages/country_flags/res/si/mw.si": "529e2edb7b4f71261a4d8c52de450f5d",
"assets/packages/country_flags/res/si/mx.si": "add64001e4e654f95a36c24e5b212b80",
"assets/packages/country_flags/res/si/my.si": "6487d3c60a6fb74711c8bf732ef9aaea",
"assets/packages/country_flags/res/si/mz.si": "65389bae62f6de08c93ff93fe61e7b24",
"assets/packages/country_flags/res/si/na.si": "d49f748db27e5d6f63293f41c2e8361e",
"assets/packages/country_flags/res/si/nc.si": "8760c0e60c7ab868ea1577de40a8dd04",
"assets/packages/country_flags/res/si/ne.si": "5323700b3b0dc68916ffe048c4afc2b1",
"assets/packages/country_flags/res/si/nf.si": "1473b829023248dbbd77f49b9e6e5ede",
"assets/packages/country_flags/res/si/ng.si": "d2764e808010a6d2389cfc1e83e3b710",
"assets/packages/country_flags/res/si/ni.si": "8af49cf35b72204052de6fab8322afc8",
"assets/packages/country_flags/res/si/nl.si": "130b5b1f64baa8e002dc668b0d3d589f",
"assets/packages/country_flags/res/si/no.si": "6b6efedb50f0a7b05a9afe882924fe99",
"assets/packages/country_flags/res/si/np.si": "aac703fec2d68d1f05f0b368bcd05b5c",
"assets/packages/country_flags/res/si/nr.si": "7762af79a081de69557b7611eaf93bf9",
"assets/packages/country_flags/res/si/nu.si": "dac0a569e83a73006b8600fa1f1f8ac5",
"assets/packages/country_flags/res/si/nz.si": "95a431faf2077c36c314e060d3565e11",
"assets/packages/country_flags/res/si/om.si": "8d23e422f6191c117e764aa17c80e195",
"assets/packages/country_flags/res/si/pa.si": "3231c2af8957eddd456819783df37ef5",
"assets/packages/country_flags/res/si/pe.si": "978e662d337e34163ef3dbc28cf35f11",
"assets/packages/country_flags/res/si/pf.si": "29e59d85bfa9cc1ed50424098c4577b5",
"assets/packages/country_flags/res/si/pg.si": "51e824f62d970ad02c7afa9cc70330d8",
"assets/packages/country_flags/res/si/ph.si": "c8899c0eb2232931f49fa35de57f5d09",
"assets/packages/country_flags/res/si/pk.si": "afa64ff88820436b4ec66b1043a1ca7d",
"assets/packages/country_flags/res/si/pl.si": "034643869bc1b14ad2af44cc9aa24b9f",
"assets/packages/country_flags/res/si/pm.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/pn.si": "4df57b8f366ab9d559a134e25fa92201",
"assets/packages/country_flags/res/si/pr.si": "ccb19936defb882dea166d865f8ee5ff",
"assets/packages/country_flags/res/si/ps.si": "e91b4cc92cc8629f42c9d8fb11d028ba",
"assets/packages/country_flags/res/si/pt.si": "04c1755d12a50d7524a66124c8d725cc",
"assets/packages/country_flags/res/si/pw.si": "e658e7c8cdf0e27c4d9ccb084768f383",
"assets/packages/country_flags/res/si/py.si": "a05eb3d105fde5507180087464bc282b",
"assets/packages/country_flags/res/si/qa.si": "534abea02d79321b510b2a3fb040ffbc",
"assets/packages/country_flags/res/si/re.si": "b319560213233391af1170881595344f",
"assets/packages/country_flags/res/si/ro.si": "ec81c7e1014f2b8584ddd07d0fad9c43",
"assets/packages/country_flags/res/si/rs.si": "f231dce72ce3243a624eb723d200a63e",
"assets/packages/country_flags/res/si/ru.si": "677089233d82298520fd2b176f8003a8",
"assets/packages/country_flags/res/si/rw.si": "8b075359fc5a06224acf83d24b058752",
"assets/packages/country_flags/res/si/sa.si": "cf93fcbb04c97fac13136e80fd27ade9",
"assets/packages/country_flags/res/si/sb.si": "b6160f674954161619f0f57d4039e010",
"assets/packages/country_flags/res/si/sc.si": "65a3e456a8f0cfb400f7a4b354fd1839",
"assets/packages/country_flags/res/si/sd.si": "c6e5b30fafc73d2d84b45a10c6053568",
"assets/packages/country_flags/res/si/se.si": "64f75927796e3bcf418a7f1bce12cf39",
"assets/packages/country_flags/res/si/sg.si": "3e20b9387970793f6b3db62609820d4a",
"assets/packages/country_flags/res/si/sh.si": "084b17449dd0ba76474f133039ee68d3",
"assets/packages/country_flags/res/si/si.si": "11367d866b110a2971aae42dbc72b47f",
"assets/packages/country_flags/res/si/sj.si": "04dcac0249ab5999520c35c8e7f3ce38",
"assets/packages/country_flags/res/si/sk.si": "009a8dbaf2bc675683650d84bde81643",
"assets/packages/country_flags/res/si/sl.si": "a0d669d7821909f6b73d73ebd29e77e7",
"assets/packages/country_flags/res/si/sm.si": "e29d9a0493a72947dfc5e5668bcdcc30",
"assets/packages/country_flags/res/si/sn.si": "e283672331f67926294d3609b6317d82",
"assets/packages/country_flags/res/si/so.si": "ee4702222805ec60fe47cca5500fced8",
"assets/packages/country_flags/res/si/sr.si": "c996e0d2b46e4afc13b18a5abe492fe7",
"assets/packages/country_flags/res/si/ss.si": "cd22425520f63dac39be3dbfdb49465b",
"assets/packages/country_flags/res/si/st.si": "201fdb14910faacd6ce8c30c0a2c1bec",
"assets/packages/country_flags/res/si/sv.si": "912cc0a01ad6e839db6392ece5736b68",
"assets/packages/country_flags/res/si/sx.si": "424c70f52c10927bd40135e75d958e8b",
"assets/packages/country_flags/res/si/sy.si": "e510652843b486afcb5f160188b4514a",
"assets/packages/country_flags/res/si/sz.si": "780a7eb9794bd6cf85d59d42766e62b3",
"assets/packages/country_flags/res/si/ta.si": "084b17449dd0ba76474f133039ee68d3",
"assets/packages/country_flags/res/si/tc.si": "78d2718e865371288caf216fb083c8bd",
"assets/packages/country_flags/res/si/td.si": "7fe532f134f64c198cc8b4feb90efcaf",
"assets/packages/country_flags/res/si/tf.si": "2fdcf8c49f0b17d65aa2601d4b505cfa",
"assets/packages/country_flags/res/si/tg.si": "2a23d4dbc913968f6eb97dbb5454941e",
"assets/packages/country_flags/res/si/th.si": "1654e97b82bcdcdaade71e1bc3a5590d",
"assets/packages/country_flags/res/si/tj.si": "ff5523df78dbb97dbc212adec3b67a5e",
"assets/packages/country_flags/res/si/tk.si": "9fc0141c9928734e4229f05d2f2f68d4",
"assets/packages/country_flags/res/si/tl.si": "307e25e1507c3e76df867108079cb487",
"assets/packages/country_flags/res/si/tm.si": "61cac086e156158fe52394aadb734bd1",
"assets/packages/country_flags/res/si/tn.si": "d15a30567010db55d9a398ffde25694c",
"assets/packages/country_flags/res/si/to.si": "999f5edc1d7bd74937dab96f8d035368",
"assets/packages/country_flags/res/si/tr.si": "3bd279bd1f4c26e0ad0abed7fb744df3",
"assets/packages/country_flags/res/si/tt.si": "6550348a507c01feaf93fd191503ce72",
"assets/packages/country_flags/res/si/tv.si": "7e462e7d6fa8bdd967bf9e37b86d0906",
"assets/packages/country_flags/res/si/tw.si": "7bba519f0f26cca5417d8edb57bdef83",
"assets/packages/country_flags/res/si/tz.si": "643850342b81b7015ad57cddc9589a69",
"assets/packages/country_flags/res/si/ua.si": "aeb59a31627c7e9cb89c2c31c8b95d15",
"assets/packages/country_flags/res/si/ug.si": "b5368d2d0a873dd2ff8adc689c6c6b09",
"assets/packages/country_flags/res/si/um.si": "bec8665843b879da2d8ed65532da7e01",
"assets/packages/country_flags/res/si/un.si": "d3a2546a132b2e216aa17ffafaca8f57",
"assets/packages/country_flags/res/si/us.si": "a524142e2a2f7df4ee1b26a98f09a927",
"assets/packages/country_flags/res/si/uy.si": "8163529e4c65d4f7f97dad78c51918c7",
"assets/packages/country_flags/res/si/uz.si": "9141032bde5150e86cd2d159c4f31b72",
"assets/packages/country_flags/res/si/va.si": "c23d81f5e4e3acd336ce01d9ed561ee8",
"assets/packages/country_flags/res/si/vc.si": "a6d41b2c67d49f3f202dc920ad2f8c49",
"assets/packages/country_flags/res/si/ve.si": "e846876f7ec7ad396e58fb20e969a486",
"assets/packages/country_flags/res/si/vg.si": "de1ed29316c1d0f81af9946e35d254d7",
"assets/packages/country_flags/res/si/vi.si": "acbfd08b5cd096eac556c46efecb7926",
"assets/packages/country_flags/res/si/vn.si": "5e53b20018d53d957714d0211c237211",
"assets/packages/country_flags/res/si/vu.si": "54ccd51f720f6bb242f2256626a172b8",
"assets/packages/country_flags/res/si/wf.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/ws.si": "1644f5c199bfc4a5ee49d0907eb26efa",
"assets/packages/country_flags/res/si/xk.si": "967bec40d36ab8264262777667c5da33",
"assets/packages/country_flags/res/si/xx.si": "95362a356a59ae95c73b1a7a415abff6",
"assets/packages/country_flags/res/si/ye.si": "cc3bd4c5b25155d249015f88380a3023",
"assets/packages/country_flags/res/si/yt.si": "5ac3d76ce03f06c4463d135d4129c494",
"assets/packages/country_flags/res/si/za.si": "a66971379a3a65b274a702c82b3375d7",
"assets/packages/country_flags/res/si/zm.si": "ef4d9e8828b6609e41642a3fbb6541ec",
"assets/packages/country_flags/res/si/zw.si": "b32c711b08bfe7425d509407c48ee5ed",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/feather_icons/fonts/feather.ttf": "0d0d92d310cc68e53796bf15c36838c2",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/packages/iconly/fonts/IconlyBold.ttf": "6c73fc0a864250644f562a679591e0a4",
"assets/packages/iconly/fonts/IconlyBroken.ttf": "ae60c99d5cf25644beb25a87577bf6ca",
"assets/packages/iconly/fonts/IconlyLight.ttf": "baf08d3e753c86f1bdacb3535d66e2aa",
"assets/packages/iconsax_plus/fonts/IconsaxPlusBold.ttf": "805a1bab0f9865af92fcec87325e104c",
"assets/packages/iconsax_plus/fonts/IconsaxPlusBroken.ttf": "71d12baa6ddbb770fb8f6d92021403e4",
"assets/packages/iconsax_plus/fonts/IconsaxPlusLinear.ttf": "08f8e5eef32e66caa70d237eea7e3edb",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "c17d858d09fb1c596ef0adbf08872086",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "6d8ab59254a120b76bf53f167e809470",
"assets/packages/syntax_highlight/grammars/css.json": "085871a803ab85a39a4263a978a5dd46",
"assets/packages/syntax_highlight/grammars/dart.json": "b533a238112e4038ed399e53ca050e33",
"assets/packages/syntax_highlight/grammars/go.json": "3ff3c2b0a4d9ce5bf1fb77dc0074f8b8",
"assets/packages/syntax_highlight/grammars/html.json": "3b5a1a0bfffd56ded9d1792a2c3cd5fa",
"assets/packages/syntax_highlight/grammars/java.json": "7650e3188ef96c739532412c78bf2d19",
"assets/packages/syntax_highlight/grammars/javascript.json": "bcd128d423797ec17b3c722dc5faa8e7",
"assets/packages/syntax_highlight/grammars/json.json": "e608a2cc8f3ec86a5b4af4d7025ae43f",
"assets/packages/syntax_highlight/grammars/kotlin.json": "28b00e41cb639cc2d6468531a12f9232",
"assets/packages/syntax_highlight/grammars/python.json": "56cc793c1fb3dcb9fa6f09ea48ff7dc5",
"assets/packages/syntax_highlight/grammars/rust.json": "f54867905f52d2b7b8b4d23b6f80485e",
"assets/packages/syntax_highlight/grammars/serverpod_protocol.json": "cc9b878a8ae5032ca4073881e5889fd5",
"assets/packages/syntax_highlight/grammars/sql.json": "957a963dfa0e8d634766e08c80e00723",
"assets/packages/syntax_highlight/grammars/swift.json": "8bac845c316a520f0c3bffa1bb47c26e",
"assets/packages/syntax_highlight/grammars/typescript.json": "1d3d743cdc032cad9a50351a30f45489",
"assets/packages/syntax_highlight/grammars/yaml.json": "7c2dfa28161c688d8e09478a461f17bf",
"assets/packages/syntax_highlight/themes/dark_plus.json": "b212b7b630779cb4955e27a1c228bf71",
"assets/packages/syntax_highlight/themes/dark_vs.json": "2839d5be4f19e6b315582a36a6dcd1c3",
"assets/packages/syntax_highlight/themes/light_plus.json": "2a29ad892e1f54e93062fee13b3688c6",
"assets/packages/syntax_highlight/themes/light_vs.json": "8025deae1ca1a4d1cb803c7b9f8528a1",
"assets/packages/timezone/data/latest_all.tzf": "5e6af46f7fdd153c308fc6531ba69d03",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "c1cd83b22114e58adbbb0555fb2ba2e1",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "6343d8f02ae8119d9dea43f163c1423e",
"icons/Icon-192.png": "0f1a9e674b54cc9c55e4794e72d3c07e",
"icons/Icon-512.png": "5f8a05e594deb0708b3dd3aa3d6dcf9f",
"icons/Icon-maskable-192.png": "0f1a9e674b54cc9c55e4794e72d3c07e",
"icons/Icon-maskable-512.png": "5f8a05e594deb0708b3dd3aa3d6dcf9f",
"index.html": "167d1041ece8ac2eec2cd8d37f671831",
"/": "167d1041ece8ac2eec2cd8d37f671831",
"main.dart.js": "2fc74820ced9bffb5d5c80c94c698266",
"manifest.json": "6ece295c7a455911f6f41260217a523c",
"version.json": "6ee51181aa5e4a24a01e84ce0bb9088e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
