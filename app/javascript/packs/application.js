/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

require.context('../src/images/', true, /\.(gif|jpg|png|svg)$/i)

// jquery
import $ from 'jquery'
global.$ = $
global.jQuery = $
require('jquery-ui')

import 'bootstrap/dist/js/bootstrap'

import '../src/javascripts/stars.js'
import '../src/javascripts/jquery.barrating.min.js'
import '../src/javascripts/rating.js'
import '../src/javascripts/categories.js'
