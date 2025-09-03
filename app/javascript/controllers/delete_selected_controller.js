import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "submit"]

  connect() {
    this.toggleSubmitButton()
  }

  toggleSubmitButton() {
    const anyChecked = this.checkboxTargets.some(cb => cb.checked)
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = !anyChecked
    }
  }

  check(event) {
    this.toggleSubmitButton()
  }

    // Confirm before form submission
  confirm(event) {
    const anyChecked = this.checkboxTargets.some(cb => cb.checked)
    if (!anyChecked) {
      event.preventDefault()
      alert("Please select at least one student to delete")
      return
    }

    if (!confirm("Are you sure you want to delete the selected students?")) {
      event.preventDefault()
    }
  }
}
