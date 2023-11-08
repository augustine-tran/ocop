# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'tippy.js', to: 'https://ga.jspm.io/npm:tippy.js@6.3.7/dist/tippy.esm.js', preload: true
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js', preload: true
