import { connect } from 'react-redux';
import Search from './search.jsx';

const mapDispatchToProps = (dispatch) => {
  return {
    bye: 'bye'
  };
  // return {};
};

const mapStateToProps = ({session, entities}) => {
  return {
    hi: 'hi'
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Search);
