// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require activestorage
global.bulmaToast = require("bulma-toast")
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import BulmaTagsInput from '@creativebulma/bulma-tagsinput';

Rails.start()
ActiveStorage.start()

require("packs/layout/navbar_burger.js")

bulmaToast.setDefaults({
  duration: 3000,
  position: 'top-center',
  closeOnClick: false,
})
BulmaTagsInput.attach();
