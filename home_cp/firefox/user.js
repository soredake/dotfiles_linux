// https://www.ghacks.net/2019/05/24/firefox-69-userchrome-css-and-usercontent-css-disabled-by-default/
// https://www.reddit.com/r/firefox/comments/cyksh3/psa_firefox_v69_users_will_have_to_set_a_pref_to/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// some settings
user_pref("browser.newtabpage.activity-stream.topSitesRows", 7);
// https://wiki.archlinux.org/index.php/Firefox/Tweaks#Enable_WebRender
// https://wiki.mozilla.org/Platform/GFX/Quantum_Render
// https://wiki.mozilla.org/Platform/GFX/WebRender_Where
user_pref("gfx.webrender.all", true);

// pac file
user_pref("network.proxy.autoconfig_url", "file:///home//mannyf/main/Documents/proxy.pac");