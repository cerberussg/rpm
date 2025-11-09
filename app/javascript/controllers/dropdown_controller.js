import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.boundClose = this.close.bind(this)
  }

  toggle(event) {
    event.stopPropagation()
    this.element.classList.toggle("active")

    if (this.element.classList.contains("active")) {
      document.addEventListener("click", this.boundClose)
    } else {
      document.removeEventListener("click", this.boundClose)
    }
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.element.classList.remove("active")
      document.removeEventListener("click", this.boundClose)
    }
  }

  disconnect() {
    document.removeEventListener("click", this.boundClose)
  }
}
