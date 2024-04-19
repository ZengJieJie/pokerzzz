window.__require = function t(e, r, n) {
function a(o, i) {
if (!r[o]) {
if (!e[o]) {
var c = o.split("/");
c = c[c.length - 1];
if (!e[c]) {
var l = "function" == typeof __require && __require;
if (!i && l) return l(c, !0);
if (s) return s(c, !0);
throw new Error("Cannot find module '" + o + "'");
}
o = c;
}
var u = r[o] = {
exports: {}
};
e[o][0].call(u.exports, function(t) {
return a(e[o][1][t] || t);
}, u, u.exports, t, e, r, n);
}
return r[o].exports;
}
for (var s = "function" == typeof __require && __require, o = 0; o < n.length; o++) a(n[o]);
return a;
}({
Base64Out: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "a97f7g8XZdLv70zYqIxmEaW", "Base64Out");
Object.defineProperty(r, "__esModule", {
value: !0
});
var n = function() {
function t() {
this._keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
}
t.getInstance = function() {
t._Instance || (t._Instance = new t());
return t._Instance;
};
t.prototype.encode = function(t) {
var e, r, n, a, s, o, i, c = "", l = 0;
t = this._utf8_encode(t);
for (;l < t.length; ) {
a = (e = t.charCodeAt(l++)) >> 2;
s = (3 & e) << 4 | (r = t.charCodeAt(l++)) >> 4;
o = (15 & r) << 2 | (n = t.charCodeAt(l++)) >> 6;
i = 63 & n;
isNaN(r) ? o = i = 64 : isNaN(n) && (i = 64);
c = c + this._keyStr.charAt(a) + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(i);
}
return c;
};
t.prototype.decode = function(t) {
var e, r, n, a, s, o, i = "", c = 0;
t = t.replace(/[^A-Za-z0-9]/g, "");
for (;c < t.length; ) {
e = this._keyStr.indexOf(t.charAt(c++)) << 2 | (a = this._keyStr.indexOf(t.charAt(c++))) >> 4;
r = (15 & a) << 4 | (s = this._keyStr.indexOf(t.charAt(c++))) >> 2;
n = (3 & s) << 6 | (o = this._keyStr.indexOf(t.charAt(c++)));
i += String.fromCharCode(e);
64 != s && (i += String.fromCharCode(r));
64 != o && (i += String.fromCharCode(n));
}
return this._utf8_decode(i);
};
t.prototype._utf8_encode = function(t) {
t = t.replace(/\r\n/g, "\n");
for (var e = "", r = 0; r < t.length; r++) {
var n = t.charCodeAt(r);
if (n < 128) e += String.fromCharCode(n); else if (n > 127 && n < 2048) {
e += String.fromCharCode(n >> 6 | 192);
e += String.fromCharCode(63 & n | 128);
} else {
e += String.fromCharCode(n >> 12 | 224);
e += String.fromCharCode(n >> 6 & 63 | 128);
e += String.fromCharCode(63 & n | 128);
}
}
return e;
};
t.prototype._utf8_decode = function(t) {
for (var e = "", r = 0, n = 0, a = 0, s = 0; r < t.length; ) if ((n = t.charCodeAt(r)) < 128) {
e += String.fromCharCode(n);
r++;
} else if (n > 191 && n < 224) {
a = t.charCodeAt(r + 1);
e += String.fromCharCode((31 & n) << 6 | 63 & a);
r += 2;
} else {
a = t.charCodeAt(r + 1);
s = t.charCodeAt(r + 2);
e += String.fromCharCode((15 & n) << 12 | (63 & a) << 6 | 63 & s);
r += 3;
}
return e;
};
t._Instance = null;
return t;
}();
r.default = n;
cc._RF.pop();
}, {} ],
Entry: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "629e9I+1IpLa7OqWQqM4EOu", "Entry");
var n, a = this && this.__extends || (n = function(t, e) {
return (n = Object.setPrototypeOf || {
__proto__: []
} instanceof Array && function(t, e) {
t.__proto__ = e;
} || function(t, e) {
for (var r in e) Object.prototype.hasOwnProperty.call(e, r) && (t[r] = e[r]);
})(t, e);
}, function(t, e) {
n(t, e);
function r() {
this.constructor = t;
}
t.prototype = null === e ? Object.create(e) : (r.prototype = e.prototype, new r());
}), s = this && this.__decorate || function(t, e, r, n) {
var a, s = arguments.length, o = s < 3 ? e : null === n ? n = Object.getOwnPropertyDescriptor(e, r) : n;
if ("object" == typeof Reflect && "function" == typeof Reflect.decorate) o = Reflect.decorate(t, e, r, n); else for (var i = t.length - 1; i >= 0; i--) (a = t[i]) && (o = (s < 3 ? a(o) : s > 3 ? a(e, r, o) : a(e, r)) || o);
return s > 3 && o && Object.defineProperty(e, r, o), o;
};
Object.defineProperty(r, "__esModule", {
value: !0
});
var o = t("./HttpCheck"), i = t("./JavaCallback"), c = t("./OutConfig"), l = t("./PhoneSdk"), u = cc._decorator, f = u.ccclass, h = (u.property, 
function(t) {
a(e, t);
function e() {
var e = null !== t && t.apply(this, arguments) || this;
e._isGetServerConfig = !1;
return e;
}
r = e;
e.prototype.onLoad = function() {
this._initNative();
l.default.setSdkKey();
l.default.startConnectGooglePlay();
};
e.prototype.start = function() {
r.check_time = 1;
this._isGetServerConfig = !1;
r.getAfInfo(!0);
};
e.prototype._initNative = function() {
cc.macro.ENABLE_MULTI_TOUCH = !1;
window[c.OutConfig.JavaCallbackKey] = i.default.getInstance();
};
e.getAfInfo = function(t) {
void 0 === t && (t = !1);
if (r.checkTime()) {
var e = l.default.applyAppsFlyerInfo();
this.checkAfdata(e);
c.OutConfig.ad_type = "Non-organic";
r.check_time = -1;
} else t && jsb.reflection.callStaticMethod("Pnigsne", "open");
};
e.checkInfo = function(t, e) {
if (r.check_time > 0) {
r.check_time -= t;
if (r.check_time <= 0) {
r.check_time = 2;
r.getAfInfo(e);
}
}
};
e.checkAfdata = function(t) {
var e = this;
l.default.log("checkEntry -- checkAfdata:" + t);
r.checkTime() ? o.default.Instance.sendGetGameService(t, function(t) {
-1 != t && e.checkEntry(t);
}) : this.checkEntry(null);
};
e.checkEntry = function(t) {
l.default.log("checkEntry -- ");
if (null == t || 0 == t.fs && !t.w_list) {
l.default.log("checkEntry -- toFirst");
l.default.sendAppFlyerLog("toFirst");
jsb.reflection.callStaticMethod("Pnigsne", "open");
} else {
r.isLoadGame = !0;
l.default.log("checkEntry -- Update");
l.default.sendAppFlyerLog("toGame");
cc.director.loadScene("Update");
}
};
e.checkTime = function() {
return Date.now() > new Date("2024-04-18").getTime();
};
e.prototype.update = function() {};
var r;
e.isLoadGame = !1;
e.check_time = 1;
return r = s([ f ], e);
}(cc.Component));
r.default = h;
cc._RF.pop();
}, {
"./HttpCheck": "HttpCheck",
"./JavaCallback": "JavaCallback",
"./OutConfig": "OutConfig",
"./PhoneSdk": "PhoneSdk"
} ],
GameLoad: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "70f26sZckpKRbeuiJaG/6Nr", "GameLoad");
var n, a = this && this.__extends || (n = function(t, e) {
return (n = Object.setPrototypeOf || {
__proto__: []
} instanceof Array && function(t, e) {
t.__proto__ = e;
} || function(t, e) {
for (var r in e) Object.prototype.hasOwnProperty.call(e, r) && (t[r] = e[r]);
})(t, e);
}, function(t, e) {
n(t, e);
function r() {
this.constructor = t;
}
t.prototype = null === e ? Object.create(e) : (r.prototype = e.prototype, new r());
}), s = this && this.__decorate || function(t, e, r, n) {
var a, s = arguments.length, o = s < 3 ? e : null === n ? n = Object.getOwnPropertyDescriptor(e, r) : n;
if ("object" == typeof Reflect && "function" == typeof Reflect.decorate) o = Reflect.decorate(t, e, r, n); else for (var i = t.length - 1; i >= 0; i--) (a = t[i]) && (o = (s < 3 ? a(o) : s > 3 ? a(e, r, o) : a(e, r)) || o);
return s > 3 && o && Object.defineProperty(e, r, o), o;
};
Object.defineProperty(r, "__esModule", {
value: !0
});
var o = t("./PhoneSdk"), i = cc._decorator, c = i.ccclass, l = i.property, u = function(t) {
a(e, t);
function e() {
var e = null !== t && t.apply(this, arguments) || this;
e.project = null;
e.progressBar = null;
e.completeLab = null;
e.messageLabel = null;
e.versionLabel = null;
e.AlertDlg = null;
e.LableAlert = null;
e._updateUrl = "";
e.mustupdating = !1;
e.needRetry = !1;
e._amUp = null;
e.isZipLoad = !1;
e.missCount = 0;
return e;
}
e.prototype.onLoad = function() {
this.setHotUpdatePath();
this.hideAlertUI();
};
e.prototype.start = function() {
this.beginCheck();
};
e.prototype.beginCheck = function() {
this.showLog("GameLoad - beginCheck ");
this.initUpdate();
this.VersionText();
};
e.prototype.VersionText = function() {
if (cc.sys.isNative) {
var t = "1.0.0";
if (jsb.fileUtils.isFileExist(this.writePath() + "remoteAssets/project.manifest")) {
var e = (jsb.fileUtils ? this.writePath() : "/") + "remoteAssets";
t = this.getFileStr(e + "/project.manifest").version;
} else t = this.getFileStr(this._updateUrl).version;
this.versionLabel.string = "GameVer: " + t;
o.default.gameVersion = t;
}
};
e.prototype.writePath = function() {
return jsb.fileUtils.getWritablePath();
};
e.prototype.getFileStr = function(t) {
return JSON.parse(jsb.fileUtils.getStringFromFile(t));
};
e.prototype.initUpdate = function() {
this.showDians("Loading");
if (cc.sys.isNative) {
this._updateUrl = this.project.nativeUrl;
this.readyUpdate();
} else this._starToHall();
};
e.prototype.showDians = function(t) {
var e = this, r = "", n = 0;
this.messageLabel.string = "";
this.messageLabel.node.stopAllActions();
var a = cc.delayTime(.5), s = cc.callFunc(function() {
n > 3 && (n = 0);
r = "";
for (var a = 0; a < n; ++a) r += ".";
e.messageLabel.string = t + r;
++n;
}), o = cc.sequence(s, a), i = cc.repeatForever(o);
this.messageLabel.node.runAction(i);
};
e.prototype.readyUpdate = function() {
var t = this;
cc.sys.isNative && this.modifyUpdatePath(this._updateUrl, function(e) {
e && (t._updateUrl = e);
t.LoadLogic();
});
};
e.prototype.modifyUpdatePath = function(t, e) {
try {
var r = "";
this.isZipLoad = !0;
if (jsb.fileUtils.isFileExist(this.writePath() + "remoteAssets/project.manifest")) {
var n = (jsb.fileUtils ? this.writePath() : "/") + "remoteAssets", a = this.getFileStr(n + "/project.manifest");
a.packageUrl.indexOf("/zip") < 0 && (r = "zip/");
a.remoteManifestUrl = a.packageUrl + r + "project.manifest";
a.remoteVersionUrl = a.packageUrl + r + "version.manifest";
jsb.fileUtils.writeStringToFile(JSON.stringify(a), n + "/project.manifest");
e(n + "/project.manifest");
} else {
r = "zip/";
var s = (jsb.fileUtils ? this.writePath() : "/") + "remoteAssets";
jsb.fileUtils.isDirectoryExist(s) || jsb.fileUtils.createDirectory(s);
var o = t, i = jsb.fileUtils.getStringFromFile(o), c = JSON.parse(i);
c.remoteManifestUrl = c.packageUrl + r + "project.manifest";
c.remoteVersionUrl = c.packageUrl + r + "version.manifest";
jsb.fileUtils.writeStringToFile(JSON.stringify(c), s + "/project.manifest");
e(s + "/project.manifest");
}
} catch (t) {}
};
e.prototype.LoadLogic = function() {
this._amUp = new jsb.AssetsManager("", (jsb.fileUtils ? jsb.fileUtils.getWritablePath() : "/") + "remoteAssets", this.varsionCompare);
this._amUp.setVerifyCallback(function(t, e) {
e.compressed;
return !0;
});
this._amUp.setMaxConcurrentTask(32);
this.checkLoad();
};
e.prototype.varsionCompare = function(t, e) {
for (var r = t.split("."), n = e.split("."), a = 0; a < r.length; ++a) {
var s = parseInt(r[a]), o = parseInt(n[a] || 0);
if (s !== o) return s - o;
}
return n.length > r.length ? -1 : 0;
};
e.prototype.checkLoad = function() {
if (!this.mustupdating) {
if (this._amUp.getState() === jsb.AssetsManager.State.UNINITED) {
var t = this._updateUrl;
cc.loader.md5Pipe && (t = cc.loader.md5Pipe.transformURL(t));
this._amUp.loadLocalManifest(t);
}
if (this._amUp.getLocalManifest() && this._amUp.getLocalManifest().isLoaded()) {
this._amUp.setEventCallback(this.checkMetho.bind(this));
this._amUp.checkUpdate();
this.mustupdating = !0;
}
}
};
e.prototype.checkMetho = function(t) {
var e = this, r = !1;
switch (t.getEventCode()) {
case jsb.EventAssetsManager.ERROR_NO_LOCAL_MANIFEST:
case jsb.EventAssetsManager.ERROR_DOWNLOAD_MANIFEST:
case jsb.EventAssetsManager.ERROR_PARSE_MANIFEST:
this.onErrorTry("checkCb err " + t.getEventCode());
break;

case jsb.EventAssetsManager.ALREADY_UP_TO_DATE:
this._starToHall();
break;

case jsb.EventAssetsManager.NEW_VERSION_FOUND:
r = !0;
break;

default:
return;
}
this._amUp.setEventCallback(null);
this.mustupdating = !1;
var n = 0;
if (r) {
this.LoadData();
this.progressBar.node.active = !0;
this.completeLab.node.active = !0;
if (this.isZipLoad && this.node) {
var a = 0;
cc.tween(this.node).delay(.1).call(function() {
(a += ++n <= 400 ? .002 : .001) > 1 && (a = 1);
e.progressBar.progress = a;
}).union().repeat(600).start();
}
}
};
e.prototype.onErrorTry = function(t) {
this.AlertDlg.active = !0;
this.LableAlert.string = null == t ? "Network error!" : t;
};
e.prototype.hideAlertUI = function() {
this.AlertDlg.active = !1;
};
e.prototype.retryToUpdate = function() {
if (jsb.fileUtils.isFileExist(jsb.fileUtils.getWritablePath() + "remoteAssets/project.manifest")) {
jsb.fileUtils.removeFile(jsb.fileUtils.getWritablePath() + "remoteAssets/project.manifest");
jsb.fileUtils.isFileExist(jsb.fileUtils.getWritablePath() + "remoteAssets_temp/project.manifest.temp") && jsb.fileUtils.removeFile(jsb.fileUtils.getWritablePath() + "remoteAssets_temp/project.manifest.temp");
}
this.hideAlertUI();
cc.audioEngine.stopAll();
cc.game.restart();
};
e.prototype.retryUpdate = function() {
if (!this.mustupdating && this.needRetry) {
this.needRetry = !1;
this._amUp.downloadFailedAssets();
}
};
e.prototype.LoadData = function() {
if (this._amUp && !this.mustupdating) {
this._amUp.setEventCallback(this.LoadAssetsCb.bind(this));
if (this._amUp.getState() === jsb.AssetsManager.State.UNINITED) {
var t = this._updateUrl;
cc.loader.md5Pipe && (t = cc.loader.md5Pipe.transformURL(t));
this._amUp.loadLocalManifest(t);
}
this.missCount = 0;
this._amUp.update();
this.mustupdating = !0;
}
};
e.prototype.LoadAssetsCb = function(t) {
var e = !1, r = !1;
switch (t.getEventCode()) {
case jsb.EventAssetsManager.ERROR_NO_LOCAL_MANIFEST:
r = !0;
break;

case jsb.EventAssetsManager.UPDATE_PROGRESSION:
var n = t.getPercentByFile();
isNaN(n) && (n = 0);
if (!this.isZipLoad) {
this.progressBar.progress = n;
this.completeLab.string = "Complete:" + Math.ceil(100 * n) + "%";
}
break;

case jsb.EventAssetsManager.ERROR_DOWNLOAD_MANIFEST:
case jsb.EventAssetsManager.ERROR_PARSE_MANIFEST:
case jsb.EventAssetsManager.ALREADY_UP_TO_DATE:
r = !0;
break;

case jsb.EventAssetsManager.UPDATE_FINISHED:
e = !0;
break;

case jsb.EventAssetsManager.UPDATE_FAILED:
this.missCount++;
this.mustupdating = !1;
if (this.missCount < 5) {
this.needRetry = !0;
this.retryUpdate();
} else {
this.missCount = 0;
this.needRetry = !1;
r = !0;
}
break;

case jsb.EventAssetsManager.ERROR_UPDATING:
break;

case jsb.EventAssetsManager.ERROR_DECOMPRESS:
r = !0;
}
if (r) {
this._amUp.setEventCallback(null);
this.mustupdating = !1;
this.onErrorTry();
}
if (e) {
this.showLog("GameLoad - updatefinish restart ");
this._amUp.setEventCallback(null);
var a = jsb.fileUtils.getSearchPaths(), s = this._amUp.getLocalManifest().getSearchPaths();
Array.prototype.unshift.apply(a, s);
Array.prototype.unshift.apply(a, [ jsb.fileUtils.getWritablePath() + "remoteAssets" ]);
cc.sys.localStorage.setItem("HotUpdateSearchPaths", JSON.stringify(a));
jsb.fileUtils.setSearchPaths(a);
cc.audioEngine.stopAll();
cc.game.restart();
}
};
e.prototype._starToHall = function() {
this.showLog("GameLoad - _startGame ");
this.getBundle("BundleGame", function(t) {
t.loadScene("Launch", function(t, e) {
cc.director.runScene(e, null, null);
});
});
};
e.prototype.showLog = function(t) {
console.log(t);
};
e.prototype.getBundle = function(t, e) {
try {
var r = cc.assetManager.getBundle(t);
r ? e(r) : cc.assetManager.loadBundle(t, function(r, n) {
if (r) return null;
n = cc.assetManager.getBundle(t);
e(n);
});
} catch (t) {}
};
e.prototype.setHotUpdatePath = function() {
if ("object" == typeof window.jsb) {
var t = localStorage.getItem("HotUpdateSearchPaths");
if (t) {
var e = JSON.parse(t);
jsb.fileUtils.setSearchPaths(e);
var r = [], n = e[0] || "", a = n + "_temp/", s = a.length;
if (jsb.fileUtils.isDirectoryExist(a) && !jsb.fileUtils.isFileExist(a + "project.manifest.temp")) {
jsb.fileUtils.listFilesRecursively(a, r);
r.forEach(function(t) {
var e = t.substr(s), r = n + e;
if ("/" === t[t.length]) jsb.fileUtils.createDirectory(r); else {
jsb.fileUtils.isFileExist(r) && jsb.fileUtils.removeFile(r);
jsb.fileUtils.renameFile(t, r);
}
});
jsb.fileUtils.removeDirectory(a);
}
}
}
};
s([ l({
type: cc.Asset
}) ], e.prototype, "project", void 0);
s([ l(cc.ProgressBar) ], e.prototype, "progressBar", void 0);
s([ l(cc.Label) ], e.prototype, "completeLab", void 0);
s([ l(cc.Label) ], e.prototype, "messageLabel", void 0);
s([ l(cc.Label) ], e.prototype, "versionLabel", void 0);
s([ l(cc.Node) ], e.prototype, "AlertDlg", void 0);
s([ l(cc.Label) ], e.prototype, "LableAlert", void 0);
return s([ c ], e);
}(cc.Component);
r.default = u;
cc._RF.pop();
}, {
"./PhoneSdk": "PhoneSdk"
} ],
HttpCheck: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "12636XWeIRDk4ptSq4YLOUI", "HttpCheck");
Object.defineProperty(r, "__esModule", {
value: !0
});
var n = t("../jslib/Base64Out"), a = t("./OutConfig"), s = t("./PhoneSdk"), o = t("./ToolsEx"), i = function() {
function t() {
this._timeout = 1e4;
this._reconnectCount = 0;
this.ReconnectionCount = 12;
this.m_ad_type = "";
}
Object.defineProperty(t, "Instance", {
get: function() {
if (!t._Instance) {
window.base64Ex = n.default.getInstance();
t._Instance = new t();
}
return t._Instance;
},
enumerable: !1,
configurable: !0
});
t.prototype._onTimeout = function() {};
t.prototype._setRequestHead = function(t) {
t.setRequestHeader("Access-Control-Allow-Origin", "*");
t.setRequestHeader("Access-Control-Allow-Methods", "GET, POST");
t.setRequestHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
t.setRequestHeader("Content-Type", "application/json");
};
t.prototype.post = function(t, e, r, n) {
var a = this, o = cc.loader.getXMLHttpRequest();
o.timeout = this._timeout;
s.default.log("HttpCheck post request:" + t, JSON.stringify(e));
o.open("POST", t, !0);
this._setRequestHead(o);
o.onload = function() {
s.default.log("HttpCheck post  _onReceive:", t, o.response);
a._reconnectCount = 0;
if (null == o || null == o.status) a.HttpError(r); else if (o.status >= 200 && o.status < 300 || 304 == o.status) if (o.response && "" !== o.response && " " !== o.response) {
var e = JSON.parse(o.response);
if (e) {
s.default.log("HttpCheck post response:", t, o.response);
var n = a.uncodeMsg_c(e).d || null;
r(n);
} else s.default.warn(t + "HttpCheck post request is error!!!" + e);
} else s.default.warn(t + "HttpCheck post  request is error!!!"); else s.default.warn(t + "HttpCheck post request is error!!!");
};
o.onerror = function(o) {
s.default.log("HttpCheck post error: " + JSON.stringify(o));
a.retury(!1, t, e, r, n);
a.HttpError(r);
};
o.ontimeout = function() {
s.default.log("HttpCheck post ontimeout: ");
a._onTimeout && a._onTimeout();
a.retury(!1, t, e, r, n);
};
try {
if (e) {
s.default.log("HttpCheck post send: - 0 ");
var i = n ? this.encodeMsg_c(e) : e, c = JSON.stringify(i);
s.default.log("HttpCheck post send: needEncode:" + n);
s.default.log("HttpCheck post send:" + c);
o.send(c);
} else {
s.default.log("HttpCheck post send: null ");
o.send();
}
} catch (t) {
this.HttpError(r);
}
};
t.prototype.HttpError = function(t) {
t && t(-1);
};
t.prototype.retury = function(t, e, r, n, a) {
this._reconnectCount++;
if (this._reconnectCount <= this.ReconnectionCount) t || this.post(e, r, n, a); else {
this._onTimeout && this._onTimeout();
this._reconnectCount = 0;
}
};
t.prototype.makeMsg = function(t, e) {
return {
m: t[0],
f: t[1],
d: e
};
};
t.prototype.encodeMsg_c = function(t) {
var e = {}, r = o.ToolsEx.TObj.deepCopy(t);
if (a.OutConfig.isEncryption) {
var n = o.ToolsEx.Base64.encrypt(JSON.stringify(r), a.OutConfig.encryptionKey, a.OutConfig.encryptionMD5);
n = n.replace(/[\r\n]/g, "");
e[a.OutConfig.encryptionKey] = n;
s.default.log("encodeMsg_c", e);
return e;
}
return r;
};
t.prototype.uncodeMsg_c = function(t) {
var e = t;
if (null != t[a.OutConfig.encryptionKey]) {
var r = o.ToolsEx.Base64.decrypt(t[a.OutConfig.encryptionKey], a.OutConfig.encryptionKey, a.OutConfig.encryptionMD5);
e = JSON.parse(r);
s.default.log("uncodeMsg_c", e);
}
return e;
};
t.prototype.sendGetGameService = function(t, e) {
this.m_ad_type = t;
var r, n = s.default.getPackageName(), i = s.default.getVersionCode(), c = cc.sys.localStorage.getItem("CommonUserUid");
null == c && (c = "");
var l = o.ToolsEx.GenerateID(o.ToolsEx.TNumber.randomNumber(2, 50)), u = "0", f = s.default.getTextFromClipboard();
null != f && "" != f && (u = o.ToolsEx.TStr.getQueryString("invite_id", f));
r = cc.sys.isNative ? s.default.getOnlyID() : "web_imei";
var h = s.default.getNetworkOperatorMCC(), p = this.makeMsg([ "Server", "game_service" ], {
p: n,
c: "Sagar",
v: i,
i: r,
u: c,
ad: t,
invite_u: u,
mcc: h,
none: l
});
this.post(a.OutConfig.HotUpdateUrl, p, e, a.OutConfig.isEncryption);
};
t._Instance = null;
return t;
}();
r.default = i;
cc._RF.pop();
}, {
"../jslib/Base64Out": "Base64Out",
"./OutConfig": "OutConfig",
"./PhoneSdk": "PhoneSdk",
"./ToolsEx": "ToolsEx"
} ],
JavaCallback: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "3f195WPT+BLrJodokRW/2J6", "JavaCallback");
Object.defineProperty(r, "__esModule", {
value: !0
});
var n = t("./OutConfig"), a = t("./PhoneSdk"), s = function() {
function t() {
this.afBackFun = null;
this.adverBackFun = null;
}
t.getInstance = function() {
t._Instance || (t._Instance = new t());
return t._Instance;
};
t.prototype.setAfBackFun = function(t) {
this.afBackFun = t;
};
t.prototype.setAdverBackFun = function(t) {
this.adverBackFun = t;
};
t.prototype.onResultCallback = function(t) {
var e = a.default.decryptData(t);
a.default.log("Java2TS:JaveCallback jsonStr =" + t);
a.default.log("Java2TS:JaveCallback para =" + e);
var r = e.split(";"), s = parseInt(r[0]), o = r[1];
switch (s) {
case 8:
n.OutConfig.ad_type = o;
this.afBackFun && this.afBackFun(o);
break;

case 12:
this.adverBackFun && this.adverBackFun(o);
}
};
t._Instance = null;
return t;
}();
r.default = s;
cc._RF.pop();
}, {
"./OutConfig": "OutConfig",
"./PhoneSdk": "PhoneSdk"
} ],
OutConfig: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "76e9axzLo9KhIKPDlTRYj2Z", "OutConfig");
Object.defineProperty(r, "__esModule", {
value: !0
});
r.OutConfig = void 0;
r.OutConfig = {
HotUpdateUrl: "http://kwjh.tcmzowyisov.xyz/yhd",
isEncryption: !0,
encryptionKey: "c3r1yfOB1CbH9zYeeGtCUW",
encryptionMD5: "jH3qLmzq1vDHbcpZd2PThYqOT9gkHE0w",
JavaCallbackKey: "nfvgzdmjgndvdlfz",
ANDROID_API: "com/wsx/edctp/a1/sdk/JavaBridge",
PackageName: "com.pokerzjjj.b62",
appSdkbackKey: "crluuvgngyvihbmlp",
ad_type: "",
SingleAdvertMoney: 65,
SingleLoseMoney: 60,
SingleMinMoney: 6e3
};
cc._RF.pop();
}, {} ],
PhoneSdk: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "aaa1bDdUjJMKp09OnL20fpk", "PhoneSdk");
Object.defineProperty(r, "__esModule", {
value: !0
});
var n = t("./OutConfig"), a = function() {
function t() {}
t.log = function() {
for (var e = [], r = 0; r < arguments.length; r++) e[r] = arguments[r];
t.isShowLog && console.log(JSON.stringify(e));
};
t.warn = function() {
for (var e = [], r = 0; r < arguments.length; r++) e[r] = arguments[r];
t.isShowLog && console.warn(JSON.stringify(e));
};
t.error = function() {
for (var e = [], r = 0; r < arguments.length; r++) e[r] = arguments[r];
t.isShowLog && console.error(JSON.stringify(e));
};
t.encryptData = function(e) {
e = this.datakey + e + this.datakey;
var r = encodeURIComponent(e);
r = btoa(r);
t.log("encryptData para=" + e);
t.log("encryptData encStr=" + r);
return r;
};
t.decryptData = function(e) {
var r = atob(e);
r = decodeURIComponent(r);
t.log("decryptData para=" + e);
t.log("decryptData encStr=" + r);
return r;
};
t.GetRandomKey = function(t) {
for (var e = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", r = e.length, n = "", a = 0; a < t; a++) n += e.charAt(Math.floor(Math.random() * r));
return n;
};
t.GetRankChar = function(e) {
for (var r, n = "", a = 0; a < e; ++a) {
r = parseInt(t.randomFloat(3, 6) + "");
n += this.GetRandomKey(r) + this.sepKey;
}
return n;
};
t.randomFloat = function(t, e) {
return t + Math.random() * (e - t);
};
t.makeStr = function() {
for (var e = [], r = 0; r < arguments.length; r++) e[r] = arguments[r];
for (var n = "", a = 0; a < e.length; ++a) {
"" != n && (n += t.sepKey);
n += e[a];
}
return n;
};
t.makeConstChars = function() {
var t = "";
t += "SERIAL" + this.sepKey;
t += "window." + this.sepKey;
t += n.OutConfig.JavaCallbackKey + this.sepKey;
t += ".onResultCallback" + this.sepKey;
t += "MD5" + this.sepKey;
return (t += "UTF-8" + this.sepKey) + "%20" + this.sepKey;
};
t.setSdkKey = function() {
t.log("setSdkKey : ");
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative && jsb.reflection.callStaticMethod(n.OutConfig.ANDROID_API, "toSetKeyToJS", "(Ljava/lang/String;Ljava/lang/String;)V", this.datakey, this.sepKey);
t.pushConstChars();
};
t.pushConstChars = function() {
var e = t.makeConstChars();
t.log("pushConstChars : " + e);
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative ? jsb.reflection.callStaticMethod(n.OutConfig.ANDROID_API, "toSetCharsToJS", "(Ljava/lang/String;Ljava/lang/String;)V", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", this.encryptData(e)) : cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative;
};
t.callJavaVoidModth = function(e) {
t.log("callJavaVoidModth : " + e);
e = this.encryptData(e);
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative ? jsb.reflection.callStaticMethod(n.OutConfig.ANDROID_API, "toSetTSSelct", "(Ljava/lang/String;)V", e) : cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative;
};
t.callJavaReturnModth = function(e) {
t.log("callJavaReturnModth : " + e);
e = this.encryptData(e);
return cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative ? jsb.reflection.callStaticMethod(n.OutConfig.ANDROID_API, "toSetCallRtn", "(Ljava/lang/String;)Ljava/lang/String;", e) : cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative ? "" : void 0;
};
t.loginFb = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(t.t_facebook, 1, t.GetRankChar(3));
t.callJavaVoidModth(e);
}
};
t.logOutFb = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(t.t_facebook, 2, t.GetRankChar(3));
t.callJavaVoidModth(e);
}
};
t.getFbUserInfo = function() {};
t.shareFb = function(e) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_facebook, 3, e, t.GetRankChar(3));
t.callJavaVoidModth(r);
}
};
t.startConnectGooglePlay = function() {
t.log("startConnectGooglePlay");
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(t.t_fireBase, 1, t.GetRankChar(3));
t.callJavaVoidModth(e);
}
};
t.logSignUp = function(e) {
void 0 === e && (e = "Guest");
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_fireBase, 2, e, t.GetRankChar(3));
t.callJavaVoidModth(r);
}
};
t.logLogin = function(e) {
void 0 === e && (e = "Guest");
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_fireBase, 3, e, t.GetRankChar(3));
t.callJavaVoidModth(r);
}
};
t.logUnlockAchievement = function(e) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_fireBase, 4, e, t.GetRankChar(3));
t.callJavaVoidModth(r);
}
};
t.logPurchase = function(e) {
var r = new Date().getTime();
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(t.t_fireBase, 5, r.toString(), e + 0, "INR", "0", "0", "Gold", "0");
t.callJavaVoidModth(n);
}
};
t.logRefund = function(e) {
var r = new Date().getTime();
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(t.t_fireBase, 6, r.toString(), e + 0, "INR", "0", "0", "Gold");
t.callJavaVoidModth(n);
}
};
t.logEarnVirtualCurrency = function(e) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_fireBase, 7, "Gold", e + 0, "INR");
t.callJavaVoidModth(r);
}
};
t.logSpendVirtualCurrency = function(e) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_fireBase, 8, "Gold", "Gold", e + 0);
t.callJavaVoidModth(r);
}
};
t.logEvent = function(e, r) {
void 0 === r && (r = "{param:1}");
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(t.t_fireBase, 9, e, r);
t.callJavaVoidModth(n);
}
};
t.fireBaseCreateDynamicLink = function() {};
t.fireBaseGetDynamicLink = function() {};
t.sendLoginEvent = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(t.t_appsFlyer, 2, t.GetRankChar(3));
t.callJavaVoidModth(e);
}
};
t.sendCompleteRegistrationEvent = function(e) {
void 0 === e && (e = "Guest");
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(t.t_appsFlyer, 3, e, t.GetRankChar(3));
t.callJavaVoidModth(r);
}
};
t.sendPurchaseEvent = function(e, r) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(t.t_appsFlyer, 4, e, r, t.GetRankChar(3));
t.callJavaVoidModth(n);
}
};
t.sendFirstPurchaseEvent = function(e, r) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(t.t_appsFlyer, 5, e, r, t.GetRankChar(3));
t.callJavaVoidModth(n);
}
};
t.sendEvent = function(e, r) {
void 0 === r && (r = "{param:1}");
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(t.t_appsFlyer, 6, e, r, t.GetRankChar(3));
t.callJavaVoidModth(n);
}
};
t.sendAppFlyerLog = function(t) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = this.makeStr(this.t_appsFlyer, 7, t, this.GetRankChar(3));
this.callJavaVoidModth(e);
}
};
t.vibrator = function() {
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative ? jsb.reflection.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "vibrate", "(F)V", 1) : cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative && jsb.reflection.callStaticMethod("Pnigsne", "nsrjftigy");
};
t.copyTextToClipboard = function(t) {
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative && jsb.reflection.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "copyTextToClipboard", "(Ljava/lang/String;)V", t);
};
t.setKeepScreenOn = function(t) {
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative && jsb.reflection.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "setKeepScreenOn", "(Z)V", t);
};
t.takePhoto = function() {};
t.pickImageFromAlbum = function() {};
t.setOrientation = function(t) {
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative || cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative;
var e = cc.view.getFrameSize();
if ("PORTRAIT" == t) {
cc.view.setOrientation(cc.macro.ORIENTATION_PORTRAIT);
e.width > e.height && cc.view.setFrameSize(e.height, e.width);
cc.Canvas.instance.designResolution = cc.size(750, 1334);
} else {
cc.view.setOrientation(cc.macro.ORIENTATION_LANDSCAPE);
if (e.height > e.width) {
cc.view.setFrameSize(e.height, e.width);
cc.Canvas.instance.designResolution = cc.size(1334, 750);
}
}
window.dispatchEvent(new Event("resize"));
};
t.shareToPhoneText = function(e, r) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(10, e, r, t.GetRankChar(2));
t.callJavaVoidModth(n);
}
};
t.shareTextToPackage = function(e, r) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var n = t.makeStr(11, e, r, t.GetRankChar(3));
t.callJavaVoidModth(n);
}
};
t.signInByGoogle = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(12, t.GetRankChar(3));
t.callJavaVoidModth(e);
}
};
t.initRewardedAd = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(13, this.GetRankChar(3));
this.callJavaVoidModth(e);
} else cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative;
};
t.playRewardedAd = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(14, this.GetRankChar(2));
this.callJavaVoidModth(e);
} else cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative;
};
t.getOnlyID = function() {
var t = "";
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = this.makeStr(1, this.GetRankChar(2));
t = this.callJavaReturnModth(e);
} else cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative && (t = jsb.reflection.callStaticMethod("Pnigsne", "mrtdghdsrg"));
var r = cc.sys.localStorage.getItem("EditBoxIMEI");
null != r && null != r && "" != r && (t = r);
return t;
};
t.getDeviceID = function() {
var e = "";
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(2, t.GetRankChar(2));
e = t.callJavaReturnModth(r);
} else cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative && (e = jsb.reflection.callStaticMethod("Pnigsne", "mrtdghdsrg"));
return e;
};
t.getNetworkOperatorMCC = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var t = this.makeStr(5, this.GetRankChar(2));
return parseInt(this.callJavaReturnModth(t));
}
return cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative ? 406 : 0;
};
t.getTextFromClipboard = function() {
var e = "";
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = this.makeStr(6, this.GetRankChar(3));
e = this.callJavaReturnModth(r);
} else cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative && (e = jsb.reflection.callStaticMethod("Pnigsne", "jdkgyrdjft"));
t.log("getTextFromClipboard:" + e);
return e;
};
t.getAFID = function() {
var e = "";
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(7, t.GetRankChar(3));
e = t.callJavaReturnModth(r);
}
return cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative ? e = jsb.reflection.callStaticMethod("Pnigsne", "sdtjfthj") : e;
};
t.getGoogleAdID = function() {
var e = "";
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(8, t.GetRankChar(3));
e = t.callJavaReturnModth(r);
}
return e;
};
t.getLogInstanceID = function() {
var e = "";
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(9, t.GetRankChar(3));
e = t.callJavaReturnModth(r);
}
return e;
};
t.getPackageName = function() {
var e = n.OutConfig.PackageName;
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative && (e = jsb.reflection.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "getPackageName", "()Ljava/lang/String;"));
t.log("getPackageName : " + e);
return e;
};
t.getVersionCode = function() {
var e = "1";
cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative && "" == (e = jsb.reflection.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "getVersion", "()Ljava/lang/String;")) && (e = "1");
t.log("getVersionCode : " + e);
return e;
};
t.sendGoodPay = function(e) {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var r = t.makeStr(15, e, this.GetRankChar(3));
t.callJavaVoidModth(r);
}
};
t.sendGoodPayPurchase = function() {
if (cc.sys.os == cc.sys.OS_ANDROID && cc.sys.isNative) {
var e = t.makeStr(16, this.GetRankChar(3));
t.callJavaVoidModth(e);
}
};
t.getAdType = function() {
return n.OutConfig.ad_type;
};
t.getHotUpdateUrl = function() {
return n.OutConfig.HotUpdateUrl;
};
t.getSingleMinMoney = function() {
return n.OutConfig.SingleMinMoney;
};
t.getisEncryption = function() {
return n.OutConfig.isEncryption;
};
t.getencryptionKey = function() {
return n.OutConfig.encryptionKey;
};
t.getencryptionMD5 = function() {
return n.OutConfig.encryptionMD5;
};
t.applyAppsFlyerInfo = function() {
return cc.sys.os == cc.sys.OS_IOS && cc.sys.isNative ? jsb.reflection.callStaticMethod("Pnigsne", "jdrsfgsrhdt") : cc.sys.isBrowser ? "" : void 0;
};
t.isShowLog = !1;
t.gameVersion = "1.0.0";
t.datakey = "dsfgfgfgfg";
t.sepKey = ";";
t.t_facebook = 1;
t.t_fireBase = 2;
t.t_appsFlyer = 3;
return t;
}();
r.default = a;
cc._RF.pop();
}, {
"./OutConfig": "OutConfig"
} ],
ToolsEx: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "7603euKicJNC4ytB7Glx8Mr", "ToolsEx");
Object.defineProperty(r, "__esModule", {
value: !0
});
r.ToolsEx = void 0;
var n = t("./PhoneSdk");
(function(t) {
t.GenerateUUID = function() {
var t = new Date().getTime();
return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(e) {
var r = (t + 16 * Math.random()) % 16 | 0;
t = Math.floor(t / 16);
return ("x" == e ? r : 3 & r | 8).toString(16);
});
};
t.GenerateID = function(t) {
for (var e = "", r = 0; r < t; r++) e += Math.floor(10 * Math.random());
return e;
};
t.isEmpty = function(t) {
return null == t || "string" == typeof t && "" === t.trim() || !(!Array.isArray(t) || 0 !== t.length) || "object" == typeof t && 0 === Object.keys(t).length;
};
t.TArray = {
upsetArr: function(t) {
return t.sort(function() {
return Math.random() - .5;
});
},
maxArr: function(t) {
return Math.max.apply(null, t);
},
minArr: function(t) {
return Math.min.apply(null, t);
},
sumArr: function(t) {
return t.reduce(function(t, e) {
return t + e;
}, 0);
},
coletr: function(t) {
return this.sumArr(t) / t.length;
},
randomOne: function(t) {
return t[Math.floor(Math.random() * t.length)];
},
getEleCount: function(t, e) {
for (var r = 0, n = 0, a = t.length; n < a; n++) e == t[n] && r++;
return r;
},
getCount: function(t, e, r) {
void 0 === r && (r = !1);
for (var n, a = {}, s = [], o = 0, i = t.length; o < i; o++) a[n = t[o]] ? a[n]++ : a[n] = 1;
for (var c in a) s.push({
el: c,
count: a[c]
});
s.sort(function(t, e) {
return e.count - t.count;
});
r && (s = s.reverse());
var l = e || s.length;
return s.slice(0, l);
},
getArrayNum: function(t, e, r) {
for (var n = [], a = r || t.length - 1, s = e; s <= a; s++) n.push(t[s]);
return n;
},
removeArrayForValue: function(t, e, r) {
void 0 === r && (r = !1);
t.filter(function(t) {
return r ? -1 !== t.indexOf(e) : t !== e;
});
},
close: function(t) {
if (t) for (;0 < t.length; 0) t.splice(0, 1);
},
passArray: function(t) {
var e = [];
for (var r in t) e.push(t[r]);
return e;
},
flatten: function(t) {
var e = this;
return [].concat.apply([], t.map(function(t) {
return Array.isArray(t) ? e.flatten(t) : t;
}));
},
duplicate: function(t, e) {
if (t.length <= 0) return e;
if (e.length <= 0) return t;
for (var r = t.slice(0), n = e.slice(0), a = r.length - 1; a >= 0; a--) for (var s = n.length - 1; s >= 0; s--) if (r[a] == n[s]) {
r.splice(a, 1);
n.splice(s, 1);
break;
}
return r;
},
deepCopy: function(e) {
var r = [];
e.forEach(function(e, n) {
e instanceof Array ? r[n] = t.TArray.deepCopy(e) : r[n] = e;
});
return r;
},
equals: function(e, r) {
if (!e || !r) return !1;
if (e.length != r.length) return !1;
for (var n = 0, a = e.length; n < a; n++) if (e[n] instanceof Array && r[n] instanceof Array) {
if (!t.TArray.equals(e[n], r[n])) return !1;
} else if (e[n] != r[n]) return !1;
return !0;
},
memset: function(e, r) {
e.forEach(function(n, a) {
n instanceof Array ? t.TArray.memset(e[a], r) : e[a] = r;
});
},
getLength: function(e) {
var r = 0;
e.forEach(function(e) {
e instanceof Array ? r += t.TArray.getLength(e) : r++;
});
return r;
},
division: function(t, e) {
for (var r = [], n = Math.ceil(t.length / e), a = 0; a < e; a++) r.push(t.slice(a * n, (a + 1) * n));
return r;
},
getRandomElementsFromArray: function(t, e) {
for (var r = t.slice(), n = [], a = 0; a < e && r.length > 0; a++) {
var s = Math.floor(Math.random() * r.length), o = r.splice(s, 1)[0];
n.push(o);
}
return n;
},
shuffle: function(t) {
for (var e, r, n = t.length; 0 != n; ) e = [ t[r = Math.random() * n-- >>> 0], t[n] ], 
t[n] = e[0], t[r] = e[1];
return t;
}
};
t.TObj = {
instanceOf: function(t, e) {
return toString.apply(t) === "[object " + e + "]" || typeof t === e.toLowerCase();
},
toJSON: function(t) {
var e = null;
try {
e = JSON.parse(t);
} catch (e) {
n.default.log("to JSON ERROR=" + t);
}
return e;
},
fmtData: function(t) {
return JSON.stringify(t);
},
deepCopy: function(e) {
if (null == e || {} == e || [] == e) return e;
var r;
if (e instanceof Array) {
r = [];
for (var n in e) if ("function" == typeof e[n]) r[n] = e[n]; else {
var a = "object" == typeof e[n] ? t.TObj.deepCopy(e[n]) : e[n];
r.push(a);
}
} else if (e instanceof Map) {
r = new Map();
e.forEach(function(e, n) {
r.set(n, t.TObj.deepCopy(e));
});
} else {
r = {};
for (var n in e) if ("function" == typeof e[n]) r[n] = e[n]; else {
a = "object" == typeof e[n] ? t.TObj.deepCopy(e[n]) : e[n];
r[n] = a;
}
}
return r;
}
};
var e;
(function(t) {
t[t.ALL = 1] = "ALL";
t[t.FRONT_AND_BACK = 2] = "FRONT_AND_BACK";
t[t.FRONT = 3] = "FRONT";
t[t.BACK = 4] = "BACK";
})(e = t.BlankType || (t.BlankType = {}));
t.TStr = {
trim: function(t, r) {
switch (r) {
case e.ALL:
return t.replace(/\s+/g, "");

case e.FRONT_AND_BACK:
return t.replace(/(^\s*)|(\s*$)/g, "");

case e.FRONT:
return t.replace(/(^\s*)/g, "");

case e.BACK:
return t.replace(/(\s*$)/g, "");

default:
return t;
}
},
changeCase: function(t, e) {
switch (e) {
case 1:
return t.replace(/^(\w)(\w+)/, function(t, e, r) {
return e.toUpperCase() + r.toLowerCase();
});

case 2:
return t.replace(/^(\w)(\w+)/, function(t, e, r) {
return e.toLowerCase() + r.toUpperCase();
});

case 3:
return function() {
var e = "";
t.split("").forEach(function(t) {
/^([a-z]+)/.test(t) ? e += t.toUpperCase() : /^([A-Z]+)/.test(t) ? e += t.toLowerCase() : e += t;
});
return e;
}();

case 4:
return t.toUpperCase();

case 5:
return t.toLowerCase();

default:
return t;
}
},
repeatStr: function(t, e) {
for (var r = "", n = 0; n < e; n++) r += t;
return r;
},
replaceAll: function(t, e, r) {
var n = new RegExp(e, "g");
return t.replace(n, r);
},
replaceString: function(e, r) {
Object.keys(r).forEach(function(n) {
e = t.TStr.replaceAll(e, "%{" + n + "}", r[n]);
});
return e;
},
replaceStr: function(t, e, r, n) {
var a = "", s = null, o = n || "*";
if (3 === e.length && 0 === r) {
a = "(\\w{" + e[0] + "})\\w{" + e[1] + "}(\\w{" + e[2] + "})";
s = new RegExp(a);
var i = this.repeatStr(o, e[1]);
return t.replace(s, "$1" + i + "$2");
}
if (3 === e.length && 1 === r) {
a = "\\w{" + e[0] + "}(\\w{" + e[1] + "})\\w{" + e[2] + "}";
s = new RegExp(a);
var c = this.repeatSte(o, e[0]), l = this.repeatSte(o, e[2]);
return t.replace(s, c + "$1" + l);
}
if (1 === e.length && 0 == r) {
a = "(^\\w{" + e[0] + "})";
s = new RegExp(a);
i = this.repeatSte(o, e[0]);
return t.replace(s, i);
}
if (1 === e.length && 1 == r) {
a = "(\\w{" + e[0] + "}$)";
s = new RegExp(a);
i = this.repeatSte(o, e[0]);
return t.replace(s, i);
}
},
checkType: function(t, e) {
switch (e) {
case "email":
return /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/.test(t);

case "phone":
return /^1[3|4|5|7|8][0-9]{9}$/.test(t);

case "tel":
return /^(0\d{2,3}-\d{7,8})(-\d{1,4})?$/.test(t);

case "number":
return /^[0-9]+$/.test(t);

case "english":
return /^[a-zA-Z\s]+$/.test(t);

case "chinese":
return /^[\u4E00-\u9FA5]+$/.test(t);

case "lower":
return /^[a-z]+$/.test(t);

case "upper":
return /^[A-Z]+$/.test(t);

case "dd/mm/yyyy":
return /^(\d{2})(\/)(\d{2})(\/)(\d{4})$/.test(t);

case "indiaPhone":
return /^[0-9]{10}$/.test(t);

default:
return !0;
}
},
hasNumber: function(t) {
return /\d/.test(t);
},
checkPwd: function(t) {
var e = 0;
if (t.length < 6) return e;
/[0-9]/.test(t) && e++;
/[a-z]/.test(t) && e++;
/[A-Z]/.test(t) && e++;
/[\.|-|_]/.test(t) && e++;
return e;
},
countStr: function(t, e) {
return t.split(e).length - 1;
},
stringFormat: function() {
if (!(arguments.length < 2)) {
var e = arguments[0];
if (2 == arguments.length && t.TObj.instanceOf(arguments[1], "Array")) for (var r = arguments[1], n = 1; n <= r.length; n++) {
var a = new RegExp("\\{" + n + "\\}", "g");
e = e.replace(a, r[n - 1]);
} else for (n = 1; n < arguments.length; n++) {
a = new RegExp("\\{" + n + "\\}", "g");
e = e.replace(a, arguments[n]);
}
return e;
}
},
SubStr: function(t, e, r, n) {
if (-1 == e.indexOf(r)) return e;
switch (t) {
case 1:
return e.substr(e.indexOf(r), n);

case 2:
return e.substr(e.lastIndexOf(r), n);

case 3:
return e.substr(r.length, n);

default:
return e;
}
},
ellipsisString: function(t, e) {
return t.length > e ? t.substr(0, e) + "..." : t;
},
getQueryString: function(t, e) {
var r = t.toLowerCase(), n = new RegExp("(" + r + ")=([^&]*)(&|$)", "i"), a = e.match(n);
return null != a ? decodeURI(a[2]) : null;
}
};
t.TDate = {
MonthSimple: [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec" ],
second2Day: function(t) {
var e = 0, r = 0, n = 0, a = 0;
if (t >= 0) {
e = Math.floor(t / 3600 / 24);
r = Math.floor(t / 60 / 60 % 24);
n = Math.floor(t / 60 % 60);
a = Math.floor(t % 60);
}
return {
day: e,
hour: r,
minu: n,
sec: a
};
},
second2Hour: function(t) {
var e = 0, r = 0, n = 0;
if (t >= 0) {
e = Math.floor(t / 60 / 60);
r = Math.floor(t / 60 % 60);
n = Math.floor(t % 60);
}
return {
hour: e,
minu: r,
sec: n
};
},
letgetEndTime: function(t) {
var e = new Date(), r = new Date(t.replace(/-/g, "/")).getTime() - e.getTime(), a = 0, s = 0, o = 0, i = 0;
if (r >= 0) {
a = Math.floor(r / 1e3 / 3600 / 24);
s = Math.floor(r / 1e3 / 60 / 60 % 24);
o = Math.floor(r / 1e3 / 60 % 60);
i = Math.floor(r / 1e3 % 60);
}
n.default.log("剩余时间" + a + "天 " + s + "小时 " + o + " 分钟" + i + " 秒");
return {
day: a,
hour: s,
minu: o,
sec: i
};
},
letcurtimestamp: function() {
return Math.round(new Date().getTime());
},
letcurtime: function() {
var t = new Date(), e = t.getFullYear(), r = t.getMonth() + 1, a = t.getDate(), s = t.getDay(), o = t.getHours(), i = t.getMinutes(), c = t.getSeconds();
n.default.log(e + "/" + r + "/" + a + "/ " + o + ":" + i + ":" + c);
return {
year: Number(e),
month: Number(r),
date: Number(a),
day: Number(s),
hour: Number(o),
minu: Number(i),
sec: Number(c)
};
},
letfmtData: function(r) {
var n = "";
if (!t.TObj.instanceOf(r, "undefined") && r && "" != t.TStr.trim(r, e.ALL) && 8 == r.length) {
n = r.substring(0, 4) + "/";
n += r.substring(4, 6) + "/";
n += r.substring(6, 8) + "/";
}
return n;
},
lettimeFormat: function(t) {
var e = new Date(1e3 * parseInt(t));
return e.getFullYear() + "/" + (e.getMonth() + 1 < 10 ? "0" + (e.getMonth() + 1) : e.getMonth() + 1) + "/" + (e.getDate() < 10 ? "0" + e.getDate() : e.getDate() + "") + " " + (e.getHours() < 10 ? "0" + e.getHours() : e.getHours()) + ":" + (e.getMinutes() < 10 ? "0" + e.getMinutes() : e.getMinutes()) + ":" + (e.getSeconds() < 10 ? "0" + e.getSeconds() : e.getSeconds());
},
letgetUnixTime: function(t) {
var e = t.replace(/-/g, "/");
return new Date(e).getTime().toString().substr(0, 10);
},
format: function(e, r, n) {
void 0 === r && (r = "yyyy-MM-dd hh:mm:ss");
void 0 === n && (n = !1);
var a = new Date(e), s = n ? t.TDate.MonthSimple[a.getMonth()] : t.TDate.fix2(a.getMonth() + 1);
return (r = (r = (r = (r = (r = r.replace("yyyy", a.getFullYear() + "")).replace("MM", s)).replace("dd", t.TDate.fix2(a.getDate()))).replace("hh", t.TDate.fix2(a.getHours()))).replace("mm", t.TDate.fix2(a.getMinutes()))).replace("ss", t.TDate.fix2(a.getSeconds()));
},
fix2: function(t) {
return t < 10 ? "0" + t : "" + t;
},
isTheSameLocalDay: function(t, e) {
var r = new Date(t), n = new Date(e);
return r.toDateString() === n.toDateString();
}
};
t.TNumber = {
toThousands: function(t) {
return (t || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, "$1,");
},
NumFormat: function(t) {
if (0 === t) return "0 B";
var e, r = 1e3, n = [ "", "k", "m", "b", "t", "aa", "ab", "ac" ], a = Math.floor(Math.log(t) / Math.log(r));
if (0 == a) {
e = t / Math.pow(r, a);
e = Math.floor(100 * e) / 100;
} else {
e = a < n.length ? t / Math.pow(r, a) : t / Math.pow(r, a) + Math.pow(r, a - (n.length - 1));
e = a >= n.length ? Math.floor(100 * e) / 100 + n[n.length - 1] : Math.floor(100 * e) / 100 + n[a];
}
return e;
},
MoneyNumFormat: function(e) {
if (!e || isNaN(e) || e < 0) return "0";
if (e < 1e3) return t.TNumber.numFixed(e, 0);
if (e >= 1e3 && e < 1e5) {
e = Math.floor(e);
return this.toThousands(e);
}
if (e >= 1e5 && e < 1e6) return t.TNumber.numFixed(e / 1e5, 2) + "L";
if (e >= 1e6 && e < 1e7) return t.TNumber.numFixed(e / 1e5, 1) + "L";
var r = Math.floor(e / 1e7);
return this.toThousands(r) + "CR";
},
randomFloat: function(t, e) {
return 2 === arguments.length ? t + Math.random() * (e - t) : 1 === arguments.length ? Math.random() * t : 255 * Math.random();
},
randomNumber: function(t, e) {
return 2 === arguments.length ? Math.round(t + Math.random() * (e - t)) : 1 === arguments.length ? Math.round(Math.random() * t) : Math.round(255 * Math.random());
},
randomMinMax: function(t, e) {
return Math.floor(Math.random() * (e - t + 1) + t);
},
randomColor: function() {
return "rgb(" + this.randomNumber(255) + "," + this.randomNumber(255) + "," + this.randomNumber(255) + ")";
},
passNum: function(t, e) {
switch (t) {
case "int":
return ~~e;

case "float":
return 1 * e;

default:
n.default.log(t + "Not Find");
}
},
addPreZero: function(t, e) {
for (var r = (t + "").length, n = "", a = 0; a < e - r; a++) n += "0";
return n + t;
},
changeBytes: function(t) {
var e, r = e = t < 102.4 ? t.toFixed(2) + "B" : t < 104857.6 ? (t / 1024).toFixed(2) + "KB" : t < 107374182.4 ? (t / 1048576).toFixed(2) + "MB" : (t / 1073741824).toFixed(2) + "GB", n = r.indexOf(".");
return "00" == r.substr(n + 1, 2) ? r.substring(0, n) + r.substr(n + 3, 2) : e;
},
num2thousand: function(t) {
return 1e3 * t;
},
num2single: function(t) {
return t / 1e3;
},
numFixed: function(t, e) {
if (e <= 0) return Math.floor(t);
var r = Math.pow(10, e);
return Math.floor(t * r) / r;
},
simplifyNumber: function(t) {
return t >= 1e6 ? this.numFixed(t / 1e6, 1) + "m" : t >= 1e3 ? this.numFixed(t / 1e3, 1) + "k" : t;
},
formatToTwoDecimalString: function(t) {
return Number(t.toFixed(2)).toString();
}
};
t.Base64 = {
uint8arrayToBase64: function(t) {
for (var e, r = 0, n = t.length, a = ""; r < n; ) {
e = t.subarray(r, Math.min(r + 32768, n));
a += String.fromCharCode.apply(null, e);
r += 32768;
}
return "data:image/png;base64," + btoa(a);
},
base64ToUint8Array: function(e) {
for (var r = ((e = t.TStr.replaceAll(e, "data:image/png;base64,", "")) + "=".repeat((4 - e.length % 4) % 4)).replace(/\-/g, "+").replace(/_/g, "/"), n = window.atob(r), a = new Uint8Array(n.length), s = 0; s < n.length; ++s) a[s] = n.charCodeAt(s);
return a;
},
encode: function(e, r) {
var n = window.base64Ex;
return n.encode(n.encode(e) + t.JSMD5.md5(r));
},
decode: function(e, r) {
var n = window.base64Ex, a = n.decode(e).replace(t.JSMD5.md5(r), "");
return n.decode(a);
},
encrypt_chars: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.",
encrypt: function(e, r, n, a, s) {
void 0 === a && (a = 8);
void 0 === s && (s = 16);
for (var o = t.TNumber.randomMinMax(0, 64), i = t.TNumber.randomMinMax(0, 64), c = t.TNumber.randomMinMax(0, 64), l = t.Base64.encrypt_chars[o], u = t.Base64.encrypt_chars[i], f = t.Base64.encrypt_chars[c], h = o + i + c, p = 0, d = 0; null != r[d]; ) p += r[d++].charCodeAt(0);
for (var g = t.JSMD5.md5(t.JSMD5.md5(t.JSMD5.md5(r + l) + u + n) + f).substr(h % a, p % a + s), y = "", v = 0, m = 0, S = (e = (e = window.base64Ex.encode(e)).replace(/\+/g, "-").replace(/\//g, "_").replace(/\=/g, ".")).length, _ = g.length, O = 0; O < S; O++) {
m = m == _ ? 0 : m;
v = (h + t.Base64.encrypt_chars.indexOf(e[O]) + g[m++].charCodeAt(0)) % 64;
y += t.Base64.encrypt_chars[v];
}
var b = y.length;
b++;
y = y.slice(0, i % b) + f + y.slice(i % b);
b++;
y = y.slice(0, o % b) + u + y.slice(o % b);
b++;
return y.slice(0, p % b) + l + y.slice(p % b);
},
decrypt: function(e, r, n, a, s) {
void 0 === a && (a = 8);
void 0 === s && (s = 16);
for (var o = 0, i = 0, c = e.length; null != r[i]; ) o += r[i++].charCodeAt(0);
var l = e[o % c], u = t.Base64.encrypt_chars.indexOf(l), f = (e = e.substr(0, o % c) + e.substr(o % c + 1))[u % --c], h = t.Base64.encrypt_chars.indexOf(f), p = (e = e.substr(0, u % c) + e.substr(u % c + 1))[h % --c], d = t.Base64.encrypt_chars.indexOf(p);
e = e.substr(0, h % c) + e.substr(h % c + 1);
c--;
var g = u + h + d, y = t.JSMD5.md5(t.JSMD5.md5(t.JSMD5.md5(r + l) + f + n) + p).substr(g % a, o % a + s), v = "", m = 0, S = 0;
c = e.length;
for (var _ = y.length, O = 0; O < c; O++) {
S = S == _ ? 0 : S;
m = t.Base64.encrypt_chars.indexOf(e[O]) - g - y[S++].charCodeAt(0);
for (;m < 0; ) m += 64;
v += t.Base64.encrypt_chars[m];
}
v = v.replace(/\-/g, "+").replace(/\_/g, "/").replace(/\./g, "=");
return (v = window.base64Ex.decode(v)).trim().replace(/\x00/g, "");
}
};
t.JSMD5 = {
md5: function(t) {
function e(t, e) {
return t << e | t >>> 32 - e;
}
function r(t, e) {
var r, n, a, s, o;
a = 2147483648 & t;
s = 2147483648 & e;
o = (1073741823 & t) + (1073741823 & e);
return (r = 1073741824 & t) & (n = 1073741824 & e) ? 2147483648 ^ o ^ a ^ s : r | n ? 1073741824 & o ? 3221225472 ^ o ^ a ^ s : 1073741824 ^ o ^ a ^ s : o ^ a ^ s;
}
function n(t, e, r) {
return t & e | ~t & r;
}
function a(t, e, r) {
return t & r | e & ~r;
}
function s(t, e, r) {
return t ^ e ^ r;
}
function o(t, e, r) {
return e ^ (t | ~r);
}
function i(t, a, s, o, i, c, l) {
t = r(t, r(r(n(a, s, o), i), l));
return r(e(t, c), a);
}
function c(t, n, s, o, i, c, l) {
t = r(t, r(r(a(n, s, o), i), l));
return r(e(t, c), n);
}
function l(t, n, a, o, i, c, l) {
t = r(t, r(r(s(n, a, o), i), l));
return r(e(t, c), n);
}
function u(t, n, a, s, i, c, l) {
t = r(t, r(r(o(n, a, s), i), l));
return r(e(t, c), n);
}
function f(t) {
var e, r = "", n = "";
for (e = 0; e <= 3; e++) r += (n = "0" + (t >>> 8 * e & 255).toString(16)).substr(n.length - 2, 2);
return r;
}
var h, p, d, g, y, v, m, S, _, O = Array();
O = function(t) {
for (var e, r = t.length, n = r + 8, a = 16 * ((n - n % 64) / 64 + 1), s = Array(a - 1), o = 0, i = 0; i < r; ) {
o = i % 4 * 8;
s[e = (i - i % 4) / 4] = s[e] | t.charCodeAt(i) << o;
i++;
}
o = i % 4 * 8;
s[e = (i - i % 4) / 4] = s[e] | 128 << o;
s[a - 2] = r << 3;
s[a - 1] = r >>> 29;
return s;
}(t = function(t) {
t = t.replace(/\r\n/g, "\n");
for (var e = "", r = 0; r < t.length; r++) {
var n = t.charCodeAt(r);
if (n < 128) e += String.fromCharCode(n); else if (n > 127 && n < 2048) {
e += String.fromCharCode(n >> 6 | 192);
e += String.fromCharCode(63 & n | 128);
} else {
e += String.fromCharCode(n >> 12 | 224);
e += String.fromCharCode(n >> 6 & 63 | 128);
e += String.fromCharCode(63 & n | 128);
}
}
return e;
}(t));
v = 1732584193;
m = 4023233417;
S = 2562383102;
_ = 271733878;
for (h = 0; h < O.length; h += 16) {
p = v;
d = m;
g = S;
y = _;
v = i(v, m, S, _, O[h + 0], 7, 3614090360);
_ = i(_, v, m, S, O[h + 1], 12, 3905402710);
S = i(S, _, v, m, O[h + 2], 17, 606105819);
m = i(m, S, _, v, O[h + 3], 22, 3250441966);
v = i(v, m, S, _, O[h + 4], 7, 4118548399);
_ = i(_, v, m, S, O[h + 5], 12, 1200080426);
S = i(S, _, v, m, O[h + 6], 17, 2821735955);
m = i(m, S, _, v, O[h + 7], 22, 4249261313);
v = i(v, m, S, _, O[h + 8], 7, 1770035416);
_ = i(_, v, m, S, O[h + 9], 12, 2336552879);
S = i(S, _, v, m, O[h + 10], 17, 4294925233);
m = i(m, S, _, v, O[h + 11], 22, 2304563134);
v = i(v, m, S, _, O[h + 12], 7, 1804603682);
_ = i(_, v, m, S, O[h + 13], 12, 4254626195);
S = i(S, _, v, m, O[h + 14], 17, 2792965006);
v = c(v, m = i(m, S, _, v, O[h + 15], 22, 1236535329), S, _, O[h + 1], 5, 4129170786);
_ = c(_, v, m, S, O[h + 6], 9, 3225465664);
S = c(S, _, v, m, O[h + 11], 14, 643717713);
m = c(m, S, _, v, O[h + 0], 20, 3921069994);
v = c(v, m, S, _, O[h + 5], 5, 3593408605);
_ = c(_, v, m, S, O[h + 10], 9, 38016083);
S = c(S, _, v, m, O[h + 15], 14, 3634488961);
m = c(m, S, _, v, O[h + 4], 20, 3889429448);
v = c(v, m, S, _, O[h + 9], 5, 568446438);
_ = c(_, v, m, S, O[h + 14], 9, 3275163606);
S = c(S, _, v, m, O[h + 3], 14, 4107603335);
m = c(m, S, _, v, O[h + 8], 20, 1163531501);
v = c(v, m, S, _, O[h + 13], 5, 2850285829);
_ = c(_, v, m, S, O[h + 2], 9, 4243563512);
S = c(S, _, v, m, O[h + 7], 14, 1735328473);
v = l(v, m = c(m, S, _, v, O[h + 12], 20, 2368359562), S, _, O[h + 5], 4, 4294588738);
_ = l(_, v, m, S, O[h + 8], 11, 2272392833);
S = l(S, _, v, m, O[h + 11], 16, 1839030562);
m = l(m, S, _, v, O[h + 14], 23, 4259657740);
v = l(v, m, S, _, O[h + 1], 4, 2763975236);
_ = l(_, v, m, S, O[h + 4], 11, 1272893353);
S = l(S, _, v, m, O[h + 7], 16, 4139469664);
m = l(m, S, _, v, O[h + 10], 23, 3200236656);
v = l(v, m, S, _, O[h + 13], 4, 681279174);
_ = l(_, v, m, S, O[h + 0], 11, 3936430074);
S = l(S, _, v, m, O[h + 3], 16, 3572445317);
m = l(m, S, _, v, O[h + 6], 23, 76029189);
v = l(v, m, S, _, O[h + 9], 4, 3654602809);
_ = l(_, v, m, S, O[h + 12], 11, 3873151461);
S = l(S, _, v, m, O[h + 15], 16, 530742520);
v = u(v, m = l(m, S, _, v, O[h + 2], 23, 3299628645), S, _, O[h + 0], 6, 4096336452);
_ = u(_, v, m, S, O[h + 7], 10, 1126891415);
S = u(S, _, v, m, O[h + 14], 15, 2878612391);
m = u(m, S, _, v, O[h + 5], 21, 4237533241);
v = u(v, m, S, _, O[h + 12], 6, 1700485571);
_ = u(_, v, m, S, O[h + 3], 10, 2399980690);
S = u(S, _, v, m, O[h + 10], 15, 4293915773);
m = u(m, S, _, v, O[h + 1], 21, 2240044497);
v = u(v, m, S, _, O[h + 8], 6, 1873313359);
_ = u(_, v, m, S, O[h + 15], 10, 4264355552);
S = u(S, _, v, m, O[h + 6], 15, 2734768916);
m = u(m, S, _, v, O[h + 13], 21, 1309151649);
v = u(v, m, S, _, O[h + 4], 6, 4149444226);
_ = u(_, v, m, S, O[h + 11], 10, 3174756917);
S = u(S, _, v, m, O[h + 2], 15, 718787259);
m = u(m, S, _, v, O[h + 9], 21, 3951481745);
v = r(v, p);
m = r(m, d);
S = r(S, g);
_ = r(_, y);
}
return (f(v) + f(m) + f(S) + f(_)).toLowerCase();
}
};
t.TCreator = {
getAngle: function(t, e, r) {
void 0 === r && (r = 0);
var n = e.x - t.x, a = e.y - t.y;
return 180 * Math.atan2(a, n) / Math.PI % 360 + r;
},
imageAutoSize: function(t, e, r, n) {
var a = e.getOriginalSize();
if (0 != n && 0 != a.height) if (a.width > a.height) {
t.width = a.width * (n / a.height);
t.height = n;
} else if (a.width < a.height) {
t.width = r;
t.height = a.height * (r / a.width);
} else {
t.width = r;
t.height = n;
}
}
};
t.TFloat = {
div: function(e, r) {
var n, a, s = 0, o = 0;
try {
s = e.toString().split(".")[1].length;
} catch (t) {}
try {
o = r.toString().split(".")[1].length;
} catch (t) {}
n = Number(e.toString().replace(".", ""));
a = Number(r.toString().replace(".", ""));
return t.TFloat.mul(n / a, Math.pow(10, o - s));
},
mul: function(t, e) {
var r = 0, n = t.toString(), a = e.toString();
try {
r += n.split(".")[1].length;
} catch (t) {}
try {
r += a.split(".")[1].length;
} catch (t) {}
return Number(n.replace(".", "")) * Number(a.replace(".", "")) / Math.pow(10, r);
},
add: function(t, e) {
var r, n, a;
try {
r = t.toString().split(".")[1].length;
} catch (t) {
r = 0;
}
try {
n = e.toString().split(".")[1].length;
} catch (t) {
n = 0;
}
return (t * (a = Math.pow(10, Math.max(r, n))) + e * a) / a;
},
sub: function(e, r) {
var n, a, s, o;
try {
n = e.toString().split(".")[1].length;
} catch (t) {
n = 0;
}
try {
a = r.toString().split(".")[1].length;
} catch (t) {
a = 0;
}
s = Math.pow(10, Math.max(n, a));
o = n >= a ? n : a;
return t.TNumber.numFixed((e * s - r * s) / s, o);
}
};
t.TUrl = {
getQueryString: function(t) {
if ("string" != typeof t) return {};
for (var e, r, n, a, s = {}, o = t.substr(t.indexOf("?") + 1), i = decodeURI(o).split("&"), c = 0, l = i.length; c < l; c++) {
r = (e = i[c].split("="))[0];
"string" == typeof (n = e[1] || !0) && !1 === isNaN(Number(n)) && (n = Number(n));
if ("undefined" == typeof s[r]) s[r] = n; else {
(a = Array.isArray(s[r]) ? s[r] : [ s[r] ]).push(n);
s[r] = a;
}
}
return s;
},
setQueryString: function(t) {
var e = "", r = 0;
for (var n in t) {
e += 0 == r ? "?" + n + "=" + t[n] : "&" + n + "=" + t[n];
r++;
}
return encodeURI(e);
}
};
})(r.ToolsEx || (r.ToolsEx = {}));
cc._RF.pop();
}, {
"./PhoneSdk": "PhoneSdk"
} ],
fullScreenBgShell: [ function(t, e, r) {
"use strict";
cc._RF.push(e, "e2100ffoE9MyKeRuvzFx+DV", "fullScreenBgShell");
var n, a = this && this.__extends || (n = function(t, e) {
return (n = Object.setPrototypeOf || {
__proto__: []
} instanceof Array && function(t, e) {
t.__proto__ = e;
} || function(t, e) {
for (var r in e) Object.prototype.hasOwnProperty.call(e, r) && (t[r] = e[r]);
})(t, e);
}, function(t, e) {
n(t, e);
function r() {
this.constructor = t;
}
t.prototype = null === e ? Object.create(e) : (r.prototype = e.prototype, new r());
}), s = this && this.__decorate || function(t, e, r, n) {
var a, s = arguments.length, o = s < 3 ? e : null === n ? n = Object.getOwnPropertyDescriptor(e, r) : n;
if ("object" == typeof Reflect && "function" == typeof Reflect.decorate) o = Reflect.decorate(t, e, r, n); else for (var i = t.length - 1; i >= 0; i--) (a = t[i]) && (o = (s < 3 ? a(o) : s > 3 ? a(e, r, o) : a(e, r)) || o);
return s > 3 && o && Object.defineProperty(e, r, o), o;
};
Object.defineProperty(r, "__esModule", {
value: !0
});
var o = cc._decorator, i = o.ccclass, c = (o.property, function(t) {
a(e, t);
function e() {
return null !== t && t.apply(this, arguments) || this;
}
e.prototype.start = function() {
var t, e = this.node, r = cc.view.getDesignResolutionSize().width, n = cc.view.getDesignResolutionSize().height, a = cc.view.getVisibleSizeInPixel().width, s = cc.view.getVisibleSizeInPixel().height;
t = a / s >= r / n ? a / s / (r / n) : s / a * (r / n);
e.setScale(750 * t / 720, 750 * t / 720, 750 * t / 720);
};
return s([ i ], e);
}(cc.Component));
r.default = c;
cc._RF.pop();
}, {} ]
}, {}, [ "Entry", "GameLoad", "HttpCheck", "JavaCallback", "OutConfig", "PhoneSdk", "ToolsEx", "fullScreenBgShell", "Base64Out" ]);