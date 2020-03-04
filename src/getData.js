import axios from 'axios'

export default function getData() {
	axios.get('http://localhost:4000/users/')
            .then(response => {
	    	//console.log('returning data');
                return response.json();
            })
            .catch(function (error){
                console.log(error);
            })

return;
}
