var glob = require("glob");
const execa = require("execa");

var fs = require("fs");
var path = require("path");
var os_1 = require("os");
var child_process_1 = require("child_process");
var escapeRegExp = require("escape-string-regexp");
var log = require("lighthouse-logger");
var newLineRegex = /\r?\n/;
/**
 * check for MacOS default app paths first to avoid waiting for the slow lsregister command
 */
function darwinFast() {
  var priorityOptions = [
    process.env.CHROME_PATH,
    process.env.LIGHTHOUSE_CHROMIUM_PATH,
    "/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary",
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
  ];
  for (
    var _i = 0, priorityOptions_1 = priorityOptions;
    _i < priorityOptions_1.length;
    _i++
  ) {
    var chromePath = priorityOptions_1[_i];
    if (chromePath && canAccess(chromePath)) return chromePath;
  }
  return darwin()[0];
}
exports.darwinFast = darwinFast;
function darwin() {
  var suffixes = [
    "/Contents/MacOS/Google Chrome Canary",
    "/Contents/MacOS/Google Chrome",
  ];
  var LSREGISTER =
    "/System/Library/Frameworks/CoreServices.framework" +
    "/Versions/A/Frameworks/LaunchServices.framework" +
    "/Versions/A/Support/lsregister";
  var installations = [];
  var customChromePath = resolveChromePath();
  if (customChromePath) {
    installations.push(customChromePath);
  }
  child_process_1
    .execSync(
      LSREGISTER +
        " -dump" +
        " | grep -i 'google chrome\\( canary\\)\\?\\.app'" +
        " | awk '{$1=\"\"; print $0}'"
    )
    .toString()
    .split(newLineRegex)
    .forEach(function (inst) {
      suffixes.forEach(function (suffix) {
        var execPath = path.join(
          inst.substring(0, inst.indexOf(".app") + 4).trim(),
          suffix
        );
        if (canAccess(execPath) && installations.indexOf(execPath) === -1) {
          installations.push(execPath);
        }
      });
    });
  // Retains one per line to maintain readability.
  // clang-format off
  var home = escapeRegExp(process.env.HOME || os_1.homedir());
  var priorities = [
    {
      regex: new RegExp("^" + home + "/Applications/.*Chrome\\.app"),
      weight: 50,
    },
    {
      regex: new RegExp("^" + home + "/Applications/.*Chrome Canary\\.app"),
      weight: 51,
    },
    { regex: /^\/Applications\/.*Chrome.app/, weight: 100 },
    { regex: /^\/Applications\/.*Chrome Canary.app/, weight: 101 },
    { regex: /^\/Volumes\/.*Chrome.app/, weight: -2 },
    { regex: /^\/Volumes\/.*Chrome Canary.app/, weight: -1 },
  ];
  if (process.env.LIGHTHOUSE_CHROMIUM_PATH) {
    priorities.unshift({
      regex: new RegExp(escapeRegExp(process.env.LIGHTHOUSE_CHROMIUM_PATH)),
      weight: 150,
    });
  }
  if (process.env.CHROME_PATH) {
    priorities.unshift({
      regex: new RegExp(escapeRegExp(process.env.CHROME_PATH)),
      weight: 151,
    });
  }
  // clang-format on
  return sort(installations, priorities);
}
exports.darwin = darwin;
function resolveChromePath() {
  if (canAccess(process.env.CHROME_PATH)) {
    return process.env.CHROME_PATH;
  }
  if (canAccess(process.env.LIGHTHOUSE_CHROMIUM_PATH)) {
    log.warn(
      "ChromeLauncher",
      "LIGHTHOUSE_CHROMIUM_PATH is deprecated, use CHROME_PATH env variable instead."
    );
    return process.env.LIGHTHOUSE_CHROMIUM_PATH;
  }
  return undefined;
}
/**
 * Look for linux executables in 3 ways
 * 1. Look into CHROME_PATH env variable
 * 2. Look into the directories where .desktop are saved on gnome based distro's
 * 3. Look for google-chrome-stable & google-chrome executables by using the which command
 */
