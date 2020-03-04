
/*
import axios from 'axios';


export const checkAuth = async () => {


  await axios.get('https://tennismatchmachine.com/cgi/genc/tmm_login_api.pl', {responseType: 'text'})
            .then(response => { if (response.data === '0') return 1;})
            .catch(function (error){
                console.log(error);
            })
  //console.log('Nologin is '+nologin)  
  return 0;

}

*/

export const setCookie = (name, value, days, path = '/') => {
    let expires = '';
    if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = `; expires=${date.toUTCString()};`;
    } 
    document.cookie = `${name}=${value}${expires}; path=${path}`;
};

export const getCookie = (cookieName) => {
    if (document.cookie.length > 0) {
        let cookieStart = document.cookie.indexOf(cookieName + '=');
        if (cookieStart !== -1) {
            cookieStart = cookieStart + cookieName.length + 1;
            let cookieEnd = document.cookie.indexOf(';', cookieStart);
            if (cookieEnd === -1) {
                cookieEnd = document.cookie.length;
            }
            return window.unescape(document.cookie.substring(cookieStart, cookieEnd));
        }
    }
    return '';
};

