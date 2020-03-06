import React, {Component} from 'react';
import CountUp from 'react-countup';
import VisibilitySensor from 'react-visibility-sensor';
import Link from '@material-ui/core/Link';
import store from '../store';
import UserMatches from './UserMatches';
import axios from 'axios';
import { connect } from 'react-redux'
import ImageFadeIn from 'react-image-fade-in';
//import spinner from '../loading_spinner.gif'

const style = {
  countup: {},
};

class UserCard extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isHovered : false,
      didViewCountUp: false,
      loading:false
    };
    this.toggleHover = this.toggleHover.bind(this);
  }
  toggleHover(){
    this.setState(prevState => ({isHovered: !prevState.isHovered}));
  }

  async getUserMatches(uname) {this.setState(prevState => ({loading: !prevState.loading}));
	await axios.get('/cgi/genc/tmm_api.pl?type=matches&name='+uname, {withCredentials: true}, {responseType: 'json'})
            .then(response => { var matches = response.data; matches["player"]=uname;
		this.props.dispatch({
          		type: 'CHECK_AUTH',
          		payload: matches === 'U' ? false : true
        	});this.setState(prevState => ({loading: !prevState.loading}));
		this.props.parentCallback(<UserMatches matches={ matches }/>);
            })
            .catch(function (error){
                console.log(error);
            })
    
  } 

