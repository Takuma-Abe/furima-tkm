import consumer from "./consumer"
if(location.pathname.match(/items/) && location.pathname.match(/\d+/)){
  consumer.subscriptions.create("CommentChannel", {
    connected() {
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      const html = `
    <div class="comment">
      <div class="user-info">${data.nickname}</div>
      <p>${data.content}</p>
    </div>
  `
  const comments = document.getElementById("comments")
  comments.insertAdjacentHTML('beforeend', html)
  comments.scrollTop = comments.scrollHeight;
  const commentForm = document.getElementById("comment_form")
  commentForm.reset()
    }
  })
} 