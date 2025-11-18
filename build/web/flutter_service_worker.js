'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "c1cd83b22114e58adbbb0555fb2ba2e1",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"main.dart.js": "18449240ae47096658bf36ec865bdd17",
"manifest.json": "64c399b3e389b55fb7cd049d549a6998",
"version.json": "1423a34d5e067e5baa5d333b2b9a8f56",
"icons/Icon-192.png": "0f1a9e674b54cc9c55e4794e72d3c07e",
"icons/Icon-512.png": "5f8a05e594deb0708b3dd3aa3d6dcf9f",
"icons/Icon-maskable-512.png": "5f8a05e594deb0708b3dd3aa3d6dcf9f",
"icons/Icon-maskable-192.png": "0f1a9e674b54cc9c55e4794e72d3c07e",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "df16647574bae1c699d84cb7e1eff5be",
"assets/AssetManifest.bin": "7e0aefad7c52ef2ac7a9bd0292c094cb",
"assets/assets/icons/ic_football.svg": "94ad5ed4f9fb882f7079c490247145c5",
"assets/assets/icons/ic_sign_out_alt.svg": "7ee1604a4dff559d6e08fa0e45968327",
"assets/assets/icons/ic_circle_outlined.svg": "ffe712e73311e12517db5829b9ae7bbd",
"assets/assets/icons/ic_sun.svg": "d3d0649930deede90cff449124d3cc3e",
"assets/assets/icons/ic_calendar_week.svg": "d1777b5287beaa7c3d707deb1ee290a8",
"assets/assets/icons/ic_eye.svg": "1741b7199b54d934806e812f6626e13d",
"assets/assets/icons/ic_search.svg": "fd8ca78e886ea36183af451317e6f8e8",
"assets/assets/icons/ic_menu_burger.svg": "54eac56f26baa053ccac3d009a5dfb5e",
"assets/assets/icons/ic_moon.svg": "9d87348b75347443f31de2b55ee4200c",
"assets/assets/icons/ic_language.svg": "47ed708779cff9f019303474671e9bc5",
"assets/assets/icons/ic_satellite_dish.svg": "d186148591251271ea32936680d8d078",
"assets/assets/icons/ic_user.svg": "d58d4d5a63e901fd55f3d9318dafb627",
"assets/assets/icons/ic_house.svg": "e7295ac108b0b9748deac7c42e492080",
"assets/assets/icons/ic_calendar.svg": "9cf7ab4e2d7b71c8bf9e6e6a8baf577f",
"assets/assets/icons/ic_calendar_day.svg": "b69b6aefbc7431713c4e99d6caac860f",
"assets/assets/icons/ic_bars.svg": "49914fc9cccb480852fab42820fa19ac",
"assets/assets/icons/ic_eye_slash.svg": "7549505b60694e9672b4481f7d89268c",
"assets/assets/icons/ic_angle_small_left.svg": "223298765cfe91c17de1da653371d1bc",
"assets/assets/icons/ic_angle_small_right.svg": "b29b878294a55d6e2b02439d068a57c8",
"assets/assets/icons/ic_wifi.svg": "0b4c1669875e155086c9652cc1edf309",
"assets/assets/icons/ic_chart_bar.svg": "93478309207ddbf405598db5dc3e6f40",
"assets/assets/icons/is_calendar_day.svg": "b69b6aefbc7431713c4e99d6caac860f",
"assets/assets/icons/ic_tile.svg": "3e0cb1cb09e8e0d3b77f068996bad895",
"assets/assets/icons/ic_list.svg": "d217467fbe855f82812401c8caf4c1e0",
"assets/assets/icons/ic_circle.svg": "877b1fbf1bdf7efb26301d1a4912be08",
"assets/assets/icons/ic_analyse.svg": "75c3bff7f8cda5208cd764ffe8daff6a",
"assets/assets/images/logo/logo_caption_light.png": "31feb66833cd9bc106682d341a593277",
"assets/assets/images/logo/logo_light_small.png": "8f65a332bafb4cfb978dd3b2df65402e",
"assets/assets/images/logo/logo_dark_small.png": "5de204d5191dc9e5b19c3c5b9d6b1595",
"assets/assets/images/logo/logo_caption_dark.png": "923372f32dd51f317c563fcf41df1812",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/NOTICES": "3e055517b7fa8631a5745139fa5b74ae",
"assets/AssetManifest.bin.json": "c34ca3bf5598fa50d735d6e4577b9bca",
"index.html": "2ca6d112dceacc5281bd006e2e7491bd",
"/": "2ca6d112dceacc5281bd006e2e7491bd",
"flutter_bootstrap.js": "f1522cbd721fe2525b5cf4cef1e9a986",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e"};
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
