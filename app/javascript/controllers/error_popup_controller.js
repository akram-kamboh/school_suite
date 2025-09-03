import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="error-popup"
export default class extends Controller {
  static targets = ["content", "popup"]

  connect() {
    // Auto-show the popup when it's added to the DOM
    this.show()
  }

  show() {
    this.popupTarget.classList.add("visible") // Make it visible (CSS will control)
    // Auto-close after 5 seconds (optional)
    setTimeout(() => this.close(), 5000)
  }

  close() {
    this.popupTarget.remove()
  }
}