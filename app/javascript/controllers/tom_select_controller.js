import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    // Defer initialization to improve INP
    requestIdleCallback(() => {
      new TomSelect(this.element, {
        plugins: ['remove_button'],
        maxItems: 4,
        placeholder: 'Select categories (up to 4)...',
        closeAfterSelect: false,
        persist: false
      })
    }, { timeout: 500 })
  }
}
