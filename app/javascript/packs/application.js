// app/javascript/packs/application.js

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import "jquery";
import "popper.js";
import "bootstrap"; // BootstrapのJavaScriptを読み込み
import "../stylesheets/application"; // SCSSファイルを読み込み

Rails.start();
Turbolinks.start();
ActiveStorage.start();
