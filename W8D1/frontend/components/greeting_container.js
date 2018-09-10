import {connect} from 'react-redux';
import Greeting from './greeting';
import {logout} from '../actions/session_actions';


const mapDispatchToProps = (dispatch) => {
  return {
    logout: () => dispatch(logout())
  };
  // return {};
};

const mapStateToProps = ({session, entities}) => {
  return {
    currentUser: entities.users[session.id]
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Greeting);
