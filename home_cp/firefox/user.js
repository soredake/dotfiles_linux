// save session every 30 minutes
// https://www.ghacks.net/2008/07/09/change-the-session-store-interval-in-firefox/
// https://www.reddit.com/r/firefox/comments/46qvfd/how_to_minimize_disk_writes_made_by_firefox_on/
// https://robinbobin.livejournal.com/4040841.html
// https://www.reddit.com/r/firefox/comments/545laq/firefox_is_eating_your_ssd_here_is_how_to_fix_it/
// https://www.servethehome.com/firefox-is-eating-your-ssd-here-is-how-to-fix-it/
// https://www.ghacks.net/2013/11/20/may-want-clear-firefox-cache-time-time/
user_pref("browser.sessionstore.interval", 1800000);

// https://www.ghacks.net/2019/05/24/firefox-69-userchrome-css-and-usercontent-css-disabled-by-default/
// https://www.reddit.com/r/firefox/comments/cyksh3/psa_firefox_v69_users_will_have_to_set_a_pref_to/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// some settings
user_pref("browser.newtabpage.activity-stream.topSitesRows", 7);

// pac file
user_pref("network.proxy.autoconfig_url", "file:///home//mannyf/main/Documents/proxy.pac");