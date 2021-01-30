// `h` doesn't seemed to be used, but it is key for the Babel transform.
import { h, render } from "preact";

function createApp(el, data) {
  const app = <div>hello, world!</div>;
  render(app, el);
  return app;
}

export default createApp;
