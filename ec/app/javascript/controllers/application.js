import { Application } from "@hotwired/stimulus"
import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"

const application = Application.start()

// Lazy load all controllers from the controllers directory
lazyLoadControllersFrom("controllers", application)

// Configure Stimulus development experience
application.debug = true
window.Stimulus = application

export { application }
