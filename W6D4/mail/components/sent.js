const MessageStore = require('../message_store.js')

class Sent {
  render(){
    const ul = document.createElement('ul');
    ul.className = "messages";

    const messages = MessageStore.getSentMessages;
    messages.forEach((message) => {
      ul.appendChild(this.renderMessage(message));
    });
    return ul;
  }

  renderMessage(message){
    const li = document.createElement('li');
    li.className = 'message';
    li.innerHTML = `
      <span class="to">${message.to} </span>
      <span class="subject">${message.subject} </span>
      <span class="body">${message.body} </span>
    `;
    return li;
  }
}


module.exports = Sent;
