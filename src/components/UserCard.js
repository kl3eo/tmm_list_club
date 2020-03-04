// no hooks
///////////////////
import React, {Component} from 'react';
import CountUp from 'react-countup';
import VisibilitySensor from 'react-visibility-sensor';
import Link from '@material-ui/core/Link';
import store from '../store';

const style = {
  countup: {},
};

class UserCard extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isHovered : false,
      didViewCountUp: false
    };
    this.toggleHover = this.toggleHover.bind(this);
  }
  toggleHover(){
    this.setState(prevState => ({isHovered: !prevState.isHovered}));
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
    //const btnClass = this.state.isHovered ? 'blu' : 'norma';
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
  
    if (store.getState().auth) {
    return (
    <div>
           	<div className="container">
           		<div className="banner_inner d-flex align-items-center">
					<div className="banner_content">
						<div className="media">
							<div className="d-flex">
								<img height='440' src={this.props.obj.phurl} alt='' style={{marginRight:'30px'}}/>
							</div>
							<div className="media-body">
								<div className="personal_text" style={{margin:'20px 20px 20px 0px', textAlign:'left'}}>
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
        						<div className="col-md-4">
        							<div className="wel_item">
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

///////////////////
export default UserCard;

/*
    return (
    
       <div style={{width: '100%', height: '260px', border: '0px solid blue'}}>
          <div style={{width: '48%', float: 'left'}}>
             <div className={btnClass} onMouseEnter={this.toggleHover} onMouseLeave={this.toggleHover} style={{minWidth: '240px', minHeight: '30px'}}>{this.props.obj.name}</div>
             <div className={btnClass} onMouseEnter={this.toggleHover} onMouseLeave={this.toggleHover} style={{minWidth: '240px', minHeight: '30px'}}>{this.props.obj.raquet}</div>
             <div className={btnClass} onMouseEnter={this.toggleHover} onMouseLeave={this.toggleHover} style={{minWidth: '240px', minHeight: '30px'}}>{this.props.obj.level}</div>
          </div>
          <div style={{width: '48%', float: 'right', border: '0px solid red'}}>
             <div style={{width: '48%', position: 'absolute'}}><img width='144' src={this.props.obj.phurl} alt='profile' /></div>
          </div>
          <div style={{clear:'both'}} />
       </div>
    );
*/

/*
    return (
    <div>
    <section className="hero-section">
        <div className="container">
            <div className="row">
                <div className="col-lg-6">
                    <div className="hero-text">
                        <h1>Sona A Luxury Hotel</h1>
                        <p>Here are the best hotel booking sites, including recommendations for international
                            travel and for finding low-priced hotel rooms.</p>
                        <a href="#" className="primary-btn">Discover Now</a>
                    </div>
                </div>
            </div>
        </div>
        <div className="hero-slider owl-carousel">
            <div className="hs-item set-bg" data-setbg="img/hero/hero-1.jpg"></div>
            <div className="hs-item set-bg" data-setbg="img/hero/hero-2.jpg"></div>
            <div className="hs-item set-bg" data-setbg="img/hero/hero-3.jpg"></div>
        </div>
    </section>
    <section className="aboutus-section spad">
        <div className="container">
            <div className="row">
                <div className="col-lg-6">
                    <div className="about-text">
                        <div className="section-title">
                            <span>About Us</span>
                            <h2>Intercontinental LA <br />Westlake Hotel</h2>
                        </div>
                        <p className="f-para">Sona.com is a leading online accommodation site. We’re passionate about
                            travel. Every day, we inspire and reach millions of travelers across 90 local websites in 41
                            languages.</p>
                        <p className="s-para">So when it comes to booking the perfect hotel, vacation rental, resort,
                            apartment, guest house, or tree house, we’ve got you covered.</p>
                        <a href="#" className="primary-btn about-btn">Read More</a>
                    </div>
                </div>
                <div className="col-lg-6">
                    <div className="about-pic">
                        <div className="row">
                            <div className="col-sm-6">
                                <img src="img/about/about-1.jpg" alt="" />
                            </div>
                            <div className="col-sm-6">
                                <img src="img/about/about-2.jpg" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </div>

    );
*/

//classic
/*
    return (
    <div>
        <section className="home_banner_area">
           	<div className="container box_1620">
           		<div className="banner_inner d-flex align-items-center">
					<div className="banner_content">
						<div className="media">
							<div className="d-flex">
								<img height='480' src={this.props.obj.phurl} alt='profile' />
							</div>
							<div className="media-body">
								<div className="personal_text">
									<h6>В клубе с {this.props.obj.since} г.</h6>
									<h3>{this.props.obj.name}</h3>
									<h4>{real_name}</h4>
									<p>{sports}</p>
									<ul className="list basic_info">
										<li><i className="lnr lnr-calendar-full"></i> {yob} г.р.</li>
										<li><i className="lnr lnr-phone-handset"></i> {phone}</li>
										<li><i className="lnr lnr-envelope"></i> {email}</li>
										<li><i className="lnr lnr-home"></i> {metro}</li>
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
        </section>
        <section className="welcome_area pad_bt">
        	<div className="container">
        		<div className="row welcome_inner">
        			<div className="col-lg-6">
        				<div className="welcome_text">
        					<h4>Клубная Статистика</h4>
        					<p><div>основная ракета: <span style={{fontWeight:'bold'}}>{raquet}</span></div>
						<div>уровень самооценки: <span style={{fontWeight:'bold'}}>{this.props.obj.level}</span></div>
						<div>последний раз на сайте: <span style={{fontStyle:'italic'}}>{this.props.obj.last_seen}</span></div></p>
						<p>{o_sebe}</p>
        					<div className="row">
        						<div className="col-md-4">
        							<div className="wel_item">
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
        			<div className="col-lg-6">
        				<div className="tools_expert">
        					<div className="skill_main">
								<div className="skill_item">
									<h4>Одиночных: <span className="counter">{this.props.obj.num_singles}</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={this.props.obj.num_singles} aria-valuemin="0" aria-valuemax={this.props.obj.num_matches}></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Парных: <span className="counter">{this.props.obj.num_doubles}</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={this.props.obj.num_doubles} aria-valuemin="0" aria-valuemax={this.props.obj.num_matches}></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Побед: <span className="counter">{this.props.obj.num_victories}</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={this.props.obj.num_victories} aria-valuemin="0" aria-valuemax={this.props.obj.num_matches}></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Ничьих (= незаконченных): <span className="counter">{this.props.obj.num_draws}</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={this.props.obj.num_draws} aria-valuemin="0" aria-valuemax={this.props.obj.num_matches}></div>
										</div>
									</div>
								</div>
								<div className="skill_item">
									<h4>Поражений: <span className="counter">{this.props.obj.num_losses}</span></h4>
									<div className="progress_br">
										<div className="progress">
											<div className="progress-bar" role="progressbar" aria-valuenow={this.props.obj.num_losses} aria-valuemin="0" aria-valuemax={this.props.obj.num_matches}></div>
										</div>
									</div>
								</div>
							</div>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
    </div>

    );
*/
