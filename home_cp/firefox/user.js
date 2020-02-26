// save session every 30 minutes
// https://www.ghacks.net/2008/07/09/change-the-session-store-interval-in-firefox/
// https://www.reddit.com/r/firefox/comments/46qvfd/how_to_minimize_disk_writes_made_by_firefox_on/
// https://robinbobin.livejournal.com/4040841.html
// https://www.reddit.com/r/firefox/comments/545laq/firefox_is_eating_your_ssd_here_is_how_to_fix_it/
// https://www.servethehome.com/firefox-is-eating-your-ssd-here-is-how-to-fix-it/
// https://www.ghacks.net/2013/11/20/may-want-clear-firefox-cache-time-time/
user_pref("browser.sessionstore.interval", 1800000);

// resume previous session
user_pref("browser.startup.page", 3);

// performance, please
// https://wiki.mozilla.org/Platform/GFX/Quantum_Render
// https://wiki.mozilla.org/Platform/GFX/WebRender_Where
//user_pref("gfx.webrender.all", true);
//user_pref("gfx.webrender.enabled", true);
user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);
//user_pref("layers.acceleration.force-enabled", true);
user_pref("dom.webgpu.enabled", true);
user_pref("gfx.webrender.compositor", true);

// https://www.ghacks.net/2019/05/24/firefox-69-userchrome-css-and-usercontent-css-disabled-by-default/
// https://www.reddit.com/r/firefox/comments/cyksh3/psa_firefox_v69_users_will_have_to_set_a_pref_to/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// some settings
user_pref("general.autoScroll", true);
user_pref("browser.sessionstore.warnOnQuit", true);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("clipboard.autocopy", false);
user_pref("browser.newtabpage.activity-stream.topSitesRows", 7);
user_pref("media.videocontrols.picture-in-picture.audio-toggle.enabled", true);

// https://www.ghacks.net/2017/01/21/firefox-53-search-in-large-select-fields/
// TODO: https://bugzilla.mozilla.org/show_bug.cgi?id=1332301
user_pref("dom.forms.selectSearch", true);

// pac file
user_pref("network.proxy.autoconfig_url", "file:///home//bausch/sync/main/Documents/proxy.pac");

// ssd settings
user_pref("browser.bookmarks.max_backups", 5);
// 300 mb "weave/logs" folder filled with error logs is bad
user_pref("services.sync.log.appender.file.logOnError", false);

// https://www.opennet.ru/opennews/art.shtml?num=52366
user_pref("dom.image-lazy-loading.enabled", true);