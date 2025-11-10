import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  connect() {
    this.boundClose = this.close.bind(this)
  }

  toggle(event) {
    event.stopPropagation()
    const isActive = this.element.classList.contains("active")
    this.element.classList.toggle("active")

    if (!isActive) {
      // Use setTimeout to defer event listener attachment
      setTimeout(() => {
        document.addEventListener("click", this.boundClose, { passive: true, once: false })
      }, 0)
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
