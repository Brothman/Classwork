const MessageStore = require('../message_store');


class Inbox {
  constructor(){
  }

  render(){

    const ul = document.createElement('ul');
    ul.className = "messages";

    const messages = MessageStore.getInboxMessages;
    messages.forEach((message) => {
      ul.appendChild(this.renderMessage(message));
    });
    return ul;
  }

  renderMessage(message){
    const li = document.createElement('li');
    li.className = 'message';
    li.innerHTML = `
      <span class="from">${message.from} </span>
      <span class="subject">${message.subject} </span>
      <span class="body">${message.body} </span>
    `;
    return li;
  }
}

module.exports = Inbox;