function linux() {
  var installations = [];
  // 1. Look into CHROME_PATH env variable
  var customChromePath = resolveChromePath();
  if (customChromePath) {
    installations.push(customChromePath);
  }
  // 2. Look into the directories where .desktop are saved on gnome based distro's
  var desktopInstallationFolders = [
    path.join(os_1.homedir(), ".local/share/applications/"),
    "/usr/share/applications/",
  ];
  desktopInstallationFolders.forEach(function (folder) {
    installations = installations.concat(findChromeExecutables(folder));
  });
  // Look for google-chrome(-stable) & chromium(-browser) executables by using the which command
  var executables = [
    "google-chrome-stable",
    "google-chrome",
    "chromium-browser",
    "chromium",
  ];
  executables.forEach(function (executable) {
    try {
      var chromePath = child_process_1
        .execFileSync("which", [executable], { stdio: "pipe" })
        .toString()
        .split(newLineRegex)[0];
      if (canAccess(chromePath)) {
        installations.push(chromePath);
      }
    } catch (e) {
      // Not installed.
    }
  });
  if (!installations.length) {
    throw new Error();
  }
  var priorities = [
    { regex: /chrome-wrapper$/, weight: 51 },
    { regex: /google-chrome-stable$/, weight: 50 },
    { regex: /google-chrome$/, weight: 49 },
    { regex: /chromium-browser$/, weight: 48 },
    { regex: /chromium$/, weight: 47 },
  ];
  if (process.env.LIGHTHOUSE_CHROMIUM_PATH) {
    priorities.unshift({
      regex: new RegExp(escapeRegExp(process.env.LIGHTHOUSE_CHROMIUM_PATH)),
      weight: 100,
    });
  }
  if (process.env.CHROME_PATH) {
    priorities.unshift({
      regex: new RegExp(escapeRegExp(process.env.CHROME_PATH)),
      weight: 101,
    });
  }
  return sort(uniq(installations.filter(Boolean)), priorities);
}
exports.linux = linux;
function wsl() {
  // Manually populate the environment variables assuming it's the default config
  process.env.LOCALAPPDATA = process.env.PATH;
  process.env.PROGRAMFILES = "/mnt/c/Program Files";
  process.env["PROGRAMFILES(X86)"] = "/mnt/c/Program Files (x86)";
  return win32();
}
exports.wsl = wsl;
function win32() {
  var installations = [];
  var suffixes = [
    path.sep +
      "Google" +
      path.sep +
      "Chrome SxS" +
      path.sep +
      "Application" +
      path.sep +
      "chrome.exe",
    path.sep +
      "Google" +
      path.sep +
      "Chrome" +
      path.sep +
      "Application" +
      path.sep +
      "chrome.exe",
  ];
  var prefixes = [
    process.env.LOCALAPPDATA,
    process.env.PROGRAMFILES,
    process.env["PROGRAMFILES(X86)"],
  ].filter(Boolean);
  var customChromePath = resolveChromePath();
  if (customChromePath) {
    installations.push(customChromePath);
  }
  prefixes.forEach(function (prefix) {
    return suffixes.forEach(function (suffix) {
      var chromePath = path.join(prefix, suffix);
      if (canAccess(chromePath)) {
        installations.push(chromePath);
      }
    });
  });
  return installations;
}
exports.win32 = win32;
function sort(installations, priorities) {
  var defaultPriority = 10;
  return (
    installations
      // assign priorities
      .map(function (inst) {
        for (
          var _i = 0, priorities_1 = priorities;
          _i < priorities_1.length;
          _i++
        ) {
          var pair = priorities_1[_i];
          if (pair.regex.test(inst)) {
            return { path: inst, weight: pair.weight };
          }
        }
        return { path: inst, weight: defaultPriority };
      })
      // sort based on priorities
      .sort(function (a, b) {
        return b.weight - a.weight;
      })
      // remove priority flag
      .map(function (pair) {
        return pair.path;
      })
  );
}
function canAccess(file) {
  if (!file) {
    return false;
  }
  try {
    fs.accessSync(file);
    return true;
  } catch (e) {
    return false;
  }
}
function uniq(arr) {
  return Array.from(new Set(arr));
}
function findChromeExecutables(folder) {
  var argumentsRegex = /(^[^ ]+).*/; // Take everything up to the first space
  var chromeExecRegex = "^Exec=/.*/(google-chrome|chrome|chromium)-.*";
  var installations = [];
  if (canAccess(folder)) {
    // Output of the grep & print looks like:
    //    /opt/google/chrome/google-chrome --profile-directory
    //    /home/user/Downloads/chrome-linux/chrome-wrapper %U
    var execPaths = void 0;
    // Some systems do not support grep -R so fallback to -r.
    // See https://github.com/GoogleChrome/chrome-launcher/issues/46 for more context.
    try {
      execPaths = child_process_1.execSync(
        'grep -ER "' +
          chromeExecRegex +
          '" ' +
          folder +
          " | awk -F '=' '{print $2}'",
        { stdio: "pipe" }
      );
    } catch (e) {
      execPaths = child_process_1.execSync(
        'grep -Er "' +
          chromeExecRegex +
          '" ' +
          folder +
          " | awk -F '=' '{print $2}'",
        { stdio: "pipe" }
      );
    }
    execPaths = execPaths
      .toString()
      .split(newLineRegex)
      .map(function (execPath) {
        return execPath.replace(argumentsRegex, "$1");
      });
    execPaths.forEach(function (execPath) {
      return canAccess(execPath) && installations.push(execPath);
    });
  }
  return installations;
}

console.log(linux());

glob("lab*/*.marp.md", {}, function (err, files) {
  files.forEach((file) => {
    var destination = file.replace(".md", "");
    var cmd = `marp ${file} --allow-local-files --pdf -o ${destination}.pdf`;
    var result = execa.commandSync(cmd, {
      ...process.env,
      CHROME_PATH: linux()[0],
    });
    console.log(`[${result.failed ? "failed" : "success"}] ${result.command}`);
  });
});
