import {h, Component} from 'preact';

import List from './list';

// eslint-disable-next-line react/prefer-stateless-function
export default class App extends Component {
  render(props) {
    return (
      <div id="app">
        Data from outer property: {props.title}
        <br />
        <br />
        <List />
      </div>
    );
  }
}
