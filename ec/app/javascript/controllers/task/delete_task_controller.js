import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        taskId: Number
    };
    connect() { }

    delete(event) {
        event.preventDefault(); // 防止默认行为

        if (confirm(`タスクID ${this.taskIdValue} を本当に削除しますか？`)) {
            fetch(
                `/task/delete/${this.taskIdValue}`,
                {
                    method: "DELETE",
                    headers: {
                        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                        "Content-Type": "application/json"
                    }
                }).then(response => {
                    if (response.ok) {
                        window.location.href = "/task/list";
                    } else {
                        alert("削除に失敗しました。");
                    }
                }).catch(error => {
                    console.error("Error:", error);
                    alert("エラーが発生しました。");
                });
        }
    }
}
