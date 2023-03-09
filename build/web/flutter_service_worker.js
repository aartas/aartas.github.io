'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "837e4273ffb325974562ce392f5aeb87",
"index.html": "774cc465d9247733f25ecee999d41b0f",
"/": "774cc465d9247733f25ecee999d41b0f",
"main.dart.js": "f71e7b4854e6e94dc79a656b6fe44174",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "31aae4ea1429d7e6d5529c1f14c1e808",
"assets/AssetManifest.json": "f24a20cb9132fec733888693893a6244",
"assets/NOTICES": "9c2fc08e4259a143f5883c021263283b",
"assets/FontManifest.json": "6009abf390121ee36b622b324adec502",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/Urbanist-Bold.ttf": "b8e3070d6661804e39c33607dd145d98",
"assets/fonts/TiemposHeadline-Semibold.otf": "36153d464bc7b82f3b22dbccc739624f",
"assets/fonts/TiemposHeadline-SemiboldItalic.otf": "deb13b5ec122fe0114b4b5d8075fd69f",
"assets/fonts/Urbanist-Regular.ttf": "6e56cc44e257e6a9bcaf1444acd2bb69",
"assets/fonts/Urbanist-LightItalic.ttf": "23a4fa5de53107507cfb742d4b8230df",
"assets/fonts/Urbanist-ExtraLightItalic.ttf": "b6660f5106efa80151d0706966776fcd",
"assets/fonts/Urbanist-ExtraBoldItalic.ttf": "3532b2ca68090c9b4b9a5fcca3c3a2b5",
"assets/fonts/Urbanist-Thin.ttf": "c115ee86c66020b2ad98915a80801267",
"assets/fonts/TiemposHeadline-Black.otf": "10b5d1cd21cf618ba6fc3f1a60180b49",
"assets/fonts/Urbanist-MediumItalic.ttf": "cf864afc2fa22f2ae66ad085341a2a05",
"assets/fonts/Urbanist-SemiBold.ttf": "da68f975679989622595236952a113ea",
"assets/fonts/TiemposHeadline-RegularItalic.otf": "25e70a4bc2b68715260d78953e8c000d",
"assets/fonts/TiemposHeadline-MediumItalic.otf": "bacf2244e25c6940974833e448fe8bd7",
"assets/fonts/Urbanist-Italic.ttf": "209af20a0d46b9e3fcff7d476684048e",
"assets/fonts/Urbanist-Black.ttf": "5a5b758c538e6b98aa534e23162ae802",
"assets/fonts/Urbanist-BlackItalic.ttf": "4c99b199f5075915e011f0fad927c20d",
"assets/fonts/TiemposHeadline-LightItalic.otf": "3d00ee401e19edb79040475986d929ec",
"assets/fonts/Urbanist-Light.ttf": "3973eeb60beb6c401c36fd563224b58d",
"assets/fonts/Urbanist-SemiBoldItalic.ttf": "cd9d41acc0ff496a0d6448c45d0102f7",
"assets/fonts/TiemposHeadline-Bold.otf": "81d7945d2c4688e806eb6df55f9a3635",
"assets/fonts/Urbanist-BoldItalic.ttf": "7533da758148fc3bfcc6f84830f5b775",
"assets/fonts/TiemposHeadline-Light.otf": "a770c664435204a1a6cd2ce3aa863ad8",
"assets/fonts/TiemposHeadline-BoldItalic.otf": "cdb5a3cc609a9705f43fbfb3da931b2d",
"assets/fonts/Urbanist-ExtraBold.ttf": "c4ba7fef70eac1d049e269fa2b2382c6",
"assets/fonts/Urbanist-Medium.ttf": "2e734d132734e066965e1851aeb98f36",
"assets/fonts/Urbanist-ExtraLight.ttf": "1f583b6d6e9819096b2132c74de09eb8",
"assets/fonts/Urbanist-ThinItalic.ttf": "219868e0a6a88817f677a379a08f4d5d",
"assets/fonts/TiemposHeadline-Regular.otf": "20e0ab086aa768c6ec00c49c1c9861ff",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/fonts/TiemposHeadline-BlackItalic.otf": "66b5dce345ca565a0b166ed163014ff3",
"assets/fonts/TiemposHeadline-Medium.otf": "fb07cba82e6fbc13ee1cf66673309906",
"assets/assets/App4.jpg": "52e7372fc387b7251fb4038c7b0f9b6b",
"assets/assets/App5.jpg": "b4caffea812ef75553fb9ec3c15440eb",
"assets/assets/play_logo.png": "301796339f585832cc6b050a908c03f9",
"assets/assets/App6.jpg": "bd162966e2e605ab2cae52b17145d322",
"assets/assets/Login.png": "2b9ceba384e21e025fb6cb727066db5d",
"assets/assets/App2.jpg": "eeeb9fd15435b823e549fe0885ac02f5",
"assets/assets/1.mp4": "dddaba0afbaaf63c08be0ccfc8fbbfaa",
"assets/assets/hero.jpg": "53f606fc811f0554017eb55a9cc26a0c",
"assets/assets/App3.jpg": "846eea74e52a9178878dee71896e9286",
"assets/assets/Group.jpg": "2d70760e720c929d7bf191076e9b3b90",
"assets/assets/DoctorGroup.jpg": "06c8330e26ec443f748013d954306721",
"assets/assets/apple_logo.png": "9082e6637a2dee6e6e993d7ae7ae4fec",
"assets/assets/App1.jpg": "6b7caff07709c7158de017f665df3b3b",
"assets/assets/2.mp4": "bc0295a524dfc193158a7898c0fa8de9",
"assets/assets/3.mp4": "8d7ebfdbcb0e185685fe6386688071b0",
"assets/assets/closertocare.png": "3da4b65095f51b4894beeeb91b4f6140",
"assets/assets/AartasLogo.png": "d409ede1c619ba8ba801d288b1f59aba",
"assets/assets/iphone_mockup.png": "1dbe975da10ed193766e14c867ab1ac1",
"assets/assets/medium.mp4": "86e6e5e6c2421f8b737e98697a04635c",
"assets/assets/Image4.jpg": "2f9c6a15d9cbc61e37979409e9915789",
"assets/assets/Image1.jpg": "33f8dd6254f37bc9d43f3c32fb9c8d73",
"assets/assets/aartas_video.mp4": "964c47f4cf4517c690a6bf279b4f1be1",
"assets/assets/Image2.jpg": "3d2a6576ced96774508fb8672ee39074",
"assets/assets/Image3.jpg": "03380fcf4e7e03ad67af8f882e047055",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
