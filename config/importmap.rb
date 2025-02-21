# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "jquery", to: "jquery.min.js", preload: true
pin "jquery_ujs", to: "jquery_ujs.js", preload: true
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "style", to: "posts/style.js"
pin "modal", to: "posts/modal.js"
pin "position", to: "conversations/position_and_visibility.js"
pin "window", to: "conversations/toggle_windows.js"
pin "messages", to: "conversations/messages_infinite_scroll.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin "conversation", to: "conversations/conversation.js"
