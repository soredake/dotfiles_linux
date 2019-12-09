// save session every hour
// https://www.ghacks.net/2008/07/09/change-the-session-store-interval-in-firefox/
// https://www.reddit.com/r/firefox/comments/46qvfd/how_to_minimize_disk_writes_made_by_firefox_on/
// https://robinbobin.livejournal.com/4040841.html
// https://www.reddit.com/r/firefox/comments/545laq/firefox_is_eating_your_ssd_here_is_how_to_fix_it/
// https://www.servethehome.com/firefox-is-eating-your-ssd-here-is-how-to-fix-it/
// https://www.ghacks.net/2013/11/20/may-want-clear-firefox-cache-time-time/
user_pref("browser.sessionstore.interval", "3600000");

// resume previous session
// -11 always ask for session
user_pref("browser.startup.page", 3);
// performance, please
user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);

// https://wiki.mozilla.org/Platform/GFX/Quantum_Render
//user_pref("gfx.webrender.enabled", true);
user_pref("layers.acceleration.force-enabled", true);
//user_pref("gfx.webrender.all", true);

// https://www.ghacks.net/2019/03/01/firefox-67-automatically-unload-unused-tabs-to-improve-memory/
user_pref("browser.tabs.unloadOnLowMemory", true);

// seven newtab rows
user_pref("browser.newtabpage.activity-stream.topSitesRows", 7);

// https://www.ghacks.net/2019/05/24/firefox-69-userchrome-css-and-usercontent-css-disabled-by-default/
// https://www.reddit.com/r/firefox/comments/cyksh3/psa_firefox_v69_users_will_have_to_set_a_pref_to/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// https://www.ghacks.net/2019/06/02/firefox-69-to-use-process-priority-manager/
user_pref("dom.ipc.processPriorityManager.enabled", true);

// https://www.ghacks.net/2019/06/24/firefox-69-nightly-fission-can-now-be-enabled-for-testing/
//user_pref("fission.autostart", true);

// https://github.com/DNSCrypt/dnscrypt-proxy/issues/964
// disable Firefox's DNS-over-HTTPS (DoH) (FF60+)
// TRR = Trusted Recursive Resolver
// 0=off, 1=race (removed in FF69), 2=TRR first, 3=TRR only, 4=race for stats but always use native result (removed in FF69), 5=explicitly turned off
pref("network.trr.mode", 5);
pref("network.trr.bootstrapAddress", "");
pref("network.trr.uri", "");
pref("network.trr.custom_uri", "");

// signatures
//user_pref("xpinstall.signatures.required", false);

// autoscroll
user_pref("general.autoScroll", true);

// i don't want lose my tabs
// https://askubuntu.com/questions/10880/disable-ctrlq-in-firefox-without-keyconfig-extension
//user_pref("browser.showQuitWarning", true);
//user_pref("browser.tabs.warnOnClose", true);
//user_pref("browser.tabs.warnOnCloseOtherTabs", true);
//user_pref("browser.tabs.warnOnOpen", true);
//user_pref("browser.warnOnQuit", true);
//user_pref("browser.tabs.closeWindowWithLastTab", false);

// color management
// https://developer.mozilla.org/en-US/Firefox/Releases/3.5/ICC_color_correction_in_Firefox
//user_pref("gfx.color_management.mode", 1);
//user_pref("gfx.color_management.display_profile", "/home/bausch/sync/main/Documents/ULTRAWIDE.icm");
//user_pref("gfx.color_management.rendering_intent", 1);
//user_pref("gfx.color_management.enablev4", true);

// for dasht, https://sunaku.github.io/dasht/man/man1/dasht-server.1.html#firefox
//user_pref("capability.policy.policynames", "localfilelinks");
//user_pref("capability.policy.localfilelinks.sites", "http://127.0.0.1:54321");
//user_pref("capability.policy.localfilelinks.checkloaduri.enabled", "allAccess");

// set default volume
user_pref("media.default_volume", "0.7");
user_pref("media.volume_scale", "0.3");

//no url trim
//user_pref("browser.urlbar.trimURLs", false);

// hacker
user_pref("browser.aboutConfig.showWarning", false);

// http://kb.mozillazine.org/Clipboard.autocopy
user_pref("clipboard.autocopy", false);

// Более информативная страница показа ошибок в сертификатах сайтов.
user_pref("browser.xul.error_pages.expert_bad_cert", true);
// Запрещает сайтам установку соединений на критически важные порты, занятые I2P и Tor.
//user_pref("network.security.ports.banned", "4444,9050,9250,9251");
// https://github.com/The-OP/Fox/issues/8
// primary for dollchan script
//user_pref("dom.max_chrome_script_run_time", 500);
//user_pref("dom.max_script_run_time", 40);
// Активное использование Куклоскрипта вместе с недельными аптаймами может вызывать переполнение
// дефолтного пятимегабайтного session storage.
// https://github.com/SthephanShinkufag/Dollchan-Extension-Tools/issues/748
//user_pref("dom.storage.default_quota", 20240);

// https://www.ghacks.net/2017/01/21/firefox-53-search-in-large-select-fields/
user_pref("dom.forms.selectSearch", true);

// https://www.reddit.com/r/firefox/comments/c9ygw3/how_to_get_addons_to_work_on_mozilla_sites/
// https://github.com/gorhill/uMatrix/wiki/Privileged-Pages
user_pref("extensions.webextensions.restrictedDomains", "");
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);

// pac file
user_pref("network.proxy.autoconfig_url", "file:///home//bausch/sync/main/Documents/proxy.pac");