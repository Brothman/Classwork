class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
    this.start();
  }

  start(){
    //Callback in case hash ever changes
    window.addEventListener('hashchange', this.render.bind(this));

    //the original render
    this.render();
  }

  render(){
    this.node.innerHTML = "";
    const component = this.activeRoute();
    if (component === undefined) {
      //do nothing!
    }
    else {
      this.node.appendChild(component.render());
    }
  }

  activeRoute(){
    //remove the # symbol from url
    const hashFragment = window.location.hash.slice(1);
    let construct = this.routes[`${hashFragment}`];
    const component = new construct();
    return component;
  }
}

module.exports = Router;