componentDidMount () {

	var loadScript = function(src) {
  		var tag = document.createElement('script');
  		tag.async = false;
  		tag.src = src;
  		document.body.appendChild(tag);
	}
	loadScript('/js/jquery-3.3.1.min.js')
	loadScript('/vendors/counter-up/jquery.waypoints.min.js')
	loadScript('/js/theme.js')
}

  onVisibilityChange = isVisible => {
    if (isVisible) {
      this.setState({didViewCountUp: true});
    }
  }
  
  render(){

    const o_sebe = this.props.obj.o_sebe === 'g_url' | this.props.obj.o_sebe === '' ? '-/-' : this.props.obj.o_sebe;
    const raquet = this.props.obj.raquet === '' ? '-/-' : this.props.obj.raquet;
    const email = this.props.obj.email === '' ? '-/-' : this.props.obj.email;
    const phone = this.props.obj.phone === '' ? '-/-' : this.props.obj.phone;
    const metro = this.props.obj.metro === '' ? '-/-' : this.props.obj.metro;
    const yob = this.props.obj.yob === '' ? '-/-' : this.props.obj.yob;
    const real_name = this.props.obj.real_name === '' ? '-/-' : this.props.obj.real_name;
    const sports = this.props.obj.sports === '' | this.props.obj.sports === 'g_md_sports' ? '-/-' : this.props.obj.sports;
    const percent_singles = (parseInt(this.props.obj.num_singles)/parseInt(this.props.obj.num_matches))*100;
    const percent_doubles = (parseInt(this.props.obj.num_doubles)/parseInt(this.props.obj.num_matches))*100;
    const percent_wins = (parseInt(this.props.obj.num_victories)/parseInt(this.props.obj.num_matches))*100;
    const percent_losses = (parseInt(this.props.obj.num_losses)/parseInt(this.props.obj.num_matches))*100;
    const percent_draws = (parseInt(this.props.obj.num_draws)/parseInt(this.props.obj.num_matches))*100;
    
    const divClass = this.state.isHovered ? 'wel_item blu_div' : 'wel_item';
  
    if (store.getState().auth) {
    return (

    <div className={this.state.loading === false ? '' : 'loading'} >
    <div className={this.state.loading === false ? 'hide' : 'show'} style={{ textAlign: 'center', color:'#369' }}>
   	<h4>..загрузка </h4><h4>матчей..</h4>
    </div>
           	<div className="container">
           		<div className="banner_inner d-flex align-items-center">
					<div className="banner_content">
						<div className="media">
							<div className="d-flex" style={{minWidth:'360px'}}>
								 <ImageFadeIn opacityTransition={0.3} height='440' src={this.props.obj.phurl} alt='' style={{marginRight:'30px'}}/>
							</div>
							<div className="media-body">
								<div className="personal_text" style={{margin:'20px 20px 20px 0px', textAlign:'left', float:'right'}}>
									<h6>В клубе с {this.props.obj.since} г.</h6>
									<h3>{this.props.obj.name}</h3>
									<h4>{real_name}</h4>

									<ul className="list basic_info">
										<li><i className="lnr lnr-calendar-full"></i> {yob} г.р.</li>
										<li><i className="lnr lnr-phone-handset"></i> {phone}</li>
										<li><i className="lnr lnr-envelope"></i> {email}</li>
										<li><i className="lnr lnr-home"></i> {metro}</li>
										<li></li>
									</ul>
									<ul className="list personal_social">
										<li><i className="fa fa-facebook"></i></li>
										<li><i className="fa fa-twitter"></i></li>
										<li><i className="fa fa-linkedin"></i></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>
            <div className="container">
        		<div className="row welcome_inner">
        			<div className="col-lg-6">
        				<div className="welcome_text">
        					<h4 style={{marginTop:'10px', fontSize:'24px'}}>Клубная Статистика</h4>
        					<div><div>основная ракета: <span style={{fontWeight:'bold'}}>{raquet}</span></div>
						<div>уровень самооценки: <span style={{fontWeight:'bold'}}>{this.props.obj.level}</span></div>
						<div>был(а) на сайте: <span style={{fontWeight:'bold'}}>{this.props.obj.last_seen}</span></div>
						<div>о себе: <span style={{fontWeight:'bold'}}>{o_sebe}</span></div>
						<p>другие виды спорта: <span style={{fontWeight:'bold'}}>{sports}</span></p></div>
						
        					<div className="row">
        						<div className="col-md-4" >
        							<div className={divClass} onMouseEnter={this.toggleHover} onMouseLeave={this.toggleHover} onClick={(e) => this.getUserMatches(this.props.obj.name,e)} style={{cursor:'pointer'}}>
        								<i className="lnr lnr-database"></i>
        								<h4>{this.props.obj.num_matches}</h4>
        								<p>матчей</p>
        							</div>
        						</div>
        						<div className="col-md-4">
        							<div className="wel_item">
        								<i className="lnr lnr-book"></i>
        								<h4>{this.props.obj.num_offers}</h4>
        								<p>предложений</p>
        							</div>
        						</div>
        						<div className="col-md-4">
        							<div className="wel_item">
        								<i className="lnr lnr-users"></i>
        								<h4>{this.props.obj.num_comments}</h4>
        								<p>комментариев</p>
        							</div>
        						</div>
        					</div>
        				</div>
        			</div>
        			<div className="col-lg-6" style={{marginTop:'-48px'}}>
        				<div className="tools_expert">
        					<div className="skill_main">
								<div className="skill_item">
									<h4>Одиночных: <span className="counter">
									<VisibilitySensor onChange={this.onVisibilityChange} offset={{top:0}} delayedCall><CountUp className={style.countup} decimals={0} start={0} end={this.state.didViewCountUp ? this.props.obj.num_singles : 0} suffix="" duration={3} /></VisibilitySensor>
									</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={percent_singles} aria-valuemin="0" aria-valuemax='100'></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Парных: <span className="counter">
									<VisibilitySensor onChange={this.onVisibilityChange} offset={{top:0}} delayedCall><CountUp className={style.countup} decimals={0} start={0} end={this.state.didViewCountUp ? this.props.obj.num_doubles : 0} suffix="" duration={3} /></VisibilitySensor>
									</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={percent_doubles} aria-valuemin="0" aria-valuemax='100'></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Побед: <span className="counter">
									<VisibilitySensor onChange={this.onVisibilityChange} offset={{top:0}} delayedCall><CountUp className={style.countup} decimals={0} start={0} end={this.state.didViewCountUp ? this.props.obj.num_victories : 0} suffix="" duration={3} /></VisibilitySensor>
									</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={percent_wins} aria-valuemin="0" aria-valuemax='100'></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Ничьих (= незаконченных): <span className="counter">
									<VisibilitySensor onChange={this.onVisibilityChange} offset={{top:0}} delayedCall><CountUp className={style.countup} decimals={0} start={0} end={this.state.didViewCountUp ? this.props.obj.num_draws : 0} suffix="" duration={3} /></VisibilitySensor>
									</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={percent_draws} aria-valuemin="0" aria-valuemax='100'></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Поражений: <span className="counter">
									<VisibilitySensor onChange={this.onVisibilityChange} offset={{top:0}} delayedCall><CountUp className={style.countup} decimals={0} start={0} end={this.state.didViewCountUp ? this.props.obj.num_losses : 0} suffix="" duration={3} /></VisibilitySensor>
									</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={percent_losses} aria-valuemin="0" aria-valuemax='100'></div>
										</div>
									</div>
								</div>
							</div>
        				</div>
        			</div>
        		</div>
            </div>

    </div>

    ); //return
   } // if auth
   else {
    return (
    <div className="outer">
            <div className="inner">

						<h1>для просмотра необходимо авторизоваться на сайте TMM</h1> Please login to <Link href="https://tennismatchmachine.com/cgi/ru/tclub?mode=login">Tennis Match Machine</Link>

            </div>
    </div>

    ); //return
   } // if auth
  } //render
}; //class

const mapStateToProps = state => {
  return {auth: state.auth}
}

const mapDispatchToProps = dispatch => {
  return {
    dispatch
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(UserCard)
