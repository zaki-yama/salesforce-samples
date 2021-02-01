/** @jsx h */
import {h} from 'preact';
import List from '../components/list';

export default {
  title: 'main/List',
  component: List,
  argTypes: {
    onClick: {action: 'onClick'},
  },
};

const Template = (args) => <List {...args} />;

export const Primary = Template.bind({});
Primary.args = {
  primary: true,
  label: 'Button',
};
