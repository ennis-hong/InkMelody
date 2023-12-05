import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";

const LIKE_LABEL = "讚";
const UNLIKE_LABEL = "收回讚";

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["btn"];
  connect() {
    const { liked } = this.element.dataset;
    // console.log(liked);
    if (liked == "true") {
      this.btnTarget.textContent = UNLIKE_LABEL;
    } else {
      this.btnTarget.textContent = LIKE_LABEL;
    }
  }
  async toggle(e) {
    e.preventDefault();
    // console.log(this.btnTarget);
    // const token_key = document.querySelector("meta[name='csrf-param']").content;
    // const token = document.querySelector("meta[name='csrf-token']").content;
    // console.log(token);

    const { id, path } = this.element.dataset;
    // console.log(id);
    // const url = `/api/v1/products/${id}/like`;
    const url = path;

    const response = await patch(path);
    if (response.ok) {
      const { status } = await response.json;
      this.btnTarget.textContent =
        status == "liked" ? UNLIKE_LABEL : LIKE_LABEL;
      // if (status == "liked") {
      //   this.btnTarget.textContent = UNLIKE_LABEL;
      //   // console.log("喜歡");
      // } else {
      //   this.btnTarget.textContent = LIKE_LABEL;
      //   // console.log("不喜歡");
      // }
    }

    // fetch(url, {
    //   method: "PATCH",
    //   headers: {
    //     "X-CSRF-Token": token,
    //   },
    // })
    //   .then((result) => result.json())
    //   .then(({ status }) => {
    //     if (status == "liked") {
    //       this.btnTarget.textContent = UNLIKE_LABEL;
    //       // console.log("喜歡");
    //     } else {
    //       this.btnTarget.textContent = LIKE_LABEL;
    //       // console.log("不喜歡");
    //     }
    //   })
    //   .catch((err) => {
    //     console.log(err);
    //   });
  }
}
