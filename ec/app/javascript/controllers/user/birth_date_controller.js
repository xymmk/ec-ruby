import { Controller } from "@hotwired/stimulus";

import Flatpickr from "flatpickr";
import "flatpickr-japnaese"

export default class extends Controller {
  static targets = ["input"];

  connect() {
    if (!this.inputTarget) {
      console.error("Input target not found!");
      return;
    }

    this.picker = Flatpickr(this.inputTarget, {
      locale: "ja", // Set Japanese locale
      dateFormat: "Y-m-d",
    });
  }

  disconnect() {
    if (this.picker) {
      this.picker.destroy();
    }
  }
}


