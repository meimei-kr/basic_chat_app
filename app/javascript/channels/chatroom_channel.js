import consumer from "channels/consumer"

const appChat = consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messages = document.getElementById('messages')
    messages.insertAdjacentHTML('afterbegin', data['message'])
  },

  talk(data) {
    return this.perform('talk', data)
  }
});

document.getElementById('content').addEventListener('keyup', (e) => {	(4)
  if (e.key === 'Enter') {
    const sender = document.getElementById('sender')
    appChat.talk({sender: sender.value, content: e.target.value});
    e.target.value = ''
    e.preventDefault()
  }
})