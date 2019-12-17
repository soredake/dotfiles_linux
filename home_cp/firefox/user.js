// save session every hour
// https://www.ghacks.net/2008/07/09/change-the-session-store-interval-in-firefox/
// https://www.reddit.com/r/firefox/comments/46qvfd/how_to_minimize_disk_writes_made_by_firefox_on/
// https://robinbobin.livejournal.com/4040841.html
// https://www.reddit.com/r/firefox/comments/545laq/firefox_is_eating_your_ssd_here_is_how_to_fix_it/
// https://www.servethehome.com/firefox-is-eating-your-ssd-here-is-how-to-fix-it/
// https://www.ghacks.net/2013/11/20/may-want-clear-firefox-cache-time-time/
//user_pref("browser.sessionstore.interval", 1800000);

// resume previous session
user_pref("browser.startup.page", 3);

// performance, please
// https://wiki.mozilla.org/Platform/GFX/Quantum_Render
// https://wiki.mozilla.org/Platform/GFX/WebRender_Where
//user_pref("gfx.webrender.all", true);
//user_pref("gfx.webrender.enabled", true);
user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);
user_pref("layers.acceleration.force-enabled", true);

// https://www.ghacks.net/2019/03/01/firefox-67-automatically-unload-unused-tabs-to-improve-memory/
user_pref("browser.tabs.unloadOnLowMemory", true);

// https://www.ghacks.net/2019/05/24/firefox-69-userchrome-css-and-usercontent-css-disabled-by-default/
// https://www.reddit.com/r/firefox/comments/cyksh3/psa_firefox_v69_users_will_have_to_set_a_pref_to/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// https://www.ghacks.net/2019/06/02/firefox-69-to-use-process-priority-manager/
// TODO: https://bugzilla.mozilla.org/show_bug.cgi?id=1522879
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

// some settings
user_pref("general.autoScroll", true);
user_pref("browser.sessionstore.warnOnQuit", true);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("clipboard.autocopy", false);
user_pref("browser.newtabpage.activity-stream.topSitesRows", 7);

// color management
// https://developer.mozilla.org/en-US/docs/Mozilla/Firefox/Releases/3.5/ICC_color_correction_in_Firefox
//user_pref("gfx.color_management.mode", 1);
//user_pref("gfx.color_management.display_profile", "/home/bausch/sync/main/Documents/ULTRAWIDE.icm");
//user_pref("gfx.color_management.rendering_intent", 1);
//user_pref("gfx.color_management.enablev4", true);

// set default volume
user_pref("media.default_volume", "0.7");
user_pref("media.volume_scale", "0.3");

// Более информативная страница показа ошибок в сертификатах сайтов.
//user_pref("browser.xul.error_pages.expert_bad_cert", true);

// https://www.ghacks.net/2017/01/21/firefox-53-search-in-large-select-fields/
// TODO: https://bugzilla.mozilla.org/show_bug.cgi?id=1332301
user_pref("dom.forms.selectSearch", true);

// https://www.reddit.com/r/firefox/comments/c9ygw3/how_to_get_addons_to_work_on_mozilla_sites/
// https://github.com/gorhill/uMatrix/wiki/Privileged-Pages
//user_pref("extensions.webextensions.restrictedDomains", "");
//user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);

// pac file
user_pref("network.proxy.autoconfig_url", "file:///home//bausch/sync/main/Documents/proxy.pac");

// disable logging sync errors
user_pref("services.sync.log.appender.file.logOnError", true);





// ssd settings
user_pref("browser.bookmarks.max_backups", 5);

// https://github.com/ghacksuserjs/ghacks-user.js/blob/master/user.js#L262-L268
/* 0350: disable Crash Reports ***/
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]
user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // [FF51+]
/* 0351: disable backlogged Crash Reports
 * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send backlogged crash reports  ***/
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // [FF58+]
// https://github.com/ghacksuserjs/ghacks-user.js/blob/master/user.js#L247-L253
/* 0340: disable Health Reports
 * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send technical... data ***/
user_pref("datareporting.healthreport.uploadEnabled", false);
/* 0341: disable new data submission, master kill switch [FF41+]
 * If disabled, no policy is shown or upload takes place, ever
 * [1] https://bugzilla.mozilla.org/1195552 ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
/* 0309: disable sending Flash crash reports ***/
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
/* 0310: disable sending the URL of the website where a plugin crashed ***/
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); // see [NOTE] above FF58+
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]
user_pref("toolkit.telemetry.hybridContent.enabled", false); // [FF59+]
/* 0331: disable Telemetry Coverage
 * [1] https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/ ***/
user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");