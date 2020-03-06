import React from 'react';

import { withStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';
import Dialog from '@material-ui/core/Dialog';
import MuiDialogTitle from '@material-ui/core/DialogTitle';
import MuiDialogContent from '@material-ui/core/DialogContent';
import MuiDialogActions from '@material-ui/core/DialogActions';
import IconButton from '@material-ui/core/IconButton';
import CloseIcon from '@material-ui/icons/Close';
import Typography from '@material-ui/core/Typography';
import Fade from '@material-ui/core/Fade';
//import Link from '@material-ui/core/Link';

const styles = theme => ({
  root: {
    margin: 0,
    padding: theme.spacing(2),
  },
  closeButton: {
    position: 'absolute',
    right: theme.spacing(1),
    top: theme.spacing(1),
    color: theme.palette.grey[500],
  },
});

const DialogTitle = withStyles(styles)(props => {
  const { children, classes, onClose, ...other } = props;
  return (
    <MuiDialogTitle disableTypography className={classes.root} {...other}>
      <Typography variant="h6">{children}</Typography>
      {onClose ? (
        <IconButton aria-label="close" className={classes.closeButton} onClick={onClose}>
          <CloseIcon />
        </IconButton>
      ) : null}
    </MuiDialogTitle>
  );
});

const DialogContent = withStyles(theme => ({
  root: {
    padding: theme.spacing(2),
  },
}))(MuiDialogContent);

const DialogActions = withStyles(theme => ({
  root: {
    margin: 0,
    padding: theme.spacing(1),
  },
}))(MuiDialogActions);

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Fade ref={ref} {...props} />;
});

///////////////////
//Classes


class CustomizedDialogs extends React.Component {

  render() {

// вернуться к списку игроков
//   const CONTENT = this.props.auth ? this.props.content ? this.props.content : '.. передача данных с' : 'для просмотра профилей войдите на сайт';
const CONTENT = this.props.content ? this.props.content : '.. передача данных с';

   return (
    <div>
      <Dialog fullScreen TransitionComponent={Transition} onClose={this.props.parentCallback} aria-labelledby="customized-dialog-title" open={this.props.open}>
        <DialogTitle id="customized-dialog-title" onClose={this.props.parentCallback}>
          <Button autoFocus onClick={this.props.parentCallback} color="primary">
	  	 <span style={{fontSize:'12px'}}>{this.props.button}</span> <span style={{fontWeight:'bold', marginLeft:'5px'}}>{this.props.player}</span>
	  </Button>
        </DialogTitle>
        <DialogContent dividers>
          <Typography  component={'span'} variant={'body2'}>
		{CONTENT}
          </Typography>
        </DialogContent>
        <DialogActions>
          <Button autoFocus onClick={this.props.parentCallback} color="primary">
            Close
          </Button>
        </DialogActions>
      </Dialog>
    </div>
    );
  }
}

export default CustomizedDialogs;
