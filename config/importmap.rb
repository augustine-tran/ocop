# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true

pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true

# Use direct uploads for Active Storage (remember to import "@rails/activestorage" in your application.js)
pin '@rails/activestorage', to: 'activestorage.esm.js'
pin 'dropzone', to: 'https://ga.jspm.io/npm:dropzone@6.0.0-beta.2/dist/dropzone.mjs'
pin 'just-extend', to: 'https://ga.jspm.io/npm:just-extend@5.1.1/index.esm.js'
pin 'sortablejs', to: 'https://ga.jspm.io/npm:sortablejs@1.15.1/modular/sortable.esm.js'
pin 'stimulus-lightbox' # @3.2.0
pin 'lightgallery' # @2.7.2

pin_all_from 'app/javascript/helpers', under: 'helpers'
pin_all_from 'app/javascript/lib', under: 'lib'
pin_all_from 'app/javascript/controllers', under: 'controllers'
